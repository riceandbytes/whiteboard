//
//  ViewController.m
//  whiteboard
//
//  Created by visvavince on 5/19/15.
//  Copyright (c) 2015 whiteboard. All rights reserved.
//

#import "MainViewController.h"
#import "ColorPanelView.h"
#import "PanelView.h"

@interface MainViewController () <UIGestureRecognizerDelegate, PanelProtocol> {
    CGFloat centerX;
    PanelView* panelView;
    CGRect start;
    BOOL ignore;
    UIColor *lastColor;
}
@end

@implementation MainViewController

@synthesize drawView = _drawView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // defaults
    ignore = NO;
    lastColor = [UIColor blackColor];
    
    UIScreenEdgePanGestureRecognizer *leftEdgeGesture =
        [[UIScreenEdgePanGestureRecognizer alloc]
         initWithTarget:self action:@selector(handleLeftEdgeGesture:)];
    leftEdgeGesture.edges = UIRectEdgeLeft;
    leftEdgeGesture.delegate = self;
    [self.view addGestureRecognizer:leftEdgeGesture];

    UIScreenEdgePanGestureRecognizer *rightEdgeGesture =
        [[UIScreenEdgePanGestureRecognizer alloc]
         initWithTarget:self action:@selector(handleRightEdgeGesture:)];
    rightEdgeGesture.edges = UIRectEdgeRight;
    rightEdgeGesture.delegate = self;
    [self.view addGestureRecognizer:rightEdgeGesture];
    
    centerX = self.view.bounds.size.width / 2;
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    start = CGRectMake(-rect.size.width, rect.size.height/2,
               rect.size.width, rect.size.height/2);
    // shift view off screen
    
    panelView = [[PanelView alloc] initWithFrame:start];
    [panelView setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:panelView];
}

- (void)dealloc {
    NSLog(@"Main View Dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleLeftEdgeGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    
    if(UIGestureRecognizerStateEnded == gesture.state) {        
        [UIView animateWithDuration:.5 animations:^{
            [panelView nextView:self];
            panelView.center = CGPointMake(centerX, panelView.center.y);

        }];
    }
}

- (void)handleRightEdgeGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    
    if(UIGestureRecognizerStateBegan == gesture.state ||
       UIGestureRecognizerStateChanged == gesture.state) {
        [UIView animateWithDuration:.5 animations:^{
            
            panelView.frame = start;
        }];
    }
}

#pragma mark - Panel Protocol

- (void) changeColor: (UIColor*)color {
    lastColor = color;
    [self.drawView setColor:color];
}

- (void) changeLineWidth: (CGFloat)width {
    [self.drawView setLineWidth:width];
}

- (void) changeAlpha: (CGFloat)alpha {
    [self.drawView setAlpha:alpha];
}

- (void) eraseMode: (BOOL)on {
    if (on) {
        [self.drawView setColor:[UIColor whiteColor]];
    } else {
        [self.drawView setColor:lastColor];
    }
}

@end
