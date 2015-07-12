//
//  AnimatedHeaderView.m
//  ticketsim
//
//  Created by Daniel Crampton on 2015-07-11.
//  Copyright (c) 2015 Daniel Crampton. All rights reserved.
//

#import "AnimatedHeaderView.h"
#import "UIColor+TicketSim.h"

static CGFloat kAnimationTime = 2.0f;

@interface AnimatedHeaderView ()

@property CGFloat width;
@property CGFloat height;
@property CGFloat triangleWidth;
@property CGFloat triangleHeight;
@property BOOL maskAdded;

@end

@implementation AnimatedHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
 
    self.userInteractionEnabled = NO;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.maskAdded) {
        return;
    }
    
    [self configureWithUpperColour:[UIColor ts_blueUpperColour] lowerColour:[UIColor ts_blueLowerColour]];
    
    self.width = CGRectGetWidth(self.bounds);
    self.height = CGRectGetHeight(self.bounds);
    self.triangleWidth = self.height/6.0f;
    self.triangleHeight = self.height/3.0f;

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.opacity = 0.3f;
    maskLayer.fillColor = [UIColor whiteColor].CGColor;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[[self firstHalfAnimation], [self secondHalfAnimation]];
    group.duration = kAnimationTime;
    group.repeatCount = HUGE;
    
    [maskLayer addAnimation:group forKey:nil];

    [self.layer addSublayer:maskLayer];
    
    self.maskAdded = YES;
}

- (CABasicAnimation *)firstHalfAnimation
{
    /*
         v                                   v
     |‾| :        |‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾:|
     |  >: -->    |                          : >
     |_| :        |__________________________:|
         ^                                   ^
    */
    
    UIBezierPath *startPath = [UIBezierPath bezierPath];
    [startPath moveToPoint:CGPointZero];
    [startPath addLineToPoint:CGPointMake(-self.triangleWidth, 0.0f)];
    [startPath addLineToPoint:CGPointMake(-self.triangleWidth, self.triangleHeight)];
    [startPath addLineToPoint:CGPointMake(0, self.height / 2.0f)];
    [startPath addLineToPoint:CGPointMake(-self.triangleWidth, self.triangleHeight * 2.0f)];
    [startPath addLineToPoint:CGPointMake(-self.triangleWidth, self.height)];
    [startPath addLineToPoint:CGPointMake(0.0f, self.height)];
    [startPath closePath];
    
    UIBezierPath *endPath = [UIBezierPath bezierPath];
    [endPath moveToPoint:CGPointZero];
    [endPath addLineToPoint:CGPointMake(self.width, 0.0f)];
    [endPath addLineToPoint:CGPointMake(self.width, self.triangleHeight)];
    [endPath addLineToPoint:CGPointMake(self.width + self.triangleWidth, self.height / 2.0f)];
    [endPath addLineToPoint:CGPointMake(self.width, self.triangleHeight * 2.0f)];
    [endPath addLineToPoint:CGPointMake(self.width, self.height)];
    [endPath addLineToPoint:CGPointMake(0.0f, self.height)];
    [endPath closePath];
    
    return [self slideAnimationWithStartPath:startPath endPath:endPath];
}

- (CABasicAnimation *)secondHalfAnimation
{
    /*
        v                                  v
     |‾‾:‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾|        :|‾|
      > :                         |  -->   :> |
     |__:_________________________|        :|_|
        ^                                  ^
     */
    
    UIBezierPath *startPath = [UIBezierPath bezierPath];
    [startPath moveToPoint:CGPointMake(-self.triangleWidth, 0.0f)];
    [startPath addLineToPoint:CGPointMake(-self.triangleWidth, self.triangleHeight)];
    [startPath addLineToPoint:CGPointMake(0.0f, self.height / 2.0f)];
    [startPath addLineToPoint:CGPointMake(-self.triangleWidth, self.triangleHeight * 2.0f)];
    [startPath addLineToPoint:CGPointMake(-self.triangleWidth, self.height)];
    [startPath addLineToPoint:CGPointMake(self.width, self.height)];
    [startPath addLineToPoint:CGPointMake(self.width, 0.0f)];
    [startPath closePath];
    
    UIBezierPath *endPath = [UIBezierPath bezierPath];
    [endPath moveToPoint:CGPointMake(self.width, 0.0f)];
    [endPath addLineToPoint:CGPointMake(self.width, self.triangleHeight)];
    [endPath addLineToPoint:CGPointMake(self.width + self.triangleWidth, self.height / 2.0f)];
    [endPath addLineToPoint:CGPointMake(self.width, self.triangleHeight * 2.0f)];
    [endPath addLineToPoint:CGPointMake(self.width, self.height)];
    [endPath addLineToPoint:CGPointMake(self.width + self.triangleWidth, self.height)];
    [endPath addLineToPoint:CGPointMake(self.width + self.triangleWidth, 0.0f)];
    [endPath closePath];
    
    CABasicAnimation *animation = [self slideAnimationWithStartPath:startPath endPath:endPath];
    animation.beginTime = kAnimationTime/2.0f;
    
    return animation;
}

- (CABasicAnimation *)slideAnimationWithStartPath:(UIBezierPath *)startPath endPath:(UIBezierPath *)endPath
{
    CABasicAnimation *slideAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    slideAnimation.fromValue = (id)startPath.CGPath;
    slideAnimation.toValue = (id)endPath.CGPath;
    slideAnimation.beginTime = 0.0f;
    slideAnimation.duration = kAnimationTime / 2.0f;
    slideAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    slideAnimation.removedOnCompletion = NO;
    slideAnimation.repeatCount = HUGE;
    
    return slideAnimation;
}

@end
