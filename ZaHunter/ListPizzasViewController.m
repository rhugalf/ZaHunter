//
//  ViewController.m
//  ZaHunter
//
//  Created by GLB-MXM0004 on 03/12/14.
//  Copyright (c) 2014 Hugo. All rights reserved.
//

#import "ListPizzasViewController.h"
#import "Pizzeria.h"
@interface ListPizzasViewController ()<CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UILabel *timeToPizzaLabel;
@property CLLocationManager *myLocationManager;
@property NSTimeInterval totalTravelTime;
@property NSMutableArray *listPizzas;

@end

@implementation ListPizzasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myLocationManager = [[CLLocationManager alloc] init];
    [self.myLocationManager requestAlwaysAuthorization];
    self.myLocationManager.delegate = self;
    [self.myLocationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    for (CLLocation *location in locations)
    {
        if (location.verticalAccuracy < 1000 && location.horizontalAccuracy < 1000)
        {
            NSLog(@"Location pizzas, reverse geocoding...");
            [self findNearPizzas:location];
            [self.myLocationManager stopUpdatingLocation];
            break;
        }
    }
}

-(void)findNearPizzas:(CLLocation *)loc{
    MKLocalSearchRequest *request = [MKLocalSearchRequest new];
    request.naturalLanguageQuery = @"pizza";
    self.listPizzas = [[NSMutableArray alloc]init];
    //request.region = MKCoordinateRegionMake(loc.coordinate, MKCoordinateSpanMake(1, 1));
    request.region = MKCoordinateRegionMakeWithDistance(loc.coordinate, 10000, 10000);
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        for (MKMapItem *itmMap in response.mapItems) {
            if (self.listPizzas.count<20) {
                Pizzeria *pizza = [[Pizzeria alloc] initWithMapItem:itmMap];
                pizza.distanceFromUser = [itmMap.placemark.location distanceFromLocation:loc]*0.001;
                [self.listPizzas addObject:pizza];
            }else{
                break;
            }
        }
        [self validateNearPizzas];
   
    }];
}

-(void) validateNearPizzas{
    Pizzeria *nearestPizza1 = [[Pizzeria alloc]init];
    Pizzeria *nearestPizza2 = [[Pizzeria alloc]init];
    Pizzeria *nearestPizza3 = [[Pizzeria alloc]init];
    Pizzeria *nearestPizza4 = [[Pizzeria alloc]init];
    
    for (Pizzeria *pzz in self.listPizzas)
    {   if(pzz.name){
            if (pzz.distanceFromUser < nearestPizza1.distanceFromUser && pzz.distanceFromUser <= 10)
            {
                nearestPizza4  = nearestPizza3;
                nearestPizza3 = nearestPizza2;
                nearestPizza2 = nearestPizza1;
                nearestPizza1 = pzz;
            }
        }
    }
    
    self.fourNearPizzas = [NSMutableArray arrayWithObjects:nearestPizza1,nearestPizza2,nearestPizza3,nearestPizza4, nil];
    
    [self calculateTimeToPizza];
    
    [self.tableView reloadData];
}

-(void) calculateTimeToPizza{
        MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
        request.transportType = MKDirectionsTransportTypeWalking;
        MKMapItem *previousLocation = [MKMapItem mapItemForCurrentLocation];
        
        for (Pizzeria *pzz in self.fourNearPizzas)
        {
            [request setSource:previousLocation];
            [request setDestination:pzz];
            MKDirections *eta = [[MKDirections alloc] initWithRequest:request];
            [eta calculateETAWithCompletionHandler:^(MKETAResponse *response, NSError *error)
             {
                 self.totalTravelTime += (response.expectedTravelTime / 60) + 50;
                 self.timeToPizzaLabel.text = [NSString stringWithFormat:@"IS: %.0f minutes far from you!", self.totalTravelTime];

             }];
            previousLocation = pzz;
        }
        
    }

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Locator FAiled %@",error);
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [[self.fourNearPizzas objectAtIndex:indexPath.row] name];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.fourNearPizzas.count;
}

@end
