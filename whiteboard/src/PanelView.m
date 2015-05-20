//
//  PanelView.m
//  whiteboard
//
//  Created by visvavince on 5/19/15.
//  Copyright (c) 2015 whiteboard. All rights reserved.
//

#import "PanelView.h"
#import "ColorPanelView.h"

@interface PanelView() {
    NSMutableArray* array;
    int currentIndex;
    id<PanelProtocol> _pdelegate;

}
@end

@implementation PanelView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup: frame];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"Panel View Dealloc");
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
        PanelView* vc = [[[NSBundle mainBundle] loadNibNamed:name owner:self options:nil] firstObject];
        [vc setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [array addObject:vc];
    }
}

- (void) nextView: (id<PanelProtocol>) del {
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    PanelView* pv = [array objectAtIndex:currentIndex];
    pv.delegate = del;
    [self addSubview:pv];
    ++currentIndex;
    if (currentIndex >= array.count) {
        currentIndex = 0;
    }
}
@end
