//
//  BackgroundView.m
//  Flo
//
//  Created by John Zhao on 2016/01/07.
//  Copyright © 2016 John Zhao. All rights reserved.
//

#import "BackgroundView.h"

@implementation BackgroundView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self != nil) {
        _lightColor = [UIColor orangeColor];
        _darkColor = [UIColor yellowColor];
        _patternSize = 200.0f;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGSize drawSize = CGSizeMake(self.patternSize, self.patternSize);

    UIGraphicsBeginImageContextWithOptions(drawSize, YES, 0.0);
    CGContextRef drawingContext = UIGraphicsGetCurrentContext();

    [self.darkColor setFill];
    CGContextFillRect(drawingContext, CGRectMake(0.0f, 0.0f, drawSize.width, drawSize.height));

    UIBezierPath *trianglePath = [UIBezierPath bezierPath];

    [trianglePath moveToPoint:CGPointMake(drawSize.width/2.0f, 0.0f)];
    [trianglePath addLineToPoint:CGPointMake(0.0f, drawSize.height/2.0f)];
    [trianglePath addLineToPoint:CGPointMake(drawSize.width, drawSize.height/2.0f)];

    [trianglePath moveToPoint:CGPointMake(0.0f, drawSize.height/2.0f)];
    [trianglePath addLineToPoint:CGPointMake(drawSize.width/2.0f, drawSize.height)];
    [trianglePath addLineToPoint:CGPointMake(0.0f, drawSize.height)];

    [trianglePath moveToPoint:CGPointMake(drawSize.width, drawSize.height/2.0f)];
    [trianglePath addLineToPoint:CGPointMake(drawSize.width/2.0f, drawSize.height)];
    [trianglePath addLineToPoint:CGPointMake(drawSize.width, drawSize.height)];

    [self.lightColor setFill];
    [trianglePath fill];

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor colorWithPatternImage:image] setFill];
    CGContextFillRect(context, rect);
}

@end
