//
//  GWLoadingView.m
//  GWCoreAnimation
//
//  Created by genwei yang on 2018/1/8.
//  Copyright © 2018年 YangGenWei. All rights reserved.
//

#import "GWLoadingView.h"
@interface GWLoadingView(){
    CAShapeLayer *_cylindricalLayer; //外圆
    CADisplayLink *_link; //定时器
}

@property (nonatomic,readwrite,strong)NSArray *layer_list;
@end


@implementation GWLoadingView

static const CGFloat duration = 1.f;


- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self drawLoadingRound];
    }
    return self;
}

- (void)drawLoadingRound{
    
    CGFloat radius = 20;
    CGFloat marginLeft = 10;
    
    CAShapeLayer *fLayer = [CAShapeLayer new];
    fLayer.backgroundColor =  getColor(102, 170, 238, 1).CGColor;
    [fLayer setFrame:(CGRect){self.width/2-(radius*2+marginLeft*2)/2,self.height/2,radius,radius}];
    fLayer.cornerRadius = radius/2;
    
    CAShapeLayer *sLayer = [CAShapeLayer new];
    sLayer.backgroundColor = getColor(102, 170, 238, 0.5).CGColor;
    [sLayer setFrame:(CGRect){marginLeft(fLayer)+marginLeft,self.height/2,radius,radius}];
    sLayer.cornerRadius = radius/2;
    
    CAShapeLayer *tLayer = [CAShapeLayer new];
    tLayer.backgroundColor = getColor(102, 170, 238, 0.2).CGColor;
    [tLayer setFrame:(CGRect){marginLeft(sLayer)+marginLeft,self.height/2,radius,radius}];
    tLayer.cornerRadius = radius/2;
    
    
    self.layer_list = [NSArray arrayWithObjects:fLayer,sLayer,tLayer,nil];
    [self.layer addSublayer:fLayer];
    [self.layer addSublayer:sLayer];
    [self.layer addSublayer:tLayer];

    [self setAnimation];
}

- (void)setAnimation{
    [self setFirstLayerAnimation];
    [self setSecondAnimation];
    [self setThirdAnimation];
}


- (void)setFirstLayerAnimation{
    //第一段动画路径layer
    CAShapeLayer *fLayer = self.layer_list[0];
    CAShapeLayer *sLayer = self.layer_list[1];
    
    CAShapeLayer *testLayer = [CAShapeLayer new];
    testLayer.fillColor = [UIColor clearColor].CGColor;
    testLayer.borderWidth = 1.0f;
    testLayer.strokeColor = hexStrColor(@"#AA8C69").CGColor;
    
    UIBezierPath *semicirclePathA = [UIBezierPath bezierPath];
    [semicirclePathA addArcWithCenter:(CGPoint){fLayer.frame.origin.x+25,fLayer.frame.origin.y+10} radius:15 startAngle:M_PI endAngle:0 clockwise:YES];
    UIBezierPath *semicirclePathB = [UIBezierPath bezierPath];
    [semicirclePathB addArcWithCenter:(CGPoint){sLayer.frame.origin.x+25,sLayer.frame.origin.y+10} radius:15 startAngle:M_PI endAngle:0 clockwise:NO];
    [semicirclePathA appendPath:semicirclePathB];
    testLayer.path = semicirclePathA.CGPath;
//    [self.layer addSublayer:testLayer];

    [self colorGradientAnimationWithLayer:fLayer
                                    fromValue:(__bridge id _Nullable)(getColor(102, 170, 238, 1)).CGColor
                                      toValue:(__bridge id _Nullable)(getColor(102, 170, 238, 0.2)).CGColor];
    
    [self keyFrameAnimationWithLayer:fLayer path:semicirclePathA];
    

}

- (void)setSecondAnimation{
    CAShapeLayer *fLayer = self.layer_list[0];
    CAShapeLayer *sLayer = self.layer_list[1];
    //第二段动画路径layer
    CAShapeLayer *testLeftLayer = [CAShapeLayer new];
    testLeftLayer.fillColor = [UIColor clearColor].CGColor;
    testLeftLayer.borderWidth = 1.f;
    testLeftLayer.strokeColor = [UIColor redColor].CGColor;
    UIBezierPath *leftPath = [UIBezierPath bezierPath];
    [leftPath addArcWithCenter:(CGPoint){fLayer.frame.origin.x+25,fLayer.frame.origin.y+10}
                        radius:15
                    startAngle:0
                      endAngle:M_PI
                     clockwise:YES];
    testLeftLayer.path = leftPath.CGPath;
//    [self.layer addSublayer:testLeftLayer];
    
    [self colorGradientAnimationWithLayer:sLayer
                                    fromValue:(__bridge id _Nullable)(getColor(102, 170, 238, 0.5)).CGColor
                                      toValue:(__bridge id _Nullable)(getColor(102, 170, 238, 0.1)).CGColor];
    [self keyFrameAnimationWithLayer:sLayer path:leftPath];
}

- (void)setThirdAnimation{
    CAShapeLayer *sLayer = self.layer_list[1];
    CAShapeLayer *tLayer = self.layer_list[2];
    //第三段动画路径layer
    CAShapeLayer *testRightLayer = [CAShapeLayer new];
    testRightLayer.fillColor = [UIColor clearColor].CGColor;
    testRightLayer.borderWidth = duration;
    testRightLayer.strokeColor = [UIColor blueColor].CGColor;
    
    UIBezierPath *rightPath = [UIBezierPath bezierPath];
    [rightPath addArcWithCenter:(CGPoint){sLayer.frame.origin.x+25,tLayer.frame.origin.y+10} radius:15 startAngle:0 endAngle:M_PI clockwise:NO];
    testRightLayer.path = rightPath.CGPath;
//    [self.layer addSublayer:testRightLayer];
    
    [self colorGradientAnimationWithLayer:tLayer
                                fromValue:(__bridge id _Nullable)(getColor(102, 170, 238, 0.2)).CGColor
                                  toValue:(__bridge id _Nullable)(getColor(102, 170, 238, 0.5)).CGColor];
    
    [self keyFrameAnimationWithLayer:tLayer path:rightPath];
}

#pragma makr 渐变动画
- (void)colorGradientAnimationWithLayer:(CALayer *)layer fromValue:(id)fromValue toValue:(id)toValue{
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    alphaAnimation.fromValue = fromValue;
    alphaAnimation.toValue = toValue;
    alphaAnimation.duration = duration;
    alphaAnimation.repeatCount = MAXFLOAT;
    [layer addAnimation:alphaAnimation forKey:@"firstAnmiationAlpha"];
}

#pragma mark 路径动画
- (void)keyFrameAnimationWithLayer:(CALayer *)layer path:(UIBezierPath *)path{
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyAnimation.path = path.CGPath;
    keyAnimation.fillMode = kCAFillModeForwards;
    keyAnimation.calculationMode = kCAAnimationPaced;
    keyAnimation.removedOnCompletion = NO;
    keyAnimation.duration = duration;
    keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    keyAnimation.rotationMode = kCAAnimationRotateAutoReverse;
    keyAnimation.repeatCount = MAXFLOAT;
    keyAnimation.calculationMode = kCAAnimationCubic;
    [layer addAnimation:keyAnimation forKey:@"keyFrameAnimation"];
}



@end
