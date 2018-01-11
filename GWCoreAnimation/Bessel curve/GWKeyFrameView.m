//
//  GWKeyFrameView.m
//  GWCoreAnimation
//
//  Created by genwei yang on 2018/1/8.
//  Copyright © 2018年 YangGenWei. All rights reserved.
//

#import "GWKeyFrameView.h"

@interface GWKeyFrameView()
{
    UIBezierPath *_bezier;
}
@property (nonatomic,readwrite,strong)UIButton *beginButton;
@property (nonatomic,readwrite,strong)UILabel *label;
@end

@implementation GWKeyFrameView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setKeyFrameAnimation];
        
        [self addSubview:self.label];
        [self addSubview:self.beginButton];
    }
    return self;
}

- (void)setKeyFrameAnimation{
    
    _bezier = [UIBezierPath bezierPath];
    [_bezier moveToPoint:(CGPoint){0,100}];
    [_bezier addLineToPoint:(CGPoint){kSCREENWIDTH,100}];
    [_bezier addLineToPoint:(CGPoint){0,200}];
    [_bezier addLineToPoint:(CGPoint){kSCREENWIDTH,200}];
    [_bezier closePath];
    [_bezier setLineWidth:0.2];
}


- (void)beiginAnimationAction{
    //    //缩放设置
    //    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    //    keyAnimation.values = @[@1,@2,@3,@4,@3,@2,@1];
    //    keyAnimation.duration = 3.0f;
    //     keyAnimation.keyTimes = @[@(1),@(1),@(1)];
    //    [self.label.layer addAnimation:keyAnimation forKey:@"transform.scale"];
    
    //路径动画
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyAnimation.path = _bezier.CGPath;
    //    keyAnimation.keyTimes = @[@(0.0f),@(0.1f),@(0.2),@(0.3),@(0.4)];
    keyAnimation.duration = 3.0f;
    keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    keyAnimation.rotationMode = kCAAnimationRotateAuto;
    [self.label.layer addAnimation:keyAnimation forKey:@"position"];
}

#pragma mark - getter and setter
- (UIButton *)beginButton{
    if(!_beginButton){
        _beginButton = [[UIButton alloc] initWithFrame:(CGRect){kSCREENWIDTH/2-50,250,100,30}];
        [_beginButton setTitle:@"开始" forState:UIControlStateNormal];
        [_beginButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [_beginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _beginButton.layer.borderColor = [UIColor blackColor].CGColor;
        [_beginButton addTarget:self action:@selector(beiginAnimationAction) forControlEvents:UIControlEventTouchUpInside];
        _beginButton.layer.borderWidth = 0.5f;
        
    }return _beginButton;
}

- (UILabel *)label{
    if(!_label){
        CGFloat width = 40;
        CGPoint center = (CGPoint){kSCREENWIDTH/2-width/2,kSCREENHEIGHT/2-width/2};
        _label= [[UILabel alloc] initWithFrame:(CGRect){0,100,width,width}];
        [_label setBackgroundColor:hexStrColor(@"#FF8C69")];
    }return _label;
}

@end
