//
//  PushButtonView.m
//  Flo
//
//  Created by John Zhao on 1/6/16.
//  Copyright © 2016 John Zhao. All rights reserved.
//

#import "PushButtonView.h"

@implementation PushButtonView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self != nil) {
        _fillColor = [UIColor greenColor];
        _isAddButton = YES;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    [self.fillColor setFill];
    [path fill];

    const CGFloat width = self.bounds.size.width;
    const CGFloat height = self.bounds.size.height;

    CGFloat plusHeight = 3.0f;
    CGFloat plusWidth = MIN(self.bounds.size.width, self.bounds.size.height) * 0.6f;

    UIBezierPath *plusPath = [UIBezierPath bezierPath];
    plusPath.lineWidth = plusHeight;

    [plusPath moveToPoint:CGPointMake(width/2.0f - plusWidth/2.0f + 0.5f, height/2.0f + 0.5f)];
    [plusPath addLineToPoint:CGPointMake(width/2.0f + plusWidth/2.0f + 0.5f, height/2.0f + 0.5f)];

    if (self.isAddButton) {
        [plusPath moveToPoint:CGPointMake(width/2.0f, height/2.0f - plusWidth/2.0f)];
        [plusPath addLineToPoint:CGPointMake(width/2.0f, height/2.0f + plusWidth/2.0f)];
    }

    [[UIColor whiteColor] setStroke];
    [plusPath stroke];
}

@end
