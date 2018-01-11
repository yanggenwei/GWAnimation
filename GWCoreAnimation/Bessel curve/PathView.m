//
//  PathView.m
//  GWCoreAnimation
//
//  Created by genwei yang on 2018/1/3.
//  Copyright © 2018年 YangGenWei. All rights reserved.
//

#import "PathView.h"


@implementation PathView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}


- (void)drawRect:(CGRect)rect{
    
    UIColor *color = hexStrColor(@"#FF8C69");
    [color set];
    
    UIBezierPath *bPath = [UIBezierPath bezierPath];
    bPath.lineWidth = 2.0;
    bPath.lineCapStyle = kCGLineCapRound;
    bPath.lineJoinStyle = kCGLineCapRound;
    
    CGPoint center = (CGPoint){kSCREENWIDTH/2,kSCREENHEIGHT/2};
    //直线
    [bPath moveToPoint:(CGPoint){center.x-100,center.y-50}];
    [bPath addLineToPoint:(CGPoint){center.x-50,center.y-50}];
    [bPath closePath];
    [bPath stroke];
    
    [bPath moveToPoint:(CGPoint){center.x+50,center.y-50}];
    [bPath addLineToPoint:(CGPoint){center.x+100,center.y-50}];
    [bPath closePath];
    [bPath stroke];
    //矩形
    
    
    //圆形
    [bPath moveToPoint:(CGPoint){center.x-50,center.y-40}];
    [bPath addArcWithCenter:(CGPoint){center.x-75,center.y-40} radius:10 startAngle:0 endAngle:DEGREES_TO_RADIANS(360) clockwise:YES];
    [bPath closePath];
    [bPath fill];
    
    [bPath moveToPoint:(CGPoint){center.x+50,center.y-50}];
    [bPath addArcWithCenter:(CGPoint){center.x+75,center.y-40} radius:10 startAngle:0 endAngle:DEGREES_TO_RADIANS(360) clockwise:YES];
    [bPath closePath];
    [bPath fill];
    
    
    //二阶曲线
    UIBezierPath *bPathB = [UIBezierPath bezierPath];
    bPathB.lineWidth = 2.0;
    [bPathB moveToPoint:(CGPoint){center.x-60,center.y}];
    [bPathB addQuadCurveToPoint:(CGPoint){center.x+60,center.y} controlPoint:(CGPoint){center.x,center.y+50}];
    [bPathB stroke];
    
    //使用CAShapeLayer配合创建圆形
    //创建CAShapeLayer对象
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(center.x-150, center.y-150, 0,0);//设置shapeLayer的尺寸和位置
    shapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
    //设置线条的宽度和颜色
    shapeLayer.lineWidth = 2.0f;
    shapeLayer.strokeColor = hexStrColor(@"#FF8C69").CGColor;
    //创建一个圆形贝塞尔曲线
    UIBezierPath *aPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0,300,300)];
    //将贝塞尔曲线设置为CAShapeLayer的path
    shapeLayer.path = aPath.CGPath;
    //将shapeLayer添加到视图的layer上
    [self.layer addSublayer:shapeLayer];
    
    //绘制矩形
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:(CGRect){10,kSCREENHEIGHT-154,90,60}];
    [rectPath setLineWidth:2.0];
    [rectPath stroke];
    
    //设置圆角矩形
    UIBezierPath *roundedRectPath = [UIBezierPath bezierPathWithRoundedRect:(CGRect){110,kSCREENHEIGHT-154,90,60}
                                                          byRoundingCorners:UIRectCornerTopLeft
                                                                cornerRadii:(CGSize){40,0}];
    [roundedRectPath setLineWidth:2.0];
    [roundedRectPath fill];
    
    //三阶曲线
    UIBezierPath *curveRectPath = [UIBezierPath bezierPath];
    [curveRectPath moveToPoint:(CGPoint){210,kSCREENHEIGHT-124}];
    [curveRectPath addCurveToPoint:(CGPoint){290,kSCREENHEIGHT-124} controlPoint1:(CGPoint){250,kSCREENHEIGHT-154} controlPoint2:(CGPoint){250,kSCREENHEIGHT-94}];
    [curveRectPath setLineWidth:2.0];
    [curveRectPath stroke];
    
}

@end
