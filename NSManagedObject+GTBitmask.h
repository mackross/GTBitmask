//
//  NSManagedObject+GTBitmask.h
//
//  Created by Andrew Mackenzie-Ross on 17/12/10.
//

#import <Foundation/Foundation.h>

@class GTBitmask;

@interface NSManagedObject (GTBitmaskAdditions) {

}
- (void) saveBitmask:(GTBitmask*)bitmask toAttribute:(NSString*)string; // insert in awake from fetch
- (void) loadBitmask:(GTBitmask*)bitmask fromAttribute:(NSString*)string; // insert in save
- (void) valueForUndefinedKey:(NSString *)key;
- (void) setValue:(id)value forUndefinedKey:(NSString *)key;
@end
