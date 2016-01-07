//
//  GraphView.h
//  Flo
//
//  Created by John Zhao on 2016/01/07.
//  Copyright © 2016 John Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface GraphView : UIView

@property (nonatomic, strong) IBInspectable UIColor             *startColor;
@property (nonatomic, strong) IBInspectable UIColor             *endColor;

@property (nonatomic, strong) NSMutableArray                    *graphPoints;

@end
