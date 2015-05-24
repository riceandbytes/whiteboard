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
    [tester waitForTimeInterval:3];
}

- (void)afterEach {
}

- (void) testSwipe {
    [tester tapViewWithAccessibilityLabel:@"Draw View"];
    [tester swipeViewWithAccessibilityLabelFromLeftEdgeToRight:@"Draw View" value:nil traits:UIAccessibilityTraitNone inDirection:KIFSwipeDirectionRight];
    [tester waitForTimeInterval:10];

//    [tester swipeViewWithAccessibilityIdentifier:@"Draw View" inDirection:KIFSwipeDirectionRight];
//    [tester tapViewWithAccessibilityLabel:@"Delete"];

}

@end
