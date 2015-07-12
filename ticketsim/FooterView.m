//
//  FooterView.m
//  ticketsim
//
//  Created by Daniel Crampton on 2015-07-11.
//  Copyright (c) 2015 Daniel Crampton. All rights reserved.
//

#import "FooterView.h"
#import "UIColor+TicketSim.h"

@implementation FooterView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.userInteractionEnabled = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self configureWithUpperColour:[UIColor ts_blueUpperColour] lowerColour:[UIColor ts_blueLowerColour]];
}

@end
