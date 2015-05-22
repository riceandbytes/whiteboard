//
//  ViewController.h
//  whiteboard
//
//  Created by visvavince on 5/19/15.
//  Copyright (c) 2015 whiteboard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawView.h"

@interface MainViewController : UIViewController
@property (weak, nonatomic) IBOutlet DrawView *drawView;
@end

