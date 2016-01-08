//
//  MedalView.m
//  Flo
//
//  Created by John Zhao on 2016/01/08.
//  Copyright © 2016 John Zhao. All rights reserved.
//

#import "MedalView.h"

@interface MedalView ()

@property (nonatomic, strong) UIImage               *medalImage;

@end



@implementation MedalView

- (void)showMedal:(BOOL)show {
    if (show) {
        self.image = self.medalImage;
    }
    else {
        self.image = nil;
    }
}

- (UIImage*)medalImage {
    if (_medalImage == nil) {
        _medalImage = [self createMedalImage];
    }
    return _medalImage;
}

- (UIImage*)createMedalImage {
    CGSize size = CGSizeMake(120.0f, 200.0f);

    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();

    UIColor *darkGoldColor = [UIColor colorWithRed:0.6f green:0.5f blue:0.15f alpha:1.0f];
    UIColor *midGoldColor = [UIColor colorWithRed:0.86f green:0.73f blue:0.3f alpha:1.0f];
    UIColor *lightGoldColor = [UIColor colorWithRed:1.0f green:0.98f blue:0.9f alpha:1.0f];

    // Add shadow
    UIColor *shadow = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
    CGSize shadowOffset = CGSizeMake(2.0f, 2.0f);
    CGFloat shadowBlurRadius = 5.0f;

    CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);

    CGContextBeginTransparencyLayer(context, nil);

    // Lower Ribbon
    UIBezierPath *lowerRibbonPath = [UIBezierPath bezierPath];
    [lowerRibbonPath moveToPoint:CGPointZero];
    [lowerRibbonPath addLineToPoint:CGPointMake(40.0f, 0.0f)];
    [lowerRibbonPath addLineToPoint:CGPointMake(78.0f, 70.0f)];
    [lowerRibbonPath addLineToPoint:CGPointMake(38.0f, 70.0f)];
    [lowerRibbonPath closePath];

    [[UIColor redColor] setFill];
    [lowerRibbonPath fill];

    // Clasp
    UIBezierPath *claspPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(36.0f, 62.0f, 43.0f, 20.0f) cornerRadius:5];
    claspPath.lineWidth = 5.0f;
    [darkGoldColor setStroke];
    [claspPath stroke];

    // Medallion
    CGRect medallionRect = CGRectMake(8.0f, 72.0f, 100.0f, 100.0f);
    UIBezierPath *medallionPath = [UIBezierPath bezierPathWithOvalInRect:medallionRect];
    CGContextSaveGState(context);
    [medallionPath addClip];

    CFArrayRef colorArray = CFArrayCreate(kCFAllocatorDefault, (const void*[]){darkGoldColor.CGColor, midGoldColor.CGColor, lightGoldColor.CGColor}, 3, nil);
    CGGradientRef gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), colorArray, (const CGFloat[]){0, 0.51, 1});
    CGContextDrawLinearGradient(context, gradient, CGPointMake(40.0f, 40.0f), CGPointMake(100.0f, 160.0f), 0);
    CGContextRestoreGState(context);

    // Create a transform
    // Scale it, and translate it right and down
    CGAffineTransform transform = CGAffineTransformMakeScale(0.8f, 0.8f);
    transform = CGAffineTransformTranslate(transform, 15.0f, 30.0f);

    medallionPath.lineWidth = 2.0f;

    // Apply the transform to the path
    [medallionPath applyTransform:transform];
    [medallionPath stroke];

    // Upper ribbon
    UIBezierPath *upperRibbonPath = [UIBezierPath bezierPath];
    [upperRibbonPath moveToPoint:CGPointMake(68.0f, 0.0f)];
    [upperRibbonPath addLineToPoint:CGPointMake(108.0f, 0.0f)];
    [upperRibbonPath addLineToPoint:CGPointMake(78.0f, 70.0f)];
    [upperRibbonPath addLineToPoint:CGPointMake(38.0f, 70.0f)];
    [upperRibbonPath closePath];

    [[UIColor blueColor] setFill];
    [upperRibbonPath fill];

    // Number one

    // Must be NSString to be able to use drawInRect
    NSString *numberOne = @"1";
    CGRect numberOneRect = CGRectMake(47.0f, 100.0f, 50.0f, 50.0f);
    UIFont *font = [UIFont fontWithName:@"Academy Engraved LET" size:60.0f];
    NSDictionary *numberOneAttributes = @{
                                          NSFontAttributeName: font,
                                          NSForegroundColorAttributeName: darkGoldColor
                                          };
    [numberOne drawInRect:numberOneRect withAttributes:numberOneAttributes];

    CGContextEndTransparencyLayer(context);

    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

@end
