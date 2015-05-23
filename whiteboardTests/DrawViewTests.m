//
//  DrawViewTests.m
//  whiteboard
//
//  Created by visvavince on 5/23/15.
//  Copyright (c) 2015 whiteboard. All rights reserved.
//

#import <OCMock/OCMock.h>
#import <XCTest/XCTest.h>
#import "DrawView.h"

@interface DrawViewTests : XCTestCase

@end

@implementation DrawViewTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSetup {
    DrawView* dw = [[DrawView alloc] initWithFrame:CGRectZero];
    XCTAssertNotNil(dw, @"Cannot find CalcView instance");

    XCTAssert(dw.lineWidth == 1.0, @"Pass");
    XCTAssert(dw.alpha == 1.0, @"Pass");
    XCTAssertEqualObjects(dw.color, [UIColor blackColor]);
}

@end
