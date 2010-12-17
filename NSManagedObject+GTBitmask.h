//
//  NSManagedObject+GTBitmask.h
//
//  Created by Andrew Mackenzie-Ross on 17/12/10.
//

#import <Foundation/Foundation.h>

@class GTBitmask;

@interface NSManagedObject (GTBitmaskAdditions) 
- (id) valueForUndefinedKey:(NSString *)key;
- (void) setValue:(id)value forUndefinedKey:(NSString *)key;
@end
