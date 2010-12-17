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
@synthesize bitmaskUInt64 = bitmask_;
@synthesize dirty = dirty_;
@synthesize coreDataAttributeKey = coreDataAttributeKey_;
@synthesize keys = keys_;
-(void) setBitmaskUInt64:(unsigned long long)value {
	bitmask_ = value;
	dirty_ = NO;
}
-(NSNumber*) bitmask {
	return [NSNumber numberWithInt:bitmask_];
}
-(void) setBitmask:(NSNumber *)value {
	self.bitmaskUInt64 = [value unsignedLongLongValue];
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
	return ((bitToQuery & bitmask_) == bitToQuery);
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
		bitmask_ |= bitToChange;
	}
	else {
		bitToChange ^= ULONG_LONG_MAX; // flip bits
		bitmask_ &= bitToChange;
	}
	// mark bitmask as dirty
	dirty_ = YES;
}
- (NSString*)predicateForBoolValue:(BOOL)value withKey:(NSString*)key{
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
		return [NSString stringWithFormat:@"%@ & %i == %i",coreDataAttributeKey_,bitToQuery,bitToQuery];
	}
	return [NSString stringWithFormat:@"%@ & %i == 0",coreDataAttributeKey_,bitToQuery];
}
+ (NSString*)predicateStringFromTrueBitmask:(GTBitmask*)trueBitmask andFalseBitmask:(GTBitmask*)falseBitmask forCoreDataAttributeWithKey:(NSString*)key {
	if (trueBitmask && !falseBitmask) {
		return [NSString stringWithFormat:@"%@ & %i == %i",key,trueBitmask.bitmaskUInt64,trueBitmask.bitmaskUInt64];
	}
	else if (!trueBitmask && falseBitmask) {
		return [NSString stringWithFormat:@"%@ & %i == 0",key,falseBitmask.bitmaskUInt64];
	}
	return [NSString stringWithFormat:@"%@ & %i == %i",key,(trueBitmask.bitmaskUInt64+falseBitmask.bitmaskUInt64),trueBitmask.bitmaskUInt64];
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
	[coreDataAttributeKey_ release];
	coreDataAttributeKey_ = nil;
}
- (void) clean {
	dirty_ = NO;
}
@end
