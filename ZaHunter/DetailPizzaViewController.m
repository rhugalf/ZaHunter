//
//  DetailPizzaViewController.m
//  ZaHunter
//
//  Created by GLB-MXM0004 on 04/12/14.
//  Copyright (c) 2014 Hugo. All rights reserved.
//

#import "DetailPizzaViewController.h"

@interface DetailPizzaViewController ()

@property (strong, nonatomic) IBOutlet UITextView *directionPizza;
@property (strong, nonatomic) IBOutlet UILabel *titlePizza;
@end

@implementation DetailPizzaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlePizza.text  = self.pizzaDato.title;
    
    self.directionPizza.text = [NSString stringWithFormat:@"Direction Pizza: %@", self.pizzaDato.placemark];
}


- (IBAction)backButtomPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
