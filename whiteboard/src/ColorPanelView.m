//
//  ColorPanelView.m
//  whiteboard
//
//  Created by visvavince on 5/19/15.
//  Copyright (c) 2015 whiteboard. All rights reserved.
//

#import "ColorPanelView.h"

@interface ColorPanelView() {
}
@end

@implementation ColorPanelView

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)blackColor:(id)sender {
    [_delegate changeColor:[UIColor blackColor]];
}

- (IBAction)darkGrayColor:(id)sender {
    [_delegate changeColor:[UIColor darkGrayColor]];
}

- (IBAction)lightGreyColor:(id)sender {
    [_delegate changeColor:[UIColor lightGrayColor]];
}

- (IBAction)blueColor:(id)sender {
    [_delegate changeColor:[UIColor blueColor]];
}

- (IBAction)redColor:(id)sender {
    [_delegate changeColor:[UIColor redColor]];
}

- (IBAction)greenColor:(id)sender {
    [_delegate changeColor:[UIColor greenColor]];
}

- (IBAction)orangeColor:(id)sender {
    [_delegate changeColor:[UIColor orangeColor]];
}

- (IBAction)yellowColor:(id)sender {
    [_delegate changeColor:[UIColor yellowColor]];
}

@end
