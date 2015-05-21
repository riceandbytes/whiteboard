//
//  DrawView.h
//  Whiteboard
//
//  Created by visvavince on 5/19/15.
//  Copyright (c) 2015 Whiteboard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView
@property (nonatomic, weak) UIColor* color;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat alpha;
@property (nonatomic, weak) UIImage *snapshot;
- (void) undo;
- (void) redo;
@end
