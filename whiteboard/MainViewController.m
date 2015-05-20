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
    CGFloat _centerX;
    PanelView* panelView;
    CGRect _start;
    BOOL ignore;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ignore = NO;
    
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
    
    _centerX = self.view.bounds.size.width / 2;
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    _start = CGRectMake(-rect.size.width, rect.size.height/2,
               rect.size.width, rect.size.height/2);
    // shift view off screen
    
    panelView = [[PanelView alloc] initWithFrame:_start];
    [panelView setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:panelView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleLeftEdgeGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    
    if(UIGestureRecognizerStateEnded == gesture.state) {        
        [UIView animateWithDuration:.5 animations:^{
            [panelView nextView];
            panelView.center = CGPointMake(_centerX, panelView.center.y);

        }];
    }
}

- (void)handleRightEdgeGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    
    if(UIGestureRecognizerStateBegan == gesture.state ||
       UIGestureRecognizerStateChanged == gesture.state) {
        [UIView animateWithDuration:.5 animations:^{
            
            panelView.frame = _start;
        }];
    }
}

#pragma mark - Panel Protocol

- (void)changeColor: (UIColor*)color {
    NSLog(@"Yay");
}
//- (void)changeLineWidth: (CGFloat)width;
//- (void)changeAlpha: (CGFloat)alpha;

@end
