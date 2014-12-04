//
//  ViewController.h
//  ZaHunter
//
//  Created by GLB-MXM0004 on 03/12/14.
//  Copyright (c) 2014 Hugo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ListPizzasViewController : UIViewController

@property NSMutableArray *fourNearPizzas;

-(void)findNearPizzas:(CLLocation *) loc;

@end

