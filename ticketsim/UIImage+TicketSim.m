//
//  UIImage+TicketSim.m
//  ticketsim
//
//  Created by Daniel Crampton on 2015-07-12.
//  Copyright (c) 2015 Daniel Crampton. All rights reserved.
//

#import "UIImage+TicketSim.h"

@implementation UIImage (TicketSim)

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
