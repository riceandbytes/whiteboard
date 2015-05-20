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
    
    CGFloat lineWidth;
    CGFloat alpha;
    UIColor* color;
    CGMutablePathRef path;
}
@end

@implementation DrawView

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
    lineWidth = 1.0;
    alpha = 1.0;
    color = [UIColor blackColor];
    path = CGPathCreateMutable();
}

#pragma mark - Touch Methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
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
    rect.origin.x -= lineWidth * 4.0;
    rect.origin.y -= lineWidth * 4.0;
    rect.size.width += lineWidth * 4.0;
    rect.size.height += lineWidth * 4.0;
    [self setNeedsDisplayInRect:rect];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesMoved:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, path);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextSetAlpha(context, alpha);
    CGContextStrokePath(context);
}

#pragma mark - Utility

CGPoint midPoint(CGPoint p1, CGPoint p2) {
    return CGPointMake((p1.x + p2.x)/2, (p1.y + p2.y)/2);
}

@end
