//
//  Restaurant.m
//  FoodPin
//
//  Created by Mohamed Ragab on 8/4/16.
//  Copyright © 2016 Mohamed Ragab. All rights reserved.
//

#import "Restaurant.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"


@implementation Restaurant

@dynamic name;
@dynamic image;
@dynamic restaurantLocation;
@dynamic restaurantType;
@dynamic isVisited;
@dynamic rating;
@dynamic phoneNumber;




/*-(Restaurant*)initWithName:(NSString*)name image:(NSData*)image location:(NSString*)location type:(NSString*)type
{
    NSManagedObjectContext * managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Restaurant" inManagedObjectContext:managedObjectContext];    
    
    Restaurant* restaurant = [super initWithEntity:entityDescription insertIntoManagedObjectContext:managedObjectContext];
    if(restaurant)
    {
        restaurant.name = name;
        restaurant.image = image;
        restaurant.isVisited = [NSNumber numberWithBool:false];
        restaurant.rating = @"rating";
        restaurant.restaurantLocation = location;
        restaurant.restaurantType = type;
    }
    return restaurant;
}
*/
@end
