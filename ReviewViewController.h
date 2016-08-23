//
//  ReviewViewController.h
//  FoodPin
//
//  Created by Mohamed Ragab on 8/9/16.
//  Copyright © 2016 Mohamed Ragab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewViewController : UIViewController
@property (nonatomic, retain) IBOutlet UIImageView* backgroundImageView;
@property (nonatomic, retain) UIVisualEffectView* blurEffectView;
@property (nonatomic, retain) IBOutlet UIStackView* ratingStackView;
@property (nonatomic, retain) NSString* rating;
@end
