//
//  AddRestaurantController.h
//  FoodPin
//
//  Created by Mohamed Ragab on 8/11/16.
//  Copyright © 2016 Mohamed Ragab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"


@interface AddRestaurantController : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>
@property (nonatomic, retain) IBOutlet UIImageView * imageView;
@property (nonatomic, retain) IBOutlet UITextField * restaurantName;
@property (nonatomic, retain) IBOutlet UITextField * restaurantLocation;
@property (nonatomic, retain) IBOutlet UITextField * restaurantType;
@property (nonatomic, retain) IBOutlet UIButton * yesBeenThere;
@property (nonatomic, retain) IBOutlet UIButton * notBeenThere;
@property (nonatomic,retain) NSNumber* isVisited;
@property (nonatomic,retain) Restaurant* addedRestaurant;
@end
