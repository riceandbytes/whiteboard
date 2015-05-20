//
//  PanelView.m
//  whiteboard
//
//  Created by visvavince on 5/19/15.
//  Copyright (c) 2015 whiteboard. All rights reserved.
//

#import "PanelView.h"

@interface PanelView() {
    NSMutableArray* array;
    int currentIndex;
}
@end

@implementation PanelView

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup: frame];
    }
    return self;
}

//- (id)initWithCoder:(NSCoder *)aDecoder {
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        [self setup];
//    }
//    return self;
//}

- (void) setup: (CGRect)frame {
    currentIndex = 0;
    array = [NSMutableArray arrayWithCapacity:0];
    
    NSArray *views = @[@"ColorPanelView", @"ExtraView"];
    for (NSString* name in views) {
        UIView* vc = [[[NSBundle mainBundle] loadNibNamed:name owner:self options:nil] firstObject];
        [vc setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [array addObject:vc];
    }
}

- (void) nextView {
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    PanelView* pv = [array objectAtIndex:currentIndex];
    [self addSubview:pv];
    ++currentIndex;
    if (currentIndex >= array.count) {
        currentIndex = 0;
    }
}

@end
