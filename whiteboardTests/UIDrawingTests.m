//
//  UIDrawingTests.m
//  whiteboard
//
//  Created by visvavince on 5/24/15.
//  Copyright (c) 2015 whiteboard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <KIF/KIF.h>


@interface UIDrawingTests : KIFTestCase {
    NSString* dv;
    NSString* cpv;
    NSString* pv;
}
@end

@implementation UIDrawingTests

- (void) beforeAll {
}

- (void)beforeEach {
    dv = @"Draw View";
    cpv = @"ColorPanelView";
    pv = @"PanelView";
    
    [tester waitForTimeInterval:1];
}

- (void)afterEach {
    
}

- (void) testChangeColorDraw {
    [tester tapViewWithAccessibilityLabel:dv];
    
    [tester swipeViewWithAccessibilityLabel:dv inDirection:KIFSwipeDirectionLeftEdgeToRight];
    [tester waitForTimeInterval:3];
    
    [tester tapViewWithAccessibilityLabel:@"blueColor"];
    [tester swipeViewWithAccessibilityLabel:pv inDirection:KIFSwipeDirectionDown];
    [tester waitForTimeInterval:4];
    
    //draw blue line
    [tester swipeViewWithAccessibilityLabel:dv inDirection:KIFSwipeDirectionRight];

    
    // change width
    [tester swipeViewWithAccessibilityLabel:dv inDirection:KIFSwipeDirectionLeftEdgeToRight];
    [tester waitForTimeInterval:2];
    [tester setValue:50.0 forSliderWithAccessibilityLabel:@"lineWidhtSlider"];
    [tester waitForTimeInterval:2];
    
    // hide panel
    [tester swipeViewWithAccessibilityLabel:pv inDirection:KIFSwipeDirectionDown];
    [tester waitForTimeInterval:4];

    // draw
    [tester swipeViewWithAccessibilityLabel:dv inDirection:KIFSwipeDirectionUp];
    [tester waitForTimeInterval:5];
}

@end
