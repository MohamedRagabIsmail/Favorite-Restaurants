//
//  RestaurantDetailViewController.m
//  FoodPin
//
//  Created by Mohamed Ragab on 8/3/16.
//  Copyright © 2016 Mohamed Ragab. All rights reserved.
//

#import "RestaurantDetailViewController.h"
#import "Restaurant.h"
#import "RestaurantDetailTableViewCell.h"
#import "ReviewViewController.h"
#import "MapViewController.h"
#import "AppDelegate.h"





@interface RestaurantDetailViewController ()

@end

@implementation RestaurantDetailViewController

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.hidesBarsOnSwipe = false;
    [self.navigationController setNavigationBarHidden:false animated:true];
    [self.ratingButton setImage:[UIImage imageNamed:[self.restaurant rating]] forState:UIControlStateNormal];
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.restaurant.name;
    self.restaurantImageView.image = [UIImage imageWithData:[self.restaurant image]];
    self.tableView.backgroundColor = [UIColor colorWithRed:242.0f/255.0f green:245.0f/255.0f blue:214.0f/255.0f alpha:1.0f];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.separatorColor = [UIColor blackColor];
    [self.tableView setEstimatedRowHeight:36.0];
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        RestaurantDetailTableViewCell *cell = (RestaurantDetailTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
            cell.fieldLabel.text = @"Name";
            cell.valueLabel.text = self.restaurant.name;
            break;
        case 1:
            cell.fieldLabel.text = @"Location";
            cell.valueLabel.text = self.restaurant.restaurantLocation;
            break;
        case 2:
            cell.fieldLabel.text = @"Type";
            cell.valueLabel.text = self.restaurant.restaurantType;
            break;
        case 3:
            cell.fieldLabel.text = @"Been here";
            cell.valueLabel.text = ([self.restaurant.isVisited isEqualToNumber: [NSNumber numberWithBool:true]])? @"Yes, i have been here before":@"No";
            break;
        default:
            break;
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (IBAction) close: (UIStoryboardSegue*)segue
{
    ReviewViewController* reviewViewController = segue.sourceViewController;
    if(reviewViewController)
    {
        NSString* rating = reviewViewController.rating;
        if(rating)
        {
            //[self.ratingButton setImage: [UIImage imageNamed: rating] forState: UIControlStateNormal];
            self.restaurant.rating = reviewViewController.rating;
            
            NSManagedObjectContext * managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
            NSError* error;
            if(![managedObjectContext save:&error])
            {
                NSLog(@"error updating");
            }
            
        }
    }
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier  isEqual: @"showMap"])
    {
        MapViewController* destinationViewController = [segue destinationViewController];
        destinationViewController.restaurant = self.restaurant;
    }
}


@end
