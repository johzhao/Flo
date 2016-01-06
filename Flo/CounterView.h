//
//  CounterView.h
//  Flo
//
//  Created by John Zhao on 1/6/16.
//  Copyright © 2016 John Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface CounterView : UIView

@property (nonatomic, assign) IBInspectable NSInteger               counter;
@property (nonatomic, strong) IBInspectable UIColor                 *outlineColor;
@property (nonatomic, strong) IBInspectable UIColor                 *counterColor;

@end
