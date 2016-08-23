//
//  RestaurantDetailViewController.h
//  FoodPin
//
//  Created by Mohamed Ragab on 8/3/16.
//  Copyright © 2016 Mohamed Ragab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"


@interface RestaurantDetailViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) IBOutlet UIImageView* restaurantImageView;

@property (nonatomic, retain) IBOutlet UITableView* tableView;
@property (nonatomic, retain) Restaurant* restaurant;
@property (nonatomic, retain) IBOutlet UIButton* ratingButton;
@end
