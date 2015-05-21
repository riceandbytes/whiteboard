//
//  Config.m
//  whiteboard
//
//  Created by visvavince on 5/19/15.
//  Copyright (c) 2015 whiteboard. All rights reserved.
//

#import "Config.h"

@interface Config() {
    CGMutablePathRef path;
}
@end

@implementation Config

@synthesize lineWidth = _lineWidth;
@synthesize color = _color;
@synthesize alpha = _alpha;

- (void) setPath: (CGPathRef) p {
    path = CGPathCreateMutableCopy(p);
}

- (CGPathRef) getPath {
    return path;
}

@end
