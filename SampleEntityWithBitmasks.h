//
//  SampleEntityWithBitmasks.h
//  GTBitmask
//
//  Created by Andrew Mackenzie-Ross on 17/12/10.
//

#import <CoreData/CoreData.h>
#import "NSManagedObject+GTBitmask.h"

@class GTBitmask;
@interface SampleEntityWithBitmasks :  NSManagedObject  
{
	GTBitmask *daysInTheWeek;
	GTBitmask *partsOfTheDay;
}


@property (nonatomic, copy) NSString * name;
@property (nonatomic, retain) NSNumber * daysOfTheWeekBitmask;
@property (nonatomic, retain) NSNumber * partsOfTheDayBitmask;

// these properties are all stored in partsOfTheDayBitmask


@property (nonatomic, retain) NSNumber * GTMorning;
@property (nonatomic, retain) NSNumber * GTAfternoon;
@property (nonatomic, retain) NSNumber * GTEvening;


// these properties are all stored in daysOfTheWeekBitmask
@property (nonatomic, retain) NSNumber * GTMonday;
@property (nonatomic, retain) NSNumber * GTTuesday;
@property (nonatomic, retain) NSNumber * GTWednesday;
@property (nonatomic, assign) NSNumber * GTThursday;
@property (nonatomic, retain) NSNumber * GTFriday;
@property (nonatomic, retain) NSNumber * GTSaturday;
@property (nonatomic, retain) NSNumber * GTSunday;

@end



