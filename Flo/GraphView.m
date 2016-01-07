//
//  GraphView.m
//  Flo
//
//  Created by John Zhao on 2016/01/07.
//  Copyright © 2016 John Zhao. All rights reserved.
//

#import "GraphView.h"

@interface GraphView ()

@end



@implementation GraphView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self != nil) {
        _startColor = [UIColor redColor];
        _endColor = [UIColor greenColor];
        _graphPoints = [NSMutableArray arrayWithObjects:@4, @2, @6, @4, @5, @8, @3, nil];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    const CGFloat width = self.bounds.size.width;
    const CGFloat height = self.bounds.size.height;

    // 1. Draw the background gradient
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                               byRoundingCorners:UIRectCornerAllCorners
                                                     cornerRadii:CGSizeMake(8.0f, 8.0f)];
    [path addClip];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CFArrayRef colors = CFArrayCreate(kCFAllocatorDefault, (const void*[]){self.startColor.CGColor, self.endColor.CGColor}, 2, nil);
    CGFloat *clorLocations = (CGFloat[]){0.0, 1.0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, colors, clorLocations);

    CGPoint startPoint = CGPointZero;
    CGPoint endPoint = CGPointMake(0.0f, self.bounds.size.height);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);

    // 2. Calculations for graph points
    CGFloat margin = 20.0f;
    CGFloat topBorder = 60.0f;
    CGFloat bottomBorder = 50.0f;
    CGFloat graphHeight = height - topBorder - bottomBorder;

    [[UIColor whiteColor] setFill];
    [[UIColor whiteColor] setStroke];

    UIBezierPath *graphPath = [UIBezierPath bezierPath];

    CGFloat xpos = [self xPositionOfColumn:0 withMargin:margin];
    CGFloat ypos = [self yPositionOfColumn:0 graphHeight:graphHeight topBorder:topBorder];
    [graphPath moveToPoint:CGPointMake(xpos, ypos)];

    for (NSUInteger i=1; i<self.graphPoints.count; ++i) {
        xpos = [self xPositionOfColumn:i withMargin:margin];
        ypos = [self yPositionOfColumn:i graphHeight:graphHeight topBorder:topBorder];
        [graphPath addLineToPoint:CGPointMake(xpos, ypos)];
    }

//    [graphPath stroke];

    // 3. Create the clipping path for the graph gradient
    CGContextSaveGState(context);

    UIBezierPath *clippingPath = [graphPath copy];

    xpos = [self xPositionOfColumn:self.graphPoints.count - 1 withMargin:margin];
    [clippingPath addLineToPoint:CGPointMake(xpos, height)];

    xpos = [self xPositionOfColumn:0 withMargin:margin];
    [clippingPath addLineToPoint:CGPointMake(xpos, height)];

    [clippingPath closePath];

    [clippingPath addClip];

    // TODO: Get the index of the highest value.
    NSInteger highestValueIndex = 5;
    CGFloat highestYPoint = [self yPositionOfColumn:highestValueIndex graphHeight:graphHeight topBorder:topBorder];
    startPoint = CGPointMake(margin, highestYPoint);
    endPoint = CGPointMake(margin, height);

    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);

    CGContextRestoreGState(context);

    // 4. Draw the path.
    graphPath.lineWidth = 2.0f;
    [graphPath stroke];

    // 5. Draw the points
    for (NSUInteger i=0; i<self.graphPoints.count; ++i) {
        CGFloat xpos = [self xPositionOfColumn:i withMargin:margin];
        CGFloat ypos = [self yPositionOfColumn:i graphHeight:graphHeight topBorder:topBorder];

        CGRect circleRect = CGRectMake(xpos - 2.5f, ypos - 2.5f, 5.0f, 5.0f);
        UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:circleRect];
        [circle fill];
    }

    // 6. Draw the horizontal lines
    UIBezierPath *linePath = [UIBezierPath bezierPath];

    // Top line
    [linePath moveToPoint:CGPointMake(margin, topBorder)];
    [linePath addLineToPoint:CGPointMake(width - margin, topBorder)];

    // Center line
    [linePath moveToPoint:CGPointMake(margin, graphHeight/2.0f + topBorder)];
    [linePath addLineToPoint:CGPointMake(width - margin, graphHeight/2.0f + topBorder)];

    // Bottom line
    [linePath moveToPoint:CGPointMake(margin, height - bottomBorder)];
    [linePath addLineToPoint:CGPointMake(width - margin, height - bottomBorder)];

    UIColor *lineColor = [UIColor colorWithWhite:1.0f alpha:0.3f];
    [lineColor setStroke];

    linePath.lineWidth = 1.0f;
    [linePath stroke];

    // Release resources
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    CFRelease(colors);
}

#pragma mark - Private methods

- (CGFloat)xPositionOfColumn:(NSInteger)column withMargin:(CGFloat)margin {
    CGFloat spacer = (self.bounds.size.width - margin*2 - 4) / (self.graphPoints.count - 1);
    CGFloat xpos = column * spacer;
    xpos += margin + 2;
    return xpos;
}

- (CGFloat)yPositionOfColumn:(NSInteger)column graphHeight:(CGFloat)graphHeight topBorder:(CGFloat)topBorder {
    NSNumber *maxValue = [self.graphPoints valueForKeyPath:@"@max.integerValue"];
    CGFloat ypos = [self.graphPoints[column] integerValue] * graphHeight / [maxValue integerValue];
    ypos = graphHeight + topBorder - ypos;
    return ypos;
}

@end
