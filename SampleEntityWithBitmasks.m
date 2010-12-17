// 
//  SampleEntityWithBitmasks.m
//  GTBitmask
//
//  Created by Andrew Mackenzie-Ross on 17/12/10.
//

#import "SampleEntityWithBitmasks.h"
#import "GTBitmask.h"

@implementation SampleEntityWithBitmasks 

@dynamic GTMorning;
@dynamic GTAfternoon;
@dynamic GTEvening;

@dynamic GTMonday;
@dynamic GTTuesday;
@dynamic GTWednesday;
@dynamic GTThursday;
@dynamic GTFriday;
@dynamic GTSaturday;
@dynamic GTSunday;

@dynamic name;
@dynamic daysOfTheWeekBitmask;
@dynamic partsOfTheDayBitmask;

- (void) setupBitmaks {
  NSArray *dotw = [NSArray arrayWithObjects:@"GTMonday",@"GTTuesday",@"GTWednesday",@"GTThursday",@"GTFriday",@"GTSaturday",@"GTSunday",nil];
	daysInTheWeek = [[GTBitmask alloc] initWithKeys:dotw];
	daysInTheWeek.coreDataAttributeKey = @"daysOfTheWeekBitmask";
	
	NSArray *potd = [NSArray arrayWithObjects:@"GTMorning",@"GTAfternoon",@"GTEvening",nil];
	partsOfTheDay = [[GTBitmask alloc] initWithKeys:potd];
	partsOfTheDay.coreDataAttributeKey = @"partsOfTheDayBitmask";
	
	daysInTheWeek.bitmask = self.daysOfTheWeekBitmask;
	partsOfTheDay.bitmask = self.partsOfTheDayBitmask;

}

-(void) awakeFromInsert {
	[super awakeFromInsert];
	[self setupBitmaks];

}
-(void) awakeFromFetch {
	[super awakeFromFetch];
	[self setupBitmaks];
}

- (void) didTurnIntoFault {
	[daysInTheWeek release];
	daysInTheWeek = nil;
	[partsOfTheDay release];
	partsOfTheDay = nil;
}
- (void) dealloc {
	[super dealloc];
	[daysInTheWeek release];
	daysInTheWeek = nil;
	[partsOfTheDay release];
	partsOfTheDay = nil;
}
@end
