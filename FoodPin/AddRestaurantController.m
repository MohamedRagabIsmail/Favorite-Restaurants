//
//  AddRestaurantController.m
//  FoodPin
//
//  Created by Mohamed Ragab on 8/11/16.
//  Copyright © 2016 Mohamed Ragab. All rights reserved.
//

#import "AddRestaurantController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"


@interface AddRestaurantController ()

@end

@implementation AddRestaurantController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.restaurantName.delegate = self;
    self.restaurantLocation.delegate = self;
    self.restaurantType.delegate = self;
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row == 0)
    {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            UIImagePickerController* imagePicker = [[UIImagePickerController alloc]init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = false;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:true completion:nil];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    self.imageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = true;
    
    NSLayoutConstraint* leadingConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.imageView.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    leadingConstraint.active = true;
    
    NSLayoutConstraint* trailingConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.imageView.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    trailingConstraint.active = true;
    
    NSLayoutConstraint* topConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imageView.superview attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    topConstraint.active = true;
    
    NSLayoutConstraint* bottomConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.imageView.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    bottomConstraint.active = true;
    
    [self dismissViewControllerAnimated:true completion:nil];
}

-(IBAction) saveButtonClicked: (id) sender {
    
    if((![self.restaurantName.text  isEqual: @""])&&(![self.restaurantLocation.text  isEqual: @""])&&(![self.restaurantType.text  isEqual: @""]&&(self.isVisited)))
    {
        /*self.addedRestaurant = [[Restaurant alloc]initWithName:self.restaurantName.text image:UIImagePNGRepresentation([UIImage imageNamed:@"homei"]) location:self.restaurantLocation.text type:self.restaurantType.text];
        self.addedRestaurant.isVisited = self.isVisited;
        */
        
        NSManagedObjectContext * managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
        if(managedObjectContext)
        {
            Restaurant* restaurant = (Restaurant*)[NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:managedObjectContext];
            restaurant.name = self.restaurantName.text;
            restaurant.restaurantLocation = self.restaurantLocation.text;
            restaurant.restaurantType = self.restaurantType.text;
            restaurant.isVisited = self.isVisited;
            restaurant.rating = @"rating";
            if(self.imageView)
            {
                restaurant.image = UIImagePNGRepresentation(self.imageView.image);
            }
            NSError *error;
            if (![managedObjectContext save:&error]) {
                // Handle the error.
                NSLog(@"Error Saving");
            }
            
        }
        
        
        
        
        
        [self performSegueWithIdentifier:@"unwindToHomeScreen" sender:self];
    }
    else
    {/*
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing entry"
                                                        message:@"Please fill all fields"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
      */
        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"Missing entry"  message:@"Please fill all fields"  preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            //[self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    // Do something here with the variable 'sender'
}

-(IBAction) toggleBeenHereButton: (id) sender {

    
    if(sender == self.yesBeenThere)
    {
        self.isVisited = [NSNumber numberWithBool:true];
        self.yesBeenThere.backgroundColor = [UIColor redColor];
        self.notBeenThere.backgroundColor = [UIColor lightGrayColor];
        
    }else if(sender == self.notBeenThere)
    {
        self.isVisited = [NSNumber numberWithBool:false];
        self.yesBeenThere.backgroundColor = [UIColor lightGrayColor];
        self.notBeenThere.backgroundColor = [UIColor redColor];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Table view data source

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}
*/

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
