//
//  Restaurant.h
//  FoodPin
//
//  Created by Mohamed Ragab on 8/4/16.
//  Copyright © 2016 Mohamed Ragab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Restaurant : NSManagedObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSData* image;
@property (strong, nonatomic) NSString* restaurantLocation;
@property (strong, nonatomic) NSString* restaurantType;
@property (strong, nonatomic) NSNumber* isVisited;
@property (strong, nonatomic) NSString* rating;
@property (strong, nonatomic) NSString* phoneNumber;

//-(Restaurant*)initWithName:(NSString*)name image:(NSData*)image location:(NSString*)location type:(NSString*)type;
@end
