//
//  Pizzeria.m
//  ZaHunter
//
//  Created by GLB-MXM0004 on 03/12/14.
//  Copyright (c) 2014 Hugo. All rights reserved.
//

#import "Pizzeria.h"

@interface Pizzeria()

@property (readwrite) NSString *title;

@end

@implementation Pizzeria

-(instancetype) init{
    self = [super init];
    
    self.distanceFromUser = 10000000;
    
    return self;
}

-(instancetype)initWithMapItem:(MKMapItem *)mapItem{
    self=[super initWithPlacemark:mapItem.placemark];
    self.name = mapItem.name;
    self.phoneNumber = mapItem.phoneNumber;
    self.coordinate=mapItem.placemark.location.coordinate;
    self.title=self.name;
    return self;
}

@end
