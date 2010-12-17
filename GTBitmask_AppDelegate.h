//
//  GTBitmask_AppDelegate.h
//  GTBitmask
//
//  Created by Andrew Mackenzie-Ross on 17/12/10.
//

#import <Cocoa/Cocoa.h>

@interface GTBitmask_AppDelegate : NSObject 
{
    NSWindow *window;
    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
	NSPredicate *predicate;
}
@property (nonatomic, retain) IBOutlet NSPredicate *predicate;
@property (nonatomic, retain) IBOutlet NSWindow *window;

@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveAction:sender;
- (IBAction)togglePredicate:(id)sender ;
@end
