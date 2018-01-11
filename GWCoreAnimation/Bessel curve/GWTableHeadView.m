//
//  GWTableHeadView.m
//  GWCoreAnimation
//
//  Created by genwei yang on 2018/1/8.
//  Copyright © 2018年 YangGenWei. All rights reserved.
//

#import "GWTableHeadView.h"



@implementation GWTableHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.offsetY  = 0;
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    UIColor *color = hexStrColor(@"#FF8C69");
    [color set];
    bezier.lineWidth = 1.0;
    [bezier moveToPoint:(CGPoint){0,0}];
    [bezier addQuadCurveToPoint:(CGPoint){self.width,0} controlPoint:(CGPoint){self.width/2,self.offsetY}];
    [bezier fill];
}


@end
