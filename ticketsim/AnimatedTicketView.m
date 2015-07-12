//
//  AnimatedTicketView.m
//  ticketsim
//
//  Created by Daniel Crampton on 2015-07-11.
//  Copyright (c) 2015 Daniel Crampton. All rights reserved.
//

#import "AnimatedTicketView.h"
#import "UIColor+TicketSim.h"

static const CGFloat kAnimationDuration = 4.0f;
static const NSInteger kLogoCount = 3.0f;
static const CGFloat kDelay = kAnimationDuration/kLogoCount;

@interface AnimatedTicketView ()

@property BOOL maskAdded;

@end

@implementation AnimatedTicketView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.userInteractionEnabled = YES;
}

#pragma mark - Animation

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.maskAdded) {
        return;
    }
    
    [self configureWithUpperColour:[UIColor ts_redUpperColour] lowerColour:[UIColor ts_redLowerColour]];
    
    UIImage *ttc = [UIImage imageNamed:@"logo_ttc"];
    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat imageRatio = 0.12f; //approx height of image to height of box ratio
    CGFloat targetHeight = height * imageRatio;
    CGSize newSize = CGSizeMake(ttc.size.width * (targetHeight / ttc.size.height), targetHeight);

    UIImage *image = [self.class imageWithImage:ttc scaledToSize:newSize];
    
    self.layer.masksToBounds = YES;
    
    for (int x = 0; x < kLogoCount; x++) {
        CALayer *layer = [self imageLayerWithImage:image];
        [self.layer addSublayer:layer];
        
        CABasicAnimation *animation = [self imageAnimationWithLayer:layer];
        animation.beginTime = CACurrentMediaTime() + x * kDelay;
        
        [layer addAnimation:animation forKey:animation.keyPath];
    }
    
    self.maskAdded = YES;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (CABasicAnimation *)imageAnimationWithLayer:(CALayer *)layer
{
    CABasicAnimation *imageAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    imageAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetHeight(self.bounds) + CGRectGetHeight(layer.bounds)/2.0f)];
    imageAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.bounds), -CGRectGetHeight(layer.bounds)/2.0f)];
    imageAnimation.beginTime = 0.0f;
    imageAnimation.duration = kAnimationDuration;
    imageAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    imageAnimation.removedOnCompletion = YES;
    imageAnimation.repeatCount = HUGE;
    
    return imageAnimation;
}

- (CALayer *)imageLayerWithImage:(UIImage *)image
{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(-image.size.width, -image.size.height, image.size.width, image.size.height);
    imageLayer.contents = (id)image.CGImage;
    imageLayer.opacity = 0.8f;
    
    return imageLayer;
}

@end
