//
//  SplitColourView.h
//  ticketsim
//
//  Created by Daniel Crampton on 2015-07-11.
//  Copyright (c) 2015 Daniel Crampton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TappableSplitColourView : UIView

@property BOOL tapped;

- (void)configureWithUpperColour:(UIColor *)upper lowerColour:(UIColor *)lower;

@end
