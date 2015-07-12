//
//  ViewController.m
//  ticketsim
//
//  Created by Daniel Crampton on 2015-07-11.
//  Copyright (c) 2015 Daniel Crampton. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UILabel *dateLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MMMM dd, YYYY";
    
    self.dateLabel.text = [formatter stringFromDate:[NSDate date]];
}

@end
