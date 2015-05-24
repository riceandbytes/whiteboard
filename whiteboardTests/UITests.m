//
//  UITests.m
//  whiteboard
//
//  Created by visvavince on 5/23/15.
//  Copyright (c) 2015 whiteboard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KIF/KIF.h>

@interface UITests : KIFTestCase

@end

@implementation UITests

- (void)beforeEach {
    [tester waitForTimeInterval:2];
}

- (void)afterEach {
}

- (void) testSwipe {
    NSString* dw = @"Draw View";
    [tester tapViewWithAccessibilityLabel:dw];
    
    
    [tester swipeViewWithAccessibilityLabel:dw inDirection:KIFSwipeDirectionLeftEdgeToRight];
    [tester waitForTimeInterval:2];
    [tester swipeViewWithAccessibilityLabel:dw inDirection:KIFSwipeDirectionLeftEdgeToRight];
    [tester waitForTimeInterval:2];
    [tester swipeViewWithAccessibilityLabel:dw inDirection:KIFSwipeDirectionLeftEdgeToRight];
    [tester waitForTimeInterval:2];
    [tester swipeViewWithAccessibilityLabel:dw inDirection:KIFSwipeDirectionRightEdgeToLeft];
    [tester waitForTimeInterval:2];
    
//    [tester swipeViewWithAccessibilityIdentifier:@"Draw View" inDirection:KIFSwipeDirectionRight];
//    [tester tapViewWithAccessibilityLabel:@"Delete"];

}

@end
