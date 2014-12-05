//
//  MapViewController.m
//  ZaHunter
//
//  Created by GLB-MXM0004 on 04/12/14.
//  Copyright (c) 2014 Hugo. All rights reserved.
//

#import "MapViewController.h"
#import "ListPizzasViewController.h"
#import "DetailPizzaViewController.h"
#import "Pizzeria.h"

@interface MapViewController ()<MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationController *mapNC = self.tabBarController.viewControllers.firstObject;
    ListPizzasViewController *listVw =(ListPizzasViewController *)mapNC;

    for (Pizzeria *pz in listVw.fourNearPizzas) {
        [self.mapView addAnnotation:pz];
    }
    
}


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
 
    
    MKPinAnnotationView *pizzaPin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myPin"];
    //pizzaPin.canShowCallout = YES;
    pizzaPin.image = [UIImage imageNamed:@"pizza"];
    pizzaPin.canShowCallout = YES;
    
    pizzaPin.leftCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return pizzaPin;
}


-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    CLLocationCoordinate2D  center = view.annotation.coordinate;
    MKCoordinateSpan span;
    span.latitudeDelta =0.01;
    span.longitudeDelta = 0.01;
    MKCoordinateRegion region;
    region.center = center;
    region.span = span;
    [self.mapView setRegion:region animated:YES];
    

    [self performSegueWithIdentifier:@"detailPizzaSegue" sender:view];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    DetailPizzaViewController *detailPizzaController = segue.destinationViewController;
     //mapDetailViewController.busStop = [(MKAnnotationView *)sender annotation];
    Pizzeria *mkAnn = [(MKAnnotationView *)sender annotation];
    
    detailPizzaController.pizzaDato = mkAnn;
}

/*
 
 
 
 -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
 //DetailPointMap
 if ([segue.identifier isEqualToString:@"DetailPointMap"]) {
 DetailedStationViewController *detailController = segue.destinationViewController;
 MKAnnotationView *detailBusStop = sender;
 //MKAnnotationView *annotationView = sender;
 for (BusStop *bs in self.pointAnnotations) {
 if ([bs.cta_stop_name isEqualToString:detailBusStop.annotation.title]) {
 detailController.detailBusStop = bs;
 }
 }
 [detailController setModalPresentationStyle:UIModalPresentationOverCurrentContext];
 }
 }

 */

@end
