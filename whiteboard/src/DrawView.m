//
//  DrawView.m
//  Whiteboard
//
//  Created by visvavince on 5/19/15.
//  Copyright (c) 2015 Whiteboard. All rights reserved.
//

#import "DrawView.h"

@interface DrawView () {
    CGPoint cpt;
    CGPoint pp1;
    CGPoint pp2;
    
    CGMutablePathRef path;
    UIImage *snapshot;
    UIImage *previousSnap;
}
@end

@implementation DrawView

@synthesize color = _color;
@synthesize lineWidth = _lineWidth;
@synthesize alpha = _alpha;

#pragma mark - Inits

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) setup {
    _lineWidth = 1.0;
    _alpha = 1.0;
    _color = [UIColor blackColor];
}

- (void)dealloc {
    // must release path
    CGPathRelease(path);
}

#pragma mark - Touch Methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // reset path
    path = CGPathCreateMutable();
    
    // add the first touch
    UITouch *touch = [touches anyObject];
    pp1 = [touch previousLocationInView:self];
    cpt = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    // save all the touches in the path
    UITouch *touch = [touches anyObject];
    
    pp2 = pp1;
    pp1 = [touch previousLocationInView:self];
    cpt = [touch locationInView:self];

    // creates a mutable path for us
    CGPoint mid1 = midPoint(pp1, pp2);
    CGPoint mid2 = midPoint(cpt, pp1);
    CGMutablePathRef subpath = CGPathCreateMutable();
    
    // sets the starting of the mid pt 1
    CGPathMoveToPoint(subpath, nil, mid1.x, mid1.y);
    
    // out puts a curve path, remember a quad curve needs 2 mid pts and a ctrl pt
    // pp2 is end, pp1 is control pt, and cpt is ending
    CGPathAddQuadCurveToPoint(subpath, nil, pp1.x, pp1.y, mid2.x, mid2.y);
    CGRect bounds = CGPathGetBoundingBox(subpath);
    CGPathAddPath(path, nil, subpath);
    CGPathRelease(subpath);
    
    CGRect rect = bounds;
    float adj = 4.0;
    rect.origin.x -= _lineWidth * adj/2;
    rect.origin.y -= _lineWidth * adj/2;
    rect.size.width += _lineWidth * adj;
    rect.size.height += _lineWidth * adj;
    [self setNeedsDisplayInRect:rect];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesMoved:touches withEvent:event];
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    [snapshot drawAtPoint:CGPointZero];
    
    // need to draw here so uikit can have something to draw onto
    [self drawContext];
    
    snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // reset
    path = nil;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    [snapshot drawInRect:self.bounds];
    [self drawContext];
}

- (void) drawContext {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, path);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, _lineWidth);
    CGContextSetStrokeColorWithColor(context, _color.CGColor);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextSetAlpha(context, _alpha);
    CGContextStrokePath(context);
}

#pragma mark - Utility

CGPoint midPoint(CGPoint p1, CGPoint p2) {
    return CGPointMake((p1.x + p2.x)/2, (p1.y + p2.y)/2);
}

@end
