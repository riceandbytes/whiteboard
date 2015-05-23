//
//  MainViewControllerTests.m
//  whiteboard
//
//  Created by visvavince on 5/23/15.
//  Copyright (c) 2015 whiteboard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "MainViewController.h"

@interface MainViewControllerTests : XCTestCase

@end

@interface MainViewController (Tests)
- (void) undo;
- (void) redo;
- (void) eraseMode: (BOOL)on;
@end

@implementation MainViewControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testEraseMode {
    id mockDrawView = OCMClassMock([DrawView class]);
    
    MainViewController* mv = [[MainViewController alloc] init];
    mv.drawView = mockDrawView;
    [mv eraseMode:YES];
    
    OCMVerify([mockDrawView setColor:[UIColor whiteColor]]);
}

- (void)testCalls {
    id mockDrawView = OCMClassMock([DrawView class]);
    OCMStub([mockDrawView undo]);
    OCMStub([mockDrawView redo]);

    MainViewController* mv = [[MainViewController alloc] init];
    mv.drawView = mockDrawView;
    [mv undo];
    OCMVerify([mockDrawView undo]);
    [mv redo];
    OCMVerify([mockDrawView redo]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
