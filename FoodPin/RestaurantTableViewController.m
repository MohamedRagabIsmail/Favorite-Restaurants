//
//  RestaurantTableViewController.m
//  FoodPin
//
//  Created by Mohamed Ragab on 8/2/16.
//  Copyright © 2016 Mohamed Ragab. All rights reserved.
//

#import "RestaurantTableViewController.h"
#import "RestaurantTableViewCell.h"
#import "RestaurantDetailViewController.h"
#import "Restaurant.h"
#import "AddRestaurantController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"







@interface RestaurantTableViewController ()

@property (strong, nonatomic) NSMutableArray* restaurants;

@property (strong, nonatomic) NSFetchedResultsController* fetchResultController;

@property (strong,nonatomic)  NSManagedObjectContext * managedObjectContext;

@property (strong,nonatomic) UISearchController* searchController;

@property (strong, nonatomic) NSArray* searchResults;

@end

@implementation RestaurantTableViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.hidesBarsOnSwipe = true;
}

-(void) retrieveFromCoreDataForTable{
    NSFetchRequest* fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Restaurant"];
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:true];
    fetchRequest.sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    if(self.managedObjectContext)
    {
        self.fetchResultController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
        self.fetchResultController.delegate = self;
        NSError* error;
        if(![self.fetchResultController performFetch:&error])
        {
            NSLog(@"Error retrieving");
        }
        else
        {
            self.restaurants = [NSMutableArray arrayWithArray:[self.fetchResultController fetchedObjects]];
        }
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNeedsStatusBarAppearanceUpdate];
    /*
    self.restaurants = [NSMutableArray arrayWithObjects:
                        [[Restaurant alloc]initWithName:@"restaurantOne" image:(NSData*)[UIImage imageNamed: @"cafedeadend"] location:@"Cairo" type:@"typeOne"],
        [[Restaurant alloc]initWithName:@"restaurantTwo" image:(NSData*)[UIImage imageNamed:@"homei"] location:@"Alexandria" type:@"typeTwo"],
        [[Restaurant alloc]initWithName:@"restaurantThree" image:(NSData*)[UIImage imageNamed:@"teakha"] location:@"Giza" type:@"typeThree"] ,nil];
    */
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self retrieveFromCoreDataForTable];
    
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = false;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.searchResults = [[NSMutableArray alloc]init];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.searchController.active) {
        return self.searchResults.count;
    } else {
        return self.restaurants.count;
    }
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantTableViewCell *cell = (RestaurantTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Restaurant* restaurant = (self.searchController.active)? [self.searchResults objectAtIndex:indexPath.row]:[self.restaurants objectAtIndex:indexPath.row];
    
    // Configure the cell...
    cell.nameLabel.text = [restaurant name] ;
    cell.locationLabel.text = [restaurant restaurantLocation] ;
    cell.typeLabel.text = [restaurant restaurantType];

    cell.thumbnailImageView.image = [UIImage imageWithData:[restaurant image]];
    if([[restaurant isVisited] isEqualToNumber:[NSNumber numberWithBool:true]])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertController* optionMenu = [UIAlertController alertControllerWithTitle:nil message:@"What do you want to do?" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [optionMenu addAction:cancelAction];
    
    void (^callActionHandler)() = ^() {
        UIAlertController* alertMessage = [UIAlertController alertControllerWithTitle:@"Service Unavailable" message:@"Sorry, the call feature is not available yet. Please retry later." preferredStyle:UIAlertControllerStyleAlert];
        
        [alertMessage addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alertMessage animated:true completion:nil];
    };

    
    UIAlertAction* callAction = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"Call %d", indexPath.row] style:UIAlertActionStyleDefault handler:callActionHandler];
    
    [optionMenu addAction:callAction];
    
    UIAlertAction* isVisitedAction = [UIAlertAction actionWithTitle:@"I have been here" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
        
        [self.restaurantIsVisited replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
    }];
    
    [optionMenu addAction:isVisitedAction];

    
    [self presentViewController:optionMenu animated:true completion:nil];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:false];
}*/

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return (!self.searchController.active);
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        /*
        // Delete the row from the data source
        [self.restaurants removeObjectAtIndex: indexPath.row];
        
        //[self.tableView reloadData];
        NSArray* indexPathesToDelete = [NSArray arrayWithObjects:indexPath, nil];
        //[self.tableView deleteRowsAtIndexPaths:indexPathesToDelete withRowAnimation:UITableViewRowAnimationFade];
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSManagedObjectContext * managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
        if(managedObjectContext)
        {
            NSFetchRequest* fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Restaurant"];
            NSFetchedResultsController* fetchResultController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
            fetchResultController.delegate = self;

            NSManagedObject *managedObject = [fetchResultController objectAtIndexPath:indexPath];
            [managedObjectContext deleteObject:managedObject];
            [managedObjectContext save:nil];
        }
        */
        //[self deleteFromTable:indexPath];

    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    
}

- (NSArray<UITableViewRowAction*>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction* shareAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Share" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSString* defaultText = [NSString stringWithFormat: @"Just checked in at %@", [[self.restaurants objectAtIndex:indexPath.row] name]];
        UIImage* imageToShare = [UIImage imageNamed:@"barrafina"];
        NSArray* defaultSharedItemsArray = [NSArray arrayWithObjects:defaultText, imageToShare, nil];
        UIActivityViewController* activityController = [[UIActivityViewController alloc]initWithActivityItems:defaultSharedItemsArray applicationActivities:nil];
        [self presentViewController: activityController animated:true completion:nil];}];
        
        UITableViewRowAction* deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            //[self.restaurants removeObjectAtIndex: indexPath.row];
            //[self.tableView reloadData];
            //NSArray* indexPathesToDelete = [NSArray arrayWithObjects:indexPath, nil];
            //[self.tableView deleteRowsAtIndexPaths:indexPathesToDelete withRowAnimation:UITableViewRowAnimationFade];
            
            [self deleteFromTableCoreData:indexPath];
        }];
    
    shareAction.backgroundColor = [UIColor blueColor];
    
    return [NSArray arrayWithObjects:shareAction, deleteAction, nil];

}

-(void) deleteFromTableCoreData:(NSIndexPath*) indexPath {
    NSFetchRequest* fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Restaurant"];
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:true];
    fetchRequest.sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    //NSManagedObjectContext * managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    if(self.managedObjectContext)
    {
        //NSFetchedResultsController* fetchResultController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
        //fetchResultController.delegate = self;
        /*
        NSError* error;
        if(![fetchResultController performFetch:&error])
        {
            NSLog(@"Error deleting");
        }
        else
        {
            NSManagedObject *managedObject = [fetchResultController objectAtIndexPath:indexPath];
            [managedObjectContext deleteObject:managedObject];
            [managedObjectContext save:&error];
        }
         */
        NSManagedObject *managedObject = [self.fetchResultController objectAtIndexPath:indexPath];
        [self.managedObjectContext deleteObject:managedObject];
        [self.managedObjectContext save:nil];

    }
}


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

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            [tableView reloadData];
            break;
    }
    
    self.restaurants = [NSMutableArray arrayWithArray:controller.fetchedObjects];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)filterContentForSearchText:(NSString*)searchText {
    self.searchResults = [self.restaurants filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return [[evaluatedObject valueForKey:@"name"] localizedCaseInsensitiveContainsString:searchText];
    }]];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = searchController.searchBar.text;
    [self filterContentForSearchText:searchString];
    [self.tableView reloadData];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier  isEqual: @"showRestaurantDetail"])
    {
        NSIndexPath* indexPath = self.tableView.indexPathForSelectedRow;
        RestaurantDetailViewController* destinationController = (RestaurantDetailViewController*)[segue destinationViewController];
        destinationController.restaurant = (self.searchController.active)?[self.searchResults objectAtIndex:indexPath.row]:[self.restaurants objectAtIndex:indexPath.row];
        
    }
}

- (IBAction)unwindToHomeScreen:(UIStoryboardSegue *)segue
{
    //AddRestaurantController * addRestaurantController = segue.sourceViewController;
    //if(addRestaurantController.addedRestaurant)
    //{
        //[self.restaurants addObject:addRestaurantController.addedRestaurant];
        [self retrieveFromCoreDataForTable];
        [self.tableView reloadData];
    //}
}


@end
