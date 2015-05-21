//
//  ExtraView.m
//  whiteboard
//
//  Created by visvavince on 5/20/15.
//  Copyright (c) 2015 whiteboard. All rights reserved.
//

#import "ExtraPanelView.h"

@implementation ExtraPanelView

@synthesize delegate = _delegate;

- (IBAction)actionRedo:(id)sender {
    [_delegate redo];
}

- (IBAction)actionUndo:(id)sender {
    [_delegate undo];
}

- (IBAction)actionScreenAndEmail:(id)sender {
    [_delegate screenAndEmail];
}


@end
