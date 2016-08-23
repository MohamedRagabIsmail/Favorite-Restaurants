//
//  RestaurantTableViewCell.h
//  FoodPin
//
//  Created by Mohamed Ragab on 8/2/16.
//  Copyright © 2016 Mohamed Ragab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantTableViewCell : UITableViewCell

    @property (nonatomic, retain) IBOutlet UILabel *nameLabel;
    @property (nonatomic, retain) IBOutlet UILabel *locationLabel;
    @property (nonatomic, retain) IBOutlet UILabel *typeLabel;
    @property (nonatomic, retain) IBOutlet UIImageView *thumbnailImageView;

@end
