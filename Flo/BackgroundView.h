//
//  BackgroundView.h
//  Flo
//
//  Created by John Zhao on 2016/01/07.
//  Copyright © 2016 John Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface BackgroundView : UIView

@property (nonatomic, strong) IBInspectable UIColor         *lightColor;
@property (nonatomic, strong) IBInspectable UIColor         *darkColor;
@property (nonatomic, assign) IBInspectable CGFloat         patternSize;

@end
