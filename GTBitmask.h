//
//  GTBitmask.h
//
//  Created by Andrew Mackenzie-Ross on 16/12/10.
//

#import <Foundation/Foundation.h>


@interface GTBitmask : NSObject {
	NSArray *keys_;
	unsigned long long bitmaskData_;
	BOOL bitmaskDataChanged_;
}
@property (nonatomic, readonly) BOOL bitmaskChanged;
@property (nonatomic, assign) unsigned long long bitmask;
@property (nonatomic, retain) NSNumber *bitmaskNumber;
- (id)initWithKeys:(NSArray*)keys;
- (BOOL)boolValueForKey:(NSString*)key;
- (void)setBoolValue:(BOOL)value ForKey:(NSString*)key;
- (NSString*)predicateForBoolValue:(BOOL)value withKey:(NSString*)key onAttribute:(NSString*)attribute;
@end

