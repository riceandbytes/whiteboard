//
//  SpecialPanelView.m
//  whiteboard
//
//  Created by visvavince on 5/20/15.
//  Copyright (c) 2015 whiteboard. All rights reserved.
//

#import "SpecialPanelView.h"

@interface SpecialPanelView() {
    BOOL isErase;
}

@property (weak, nonatomic) IBOutlet UISlider *lineWidthSlider;
@property (weak, nonatomic) IBOutlet UISlider *alphaSlider;
@property (weak, nonatomic) IBOutlet UIButton *eraseButton;

@end

@implementation SpecialPanelView

@synthesize delegate = _delegate;
@synthesize lineWidthSlider = _lineWidthSlider;
@synthesize alphaSlider = _alphaSlider;
@synthesize eraseButton = _eraseButton;

- (IBAction)eraseButton:(id)sender {
    isErase = !isErase;
    if (isErase) {
        [_eraseButton setBackgroundColor:[UIColor redColor]];
    } else {
        [_eraseButton setBackgroundColor:[UIColor clearColor]];
    }
    [_delegate eraseMode:isErase];
}

- (IBAction)actionLineWidthSlider:(id)sender {
    [_delegate changeLineWidth:_lineWidthSlider.value];
}

- (IBAction)actionAlpha:(id)sender {
    [_delegate changeAlpha:_alphaSlider.value];
}

@end
