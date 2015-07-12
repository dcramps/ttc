//
//  SplitColourView.m
//  ticketsim
//
//  Created by Daniel Crampton on 2015-07-11.
//  Copyright (c) 2015 Daniel Crampton. All rights reserved.
//

#import "TappableSplitColourView.h"

@interface TappableSplitColourView ()

@property BOOL layersAdded;
@property (nonatomic, strong) CALayer *upperLayer;
@property (nonatomic, strong) CALayer *lowerLayer;
@property (nonatomic, strong) CALayer *highlightLayer;
@end

@implementation TappableSplitColourView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:tap];
}

#pragma mark - Interaction

- (void)tapped:(UITapGestureRecognizer *)sender
{
    self.tapped = !self.tapped;
    self.highlightLayer.opacity = self.tapped ? 1.0f : 0.0f;
}

- (void)configureWithUpperColour:(UIColor *)upper lowerColour:(UIColor *)lower
{
    self.upperLayer.backgroundColor = upper.CGColor;
    self.lowerLayer.backgroundColor = lower.CGColor;
    
    if (self.layersAdded) {
        return;
    }
    
    self.upperLayer = [[CALayer alloc] init];
    self.upperLayer.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) / 2.0f);
    self.upperLayer.backgroundColor = upper.CGColor;
    
    self.lowerLayer = [[CALayer alloc] init];
    self.lowerLayer.frame = CGRectMake(0.0f, CGRectGetHeight(self.bounds) / 2.0f, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) / 2.0f);
    self.lowerLayer.backgroundColor = lower.CGColor;
    
    [self.layer addSublayer:self.upperLayer];
    [self.layer addSublayer:self.lowerLayer];
    
    self.layersAdded = YES;
}


- (CALayer *)highlightLayer
{
    if (!_highlightLayer) {
        _highlightLayer = [[CALayer alloc] init];
        _highlightLayer.frame = self.bounds;
        _highlightLayer.backgroundColor = [UIColor colorWithWhite:0.8f alpha:0.8f].CGColor;
        _highlightLayer.opacity = 1.0f;
        [self.layer addSublayer:_highlightLayer];
    }
    
    return _highlightLayer;
}

@end
