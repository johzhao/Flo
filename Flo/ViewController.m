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

@interface ViewController ()

@property (nonatomic, weak) IBOutlet CounterView            *counterView;
@property (nonatomic, weak) IBOutlet UILabel                *counterLabel;

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
}

#pragma mark - Private methods

- (void)updateCounterLabel {
    self.counterLabel.text = [NSString stringWithFormat:@"%ld", self.counterView.counter];
}

@end
