//
//  ReviewViewController.m
//  FoodPin
//
//  Created by Mohamed Ragab on 8/9/16.
//  Copyright © 2016 Mohamed Ragab. All rights reserved.
//

#import "ReviewViewController.h"

@interface ReviewViewController ()

@end

@implementation ReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBlurEffect* blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    //self.blurEffectView.frame = self.backgroundImageView.bounds;
    self.blurEffectView.frame = self.view.bounds;
    [self.backgroundImageView addSubview:self.blurEffectView];
    CGAffineTransform translate = CGAffineTransformMakeTranslation(0, 500);
    CGAffineTransform scale = CGAffineTransformMakeScale(0, 0);
    self.ratingStackView.transform = CGAffineTransformConcat(scale, translate);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [UIView animateWithDuration:1 delay:0.0 usingSpringWithDamping: 0.3 initialSpringVelocity: 0.5 options:UIViewAnimationOptionTransitionNone  animations:^{
        //code with animation
        self.ratingStackView.transform = CGAffineTransformIdentity;
    } completion:nil];


}

- (IBAction) ratingSelected: (UIButton*)sender
{
    switch(sender.tag)
    {
        case 100: self.rating = @"dislike"; break;
        case 200: self.rating = @"good"; break;
        case 300: self.rating = @"great"; break;
        default:break;
    }
    [self performSegueWithIdentifier:@"unwindToDetailView" sender:sender];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
