//
//  NSManagedObject+GTBitmask.m
//
//  Created by Andrew Mackenzie-Ross on 17/12/10.
//

#import "NSManagedObject+GTBitmask.h"
#import "GTBitmask.h"
#import <objc/objc-runtime.h>


@implementation NSManagedObject (GTBitmaskAdditions)
static NSMutableArray *bitmasks;
- (void) findBitmaskIvars {
	bitmasks = [[NSMutableArray alloc] init];
	unsigned int count;
	Ivar* ivars = class_copyIvarList([self class], &count);
	for(unsigned int i = 0; i < count; ++i)
	{
		
		NSString *ivarName = [NSString stringWithCString:ivar_getName(ivars[i]) encoding:NSASCIIStringEncoding];
		id ivar = [self valueForKey:ivarName];
		if ([ivar class] == [GTBitmask class]) {
			[bitmasks addObject:ivarName];
		}
	}
	free(ivars);
	
}
- (id) valueForUndefinedKey:(NSString *)key {
	// find bitmask ivars
	if (!bitmasks) {
		[self findBitmaskIvars];
	}
	
	// search for key and return value
	BOOL boolValue;
	BOOL keyfound = NO;
	for ( NSString *ivarName in bitmasks) {
		GTBitmask *bitmask = [self valueForKey:ivarName];
		for (NSString *bitmaskKey in bitmask.keys) {
			if ([bitmaskKey isEqualToString:key]) {
				keyfound = YES;
				[self willAccessValueForKey:bitmask.coreDataAttributeKey];
				[self willAccessValueForKey:key];
				boolValue = [bitmask boolValueForKey:key];
				[self didAccessValueForKey:bitmask.coreDataAttributeKey];
				[self didAccessValueForKey:key];
				break;
			}
		}
	}
	
	if (!keyfound) {
		NSException *exception = [NSException exceptionWithName:@"Undefined Key"
																		 reason:@"No value for key found"
																	  userInfo:nil];
		@throw exception;
	}
	return [NSNumber numberWithBool:boolValue];
}
- (void) setValue:(id)value forUndefinedKey:(NSString *)key {
	// find bitmask ivars
	if (!bitmasks) {
		[self findBitmaskIvars];
	}
	
	// search for key and save
	BOOL keyfound = NO;
	for ( NSString *ivarName in bitmasks) {
		GTBitmask *bitmask = [self valueForKey:ivarName];
		for (NSString *bitmaskKey in bitmask.keys) {
			if ([bitmaskKey isEqualToString:key]) {
				keyfound = YES;
				[self willChangeValueForKey:key];
				[bitmask setBoolValue:[(NSNumber*)value boolValue] ForKey:key];
				[self setValue:bitmask.bitmask forKey:bitmask.coreDataAttributeKey];
				[bitmask clean];
				[self didChangeValueForKey:key];
				break;
			}
		}
	}
	
	if (!keyfound) {
		NSException *exception = [NSException exceptionWithName:@"Undefined Key"
																		 reason:@"No value for key found"
																	  userInfo:nil];
		@throw exception;
	}
	return;
}
@end
