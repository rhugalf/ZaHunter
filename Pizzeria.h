//
//  Pizzeria.h
//  ZaHunter
//
//  Created by GLB-MXM0004 on 03/12/14.
//  Copyright (c) 2014 Hugo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Pizzeria : MKMapItem <MKAnnotation>
@property CLLocationDistance distanceFromUser;
@property (nonatomic) CLLocationCoordinate2D coordinate;

- (instancetype)initWithMapItem:(MKMapItem *)mapItem;
@end
