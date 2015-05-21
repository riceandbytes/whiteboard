//
//  PanelView.h
//  whiteboard
//
//  Created by visvavince on 5/19/15.
//  Copyright (c) 2015 whiteboard. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PanelProtocol <NSObject>
- (void) changeColor: (UIColor*)color;
- (void) changeLineWidth: (CGFloat)width;
- (void) changeAlpha: (CGFloat)alpha;
- (void) eraseMode: (BOOL)on;
- (void) redo;
- (void) undo;
@end

@interface PanelView : UIView {
}
@property (assign) id<PanelProtocol> delegate;
- (void) nextView:(id<PanelProtocol>)del;
@end
