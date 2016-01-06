//
//  PushButtonView.h
//  Flo
//
//  Created by John Zhao on 1/6/16.
//  Copyright © 2016 John Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface PushButtonView : UIButton

@property (nonatomic, strong) IBInspectable UIColor             *fillColor;
@property (nonatomic, assign) IBInspectable BOOL                isAddButton;

@end
