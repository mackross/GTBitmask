//
//  GTBitmask.m
//
//  Created by Andrew Mackenzie-Ross on 16/12/10.
//

#import "GTBitmask.h"
@interface GTBitmask ()
@end


@implementation GTBitmask
#pragma mark -
#pragma mark Properties
@synthesize bitmask = bitmaskData_;
@synthesize bitmaskChanged = bitmaskDataChanged_;
-(void) setBitmask:(unsigned long long)value {
	bitmaskData_ = value;
	bitmaskDataChanged_ = NO;
}
-(NSNumber*) bitmaskNumber {
	return [NSNumber numberWithInt:bitmaskData_];
}
-(void) setBitmaskNumber:(NSNumber *)value {
	self.bitmask = [value unsignedLongLongValue];
}

- (BOOL)boolValueForKey:(NSString*)key {
	// get index of key
	int indexInBitMask = -1;
	for (int i = 0; i < keys_.count; i++) {
		NSString *keyAtIndex = [keys_ objectAtIndex:i];
		BOOL equal = [keyAtIndex isEqualToString:key];
		if (equal) {
			indexInBitMask = i;
		}
	}
	if (indexInBitMask == -1) {
		NSException* myException = [NSException
											 exceptionWithName:@"UndefinedKey"
											 reason:@"Undefined key argument"
											 userInfo:nil];
		@throw myException;
		return NO;
	}
	// create and test bit
	unsigned long long bitToQuery = 1;
	bitToQuery = bitToQuery << indexInBitMask;
	return ((bitToQuery & bitmaskData_) == bitToQuery);
}
- (void)setBoolValue:(BOOL)value ForKey:(NSString*)key {
	// get index of key
	int indexInBitMask = -1;
	for (int i = 0; i < keys_.count; i++) {
		NSString *keyAtIndex = [keys_ objectAtIndex:i];
		BOOL equal = [keyAtIndex isEqualToString:key];
		if (equal) {
			indexInBitMask = i;
		}
	}
	if (indexInBitMask == -1) {
		NSException* myException = [NSException
											 exceptionWithName:@"UndefinedKey"
											 reason:@"Undefined key argument"
											 userInfo:nil];
		@throw myException;
		return;
	}
	// set value
	unsigned long long bitToChange = 1;
	bitToChange = bitToChange << indexInBitMask;
	if (value) {
		bitmaskData_ |= bitToChange;
	}
	else {
		bitToChange ^= ULONG_LONG_MAX; // flip bits
		bitmaskData_ &= bitToChange;
	}
	// mark bitmask as dirty
	bitmaskDataChanged_ = YES;
}
- (NSString*)predicateForBoolValue:(BOOL)value withKey:(NSString*)key onAttribute:(NSString*)attribute{
	// get index of key
	int indexInBitMask = -1;
	for (int i = 0; i < keys_.count; i++) {
		NSString *keyAtIndex = [keys_ objectAtIndex:i];
		BOOL equal = [keyAtIndex isEqualToString:key];
		if (equal) {
			indexInBitMask = i;
		}
	}
	if (indexInBitMask == -1) {
		NSException* myException = [NSException
											 exceptionWithName:@"UndefinedKey"
											 reason:@"Undefined key argument"
											 userInfo:nil];
		@throw myException;
		return nil;
	}
	// create bitmask and string
	unsigned long long bitToQuery = 1;
	bitToQuery = bitToQuery << indexInBitMask;
	if (value) {
		return [NSString stringWithFormat:@"%@ & %i == %i",attribute,bitToQuery,bitToQuery];
	}
	return [NSString stringWithFormat:@"%@ & %i == 0",attribute,bitToQuery];
}
#pragma mark -
#pragma mark NSObject
- (id) init {
	NSLog(@"GTCoreDataBitMask requires initWithKeys:andDataKeyPath:");
	return nil;
}
- (id) initWithKeys:(NSArray*)keys {
	if (self = [super init]) {
		keys_ = [keys copy];
	}
	return self;
}
- (void) dealloc {
	[super dealloc];
	[keys_ release];
	keys_ = nil;
}
@end
