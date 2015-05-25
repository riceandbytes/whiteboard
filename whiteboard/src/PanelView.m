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

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.accessibilityLabel = @"PanelView";
    }
    return self;
}

- (void)dealloc {
    NSLog(@"Panel View Dealloc");
}

- (void) setup {
    self.hidden = YES;
    UISwipeGestureRecognizer* swipeDown =
        [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDown:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:swipeDown];
    
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth |
                            UIViewAutoresizingFlexibleHeight |
                            UIViewAutoresizingFlexibleBottomMargin |
                            UIViewAutoresizingFlexibleLeftMargin |
                            UIViewAutoresizingFlexibleRightMargin |
                            UIViewAutoresizingFlexibleTopMargin |
                            UIViewAutoresizingFlexibleBottomMargin;
    
    currentIndex = 0;
    array = [NSMutableArray arrayWithCapacity:0];
    
    NSArray *views = @[@"ExtraPanelView", @"ColorPanelView", @"SpecialPanelView"];
    
    for (NSString* name in views) {
        PanelView* vc = [[[NSBundle mainBundle] loadNibNamed:name owner:self options:nil] firstObject];
        [vc setFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        vc.delegate = delegate;
        [array addObject:vc];
        vc.hidden = YES;
        [self addSubview:vc];
    }
}

- (void) nextView {
    PanelView* pv = [array objectAtIndex:currentIndex];
    pv.hidden = YES;
    
    ++currentIndex;
    if (currentIndex >= array.count) {
        currentIndex = 0;
    }
    
    pv = [array objectAtIndex:currentIndex];
    pv.hidden = NO;
    [self bringSubviewToFront:pv];

    [self showView];
}

- (void) prevView {
    
    PanelView* pv = [array objectAtIndex:currentIndex];
    pv.hidden = YES;
    
    --currentIndex;
    if (currentIndex < 0) {
        currentIndex = (int)array.count - 1;
    }
    
    pv = [array objectAtIndex:currentIndex];
    pv.hidden = NO;
    [self bringSubviewToFront:pv];
    
    [self showView];
}

#pragma mark - Swipe Gesture

/**
    When we swipe down on the panel we close it
 */
- (void)handleSwipeDown:(UIGestureRecognizer*)recognizer {
    CGRect hideFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.bounds.size.height,
                           self.bounds.size.width, self.bounds.size.height);
    [UIView animateWithDuration:1.0 animations:^{
        self.frame = hideFrame;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

#pragma mark - Helpers

- (void) showView {
    if (!self.isHidden) {
        self.hidden = NO;
        [UIView animateWithDuration:1.0 animations:^{
            CGRect rect = [[UIScreen mainScreen] bounds];
            self.frame = CGRectMake(self.frame.origin.x, rect.size.height/2,
                                    self.bounds.size.width, self.bounds.size.height);
            NSLog(@"Rect: %@", NSStringFromCGRect(self.frame));
        } completion:^(BOOL finished) {
        }];
    }
}

@end
