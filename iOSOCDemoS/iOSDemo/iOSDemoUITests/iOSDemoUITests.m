//
//  iOSDemoUITests.m
//  iOSDemoUITests
//
//  Created by coder4869 on 12/26/16.
//  Copyright © 2016 coder4869. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface iOSDemoUITests : XCTestCase
@property(nonatomic, strong) XCUIApplication *app;
@end

@implementation iOSDemoUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
//    [[[XCUIApplication alloc] init] launch];
    self.app = [[XCUIApplication alloc] init];
    [self.app launch];
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    for (int i=0; i<5; i++) {
        [self switchTabBarTest];
    }
    
    sleep(10);
}

//ios9.0+
- (void)switchTabBarTest {
    sleep(1);
    //get button by title value
    if (self.app.tabBars.buttons[@"User"].exists) { //@"User" is the title of UITabBarItem
        NSLog(@"\nFound User TabBarItem!\n");
        [self.app.tabBars.buttons[@"User"] tap];
    } else {
        NSLog(@"\nUser TabBarItem not found!\n");
    }
    sleep(1);
    if ([self.app.tabBars.buttons elementBoundByIndex:1].exists) {
        NSLog(@"\nFound List TabBarItem!\n");
        [[self.app.tabBars.buttons elementBoundByIndex:1] tap];
    } else {
        NSLog(@"\nList TabBarItem not found!\n");
    }
    sleep(1);
    if (self.app.tabBars.buttons[@"Home"].exists) { //@"Home" is the title of UITabBarItem
        NSLog(@"\nFound User TabBarItem!\n");
        [self.app.tabBars.buttons[@"Home"] tap];
    } else {
        NSLog(@"\nUser TabBarItem not found!\n");
    }
}

@end
