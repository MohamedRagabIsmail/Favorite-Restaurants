//
//  MapViewController.h
//  FoodPin
//
//  Created by Mohamed Ragab on 8/10/16.
//  Copyright © 2016 Mohamed Ragab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Restaurant.h"


@interface MapViewController : UIViewController <MKMapViewDelegate>
@property (nonatomic, retain) IBOutlet MKMapView* mapView;
@property (nonatomic, retain) Restaurant* restaurant;
@end
