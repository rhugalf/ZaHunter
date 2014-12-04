//
//  MapViewController.m
//  ZaHunter
//
//  Created by GLB-MXM0004 on 04/12/14.
//  Copyright (c) 2014 Hugo. All rights reserved.
//

#import "MapViewController.h"
#import "ListPizzasViewController.h"

@interface MapViewController ()<MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
      ListViewController *listViewController = (ListViewController *)[self.tabBarController.viewControllers.firstObject topViewController];
    */
    ListPizzasViewController *listViewController = (ListPizzasViewController *)[self.tabBarController.viewControllers.firstObject topViewController];
    NSLog(@"%lu",(unsigned long)listViewController.fourNearPizzas.count);
    
}


@end
