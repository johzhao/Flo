//
//  CounterView.m
//  Flo
//
//  Created by John Zhao on 1/6/16.
//  Copyright © 2016 John Zhao. All rights reserved.
//

#import "CounterView.h"

static const NSInteger NoOfGlasses = 8;
static const CGFloat π = (CGFloat)M_PI;

@implementation CounterView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self != nil) {
        _counter = 0;
        _outlineColor = [UIColor blueColor];
        _counterColor = [UIColor orangeColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // 1. Drawing arcs
    const CGFloat width = self.bounds.size.width;
    const CGFloat height = self.bounds.size.height;

    CGPoint center = CGPointMake(width/2.0f, height/2.0f);
    CGFloat radius = MAX(width, height);
    CGFloat arcWidth = 76.0f;

    CGFloat startAngle = 3 * π / 4;
    CGFloat endAngle = π / 4;

    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius/2.0f - arcWidth/2.0f
                                                    startAngle:startAngle
                                                      endAngle:endAngle
                                                     clockwise:YES];
    path.lineWidth = arcWidth;

    [self.counterColor setStroke];
    [path stroke];

    // 2. Draw the outline
    CGFloat angleDifference = 2 * π - startAngle + endAngle;
    CGFloat arcLengthPerGlass = angleDifference / NoOfGlasses;
    CGFloat outlineEndAngle = arcLengthPerGlass * self.counter + startAngle;

    UIBezierPath *outlinePath = [UIBezierPath bezierPathWithArcCenter:center
                                                               radius:width/2.0f - 2.5f
                                                           startAngle:startAngle
                                                             endAngle:outlineEndAngle
                                                            clockwise:YES];
    [outlinePath addArcWithCenter:center
                           radius:width/2.0f - arcWidth + 2.5f
                       startAngle:outlineEndAngle
                         endAngle:startAngle
                        clockwise:NO];
    [outlinePath closePath];
    outlinePath.lineWidth = 5.0f;

    [self.outlineColor setStroke];
    [outlinePath stroke];
}

- (void)setCounter:(NSInteger)counter {
    _counter = counter;
    if (_counter >= 0 && _counter <=NoOfGlasses) {
        [self setNeedsDisplay];
    }
}

@end
