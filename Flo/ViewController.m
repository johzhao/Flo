//
//  ViewController.m
//  Flo
//
//  Created by John Zhao on 1/6/16.
//  Copyright © 2016 John Zhao. All rights reserved.
//

#import "ViewController.h"
#import "PushButtonView.h"
#import "CounterView.h"
#import "GraphView.h"
#import "MedalView.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIView                 *containerView;
@property (nonatomic, weak) IBOutlet CounterView            *counterView;
@property (nonatomic, weak) IBOutlet UILabel                *counterLabel;
@property (nonatomic, weak) IBOutlet GraphView              *graphView;
@property (nonatomic, weak) IBOutlet UILabel                *averageWaterDrunk;
@property (nonatomic, weak) IBOutlet UILabel                *maxLabel;
@property (nonatomic, weak) IBOutlet MedalView              *medalView;

@property (nonatomic, assign) BOOL                          isGraphViewShowing;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self updateCounterLabel];
}

- (IBAction)pushButtonPressed:(PushButtonView*)button {
    if (button.isAddButton) {
        self.counterView.counter++;
    }
    else if (self.counterView.counter > 0) {
        self.counterView.counter--;
    }
    [self updateCounterLabel];

    if (self.isGraphViewShowing) {
        [self containerViewTapped:nil];
    }

    [self checkTotal];
}

- (IBAction)containerViewTapped:(UITapGestureRecognizer*)gesture {
    if (self.isGraphViewShowing) {
        [UIView transitionFromView:self.graphView
                            toView:self.counterView
                          duration:1.0
                           options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionShowHideTransitionViews
                        completion:nil];
    }
    else {
        [UIView transitionFromView:self.counterView
                            toView:self.graphView
                          duration:1.0
                           options:UIViewAnimationOptionTransitionFlipFromRight | UIViewAnimationOptionShowHideTransitionViews
                        completion:nil];
        [self setupGraphDisplay];
    }
    self.isGraphViewShowing = !self.isGraphViewShowing;
}

#pragma mark - Private methods

- (void)setupGraphDisplay {
    self.graphView.graphPoints[self.graphView.graphPoints.count - 1] = @(self.counterView.counter);
    [self.graphView setNeedsDisplay];

    NSNumber *maxValue = [self.graphView.graphPoints valueForKeyPath:@"@max.integerValue"];
    self.maxLabel.text = [NSString stringWithFormat:@"%ld", [maxValue integerValue]];

    NSNumber *averageValue = [self.graphView.graphPoints valueForKeyPath:@"@avg.integerValue"];
    self.averageWaterDrunk.text = [NSString stringWithFormat:@"%ld", (NSInteger)[averageValue floatValue]];
}

- (void)updateCounterLabel {
    self.counterLabel.text = [NSString stringWithFormat:@"%ld", self.counterView.counter];
}

- (void)checkTotal {
    if (self.counterView.counter >= 8) {
        [self.medalView showMedal:YES];
    }
    else {
        [self.medalView showMedal:NO];
    }
}

@end
