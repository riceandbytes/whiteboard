//
//  UITests.m
//  whiteboard
//
//  Created by visvavince on 5/23/15.
//  Copyright (c) 2015 whiteboard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KIF/KIF.h>

@interface UITests : KIFTestCase {
    NSString* dw;
    NSString* cpv;
    NSString* pv;
}
@end

@implementation UITests

- (void) beforeAll {
}

- (void)beforeEach {
    dw = @"Draw View";
    cpv = @"ColorPanelView";
    pv = @"PanelView";
    
    [tester waitForTimeInterval:1];
}

- (void)afterEach {

}

- (void) testSwipe {
    [tester tapViewWithAccessibilityLabel:dw];
    
    for (int x = 0; x < 4; x++) {
        [tester swipeViewWithAccessibilityLabel:dw inDirection:KIFSwipeDirectionLeftEdgeToRight];
        [tester waitForTimeInterval:1];
    }

    for (int x = 0; x < 4; x++) {
        [tester swipeViewWithAccessibilityLabel:dw inDirection:KIFSwipeDirectionRightEdgeToLeft];
        [tester waitForTimeInterval:1];
    }
    
    [tester swipeViewWithAccessibilityLabel:pv inDirection:KIFSwipeDirectionDown];
}

- (void) testHidePanel {
    [tester swipeViewWithAccessibilityLabel:dw inDirection:KIFSwipeDirectionLeftEdgeToRight];
    [tester waitForTimeInterval:2];
    
    UIView * view = [tester waitForViewWithAccessibilityLabel:pv];
    XCTAssert(view.isHidden == NO, @"Pass");
    
    [tester swipeViewWithAccessibilityLabel:cpv inDirection:KIFSwipeDirectionDown];
    [tester waitForTimeInterval:4];
    XCTAssert(view.isHidden == YES, @"Pass");
}

- (void) testShowPanel {
    [tester swipeViewWithAccessibilityLabel:dw inDirection:KIFSwipeDirectionLeftEdgeToRight];
    [tester waitForTimeInterval:4];
    
    UIView * view = [tester waitForViewWithAccessibilityLabel:pv];
    
    XCTAssert(view.isHidden == NO, @"Pass");
}

@end
