//
//  MapViewController.m
//  FoodPin
//
//  Created by Mohamed Ragab on 8/10/16.
//  Copyright © 2016 Mohamed Ragab. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mapView.delegate = self;
    
    self.mapView.showsCompass = true;
    self.mapView.showsScale = true;
    self.mapView.showsTraffic = true;
    
    CLGeocoder* geoCoder = [[CLGeocoder alloc]init];
    [geoCoder geocodeAddressString:self.restaurant.restaurantLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(error)
        {
            NSLog(@"Error");
            return;
        }
        
        if([placemarks objectAtIndex:0])
        {
            MKPointAnnotation* annotation = [[MKPointAnnotation alloc]init];
            annotation.title = self.restaurant.name;
            annotation.subtitle = self.restaurant.restaurantType;
            
            if([placemarks objectAtIndex:0].location)
            {
                annotation.coordinate = [placemarks objectAtIndex:0].location.coordinate;
                [self.mapView showAnnotations:[NSArray arrayWithObjects:annotation, nil] animated:true];
                [self.mapView selectAnnotation:annotation animated:true];

                
            }

            
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    NSString *identifier = @"MyPin";
    if([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    
    MKPinAnnotationView* annotationView = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if(annotationView == nil)
    {
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.canShowCallout = true;
    }
    UIImageView* leftIconView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 53, 53)];
    leftIconView.image = [UIImage imageWithData:self.restaurant.image];
    annotationView.leftCalloutAccessoryView = leftIconView;
    
    annotationView.pinTintColor = [UIColor blackColor];
    
    return annotationView;
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
