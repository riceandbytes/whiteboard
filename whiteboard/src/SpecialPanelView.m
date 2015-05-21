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

@end

@implementation SpecialPanelView

@synthesize delegate = _delegate;
@synthesize lineWidthSlider = _lineWidthSlider;
@synthesize alphaSlider = _alphaSlider;

- (IBAction)eraseButton:(id)sender {
    isErase = !isErase;
    [_delegate eraseMode:isErase];
}

- (IBAction)actionLineWidthSlider:(id)sender {
    [_delegate changeLineWidth:_lineWidthSlider.value];
}

- (IBAction)actionAlpha:(id)sender {
    [_delegate changeAlpha:_alphaSlider.value];
}

@end
