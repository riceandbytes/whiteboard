//
//  ViewController.m
//  whiteboard
//
//  Created by visvavince on 5/19/15.
//  Copyright (c) 2015 whiteboard. All rights reserved.
//

#import "MainViewController.h"
#import "ColorPanelView.h"

@interface MainViewController () <UIGestureRecognizerDelegate> {
    CGFloat _centerX;
    UIView* _miniView;
    CGRect _start;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
    
    _miniView = [[[NSBundle mainBundle] loadNibNamed:@"ColorPanelView" owner:self options:nil] firstObject];
    [_miniView setFrame:_start];
    
    [_miniView setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:_miniView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleLeftEdgeGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    
    if(UIGestureRecognizerStateBegan == gesture.state ||
       UIGestureRecognizerStateChanged == gesture.state) {
        CGPoint translation = [gesture translationInView:gesture.view];
        [UIView animateWithDuration:.5 animations:^{
            _miniView.center = CGPointMake(_centerX + translation.x, _miniView.center.y);
        }];
    } else {// cancel, fail, or ended
            // Animate back to center x
        [UIView animateWithDuration:.3 animations:^{
            
            _miniView.center = CGPointMake(_centerX, _miniView.center.y);
        }];
    }
}

- (void)handleRightEdgeGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    
    if(UIGestureRecognizerStateBegan == gesture.state ||
       UIGestureRecognizerStateChanged == gesture.state) {
        [UIView animateWithDuration:.5 animations:^{
            
            _miniView.frame = _start;
        }];
    }
}

@end
