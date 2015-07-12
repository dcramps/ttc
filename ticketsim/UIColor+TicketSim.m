//
//  UIColor+TicketSim.m
//  ticketsim
//
//  Created by Daniel Crampton on 2015-07-11.
//  Copyright (c) 2015 Daniel Crampton. All rights reserved.
//

#import "UIColor+TicketSim.h"

@implementation UIColor (TicketSim)

+ (UIColor *)ts_redUpperColour
{
    return [UIColor ts_colorWithRed:214.0f green:58.0f blue:58.0f];
}

+ (UIColor *)ts_redLowerColour
{
    return [UIColor ts_colorWithRed:205.0f green:41.0f blue:33.0f];
}

+ (UIColor *)ts_blueUpperColour
{
    return [UIColor ts_colorWithRed:73.0f green:199.0f blue:250.0f];
}

+ (UIColor *)ts_blueLowerColour
{
    return [UIColor ts_colorWithRed:46.0f green:149.0f blue:250.0f];
}

#pragma mark - Internal

+ (UIColor *)ts_colorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b
{
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f];
}

@end
