//
//  ColorPanelView.m
//  whiteboard
//
//  Created by visvavince on 5/19/15.
//  Copyright (c) 2015 whiteboard. All rights reserved.
//

#import "ColorPanelView.h"

@interface ColorPanelView() {
    id<PanelProtocol> delegate;
}
@end

@implementation ColorPanelView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        delegate = self.delegate;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        delegate = self.delegate;
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
- (IBAction)backColor:(id)sender {
    [delegate changeColor:[UIColor blackColor]];
}

@end
