//
//  GTBitmask.h
//
//  Created by Andrew Mackenzie-Ross on 16/12/10.
//

#import <Foundation/Foundation.h>


@interface GTBitmask : NSObject {
	NSArray						*keys_;
	unsigned long long		bitmask_;
	NSString						*coreDataAttributeKey_;
	BOOL							dirty_;

}
@property (nonatomic, readonly) NSArray *keys; // orderd list of keys that the bitmask stores data to
@property (nonatomic, retain) NSNumber *bitmask; // the bitmask as an NSNumber
@property (nonatomic, assign) unsigned long long bitmaskUInt64; // the bitmask in it's native form
@property (nonatomic, copy) NSString *coreDataAttributeKey; // used for auto saving changes to core data attribute
@property (nonatomic, readonly, getter=isDirty) BOOL dirty; // when a value has been changed isDirty returns YES
- (void) clean; // removes dirty flag

- (id)initWithKeys:(NSArray*)keys;
- (BOOL)boolValueForKey:(NSString*)key; // get the bool value for a key
- (void)setBoolValue:(BOOL)value ForKey:(NSString*)key; // set the bool value for a key
- (NSString*)predicateForBoolValue:(BOOL)value withKey:(NSString*)key; // predicate for a single key

// this method enables complex predicates to be formed using a true GTBitmask and a false GTBitmask
// if a key is set to YES in the true GTBitmask then all records must have this set to true.
// if a key is set to YES in the false GTBitmask then all records must have this set to false also.
+ (NSString*)predicateStringFromTrueBitmask:(GTBitmask*)trueBitmask andFalseBitmask:(GTBitmask*)falseBitmask forCoreDataAttributeWithKey:(NSString*)key;
@end

