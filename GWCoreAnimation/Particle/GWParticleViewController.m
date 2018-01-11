//
//  GWParticleViewController.m
//  GWCoreAnimation
//
//  Created by genwei yang on 2017/12/18.
//  Copyright © 2017年 YangGenWei. All rights reserved.
//

#import "GWParticleViewController.h"

@interface GWParticleViewController ()
@property (nonatomic,readwrite,strong)UIButton *likeButton; //点赞按钮
@property (nonatomic,readwrite,strong)CAEmitterLayer *emitterLayer; 
@property (nonatomic,readwrite,strong)CAEmitterLayer *touchEmitterLayer;
@end

@implementation GWParticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem.title = @"粒子";
    [self.view addSubview:self.likeButton];
    [self configerEmitterLayer];
}

#pragma mark 点赞按钮点击事件
- (void)likeButtonClickAction{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@1.4,@0.7,@1.0,@1.3,@1.0];
    animation.duration = 0.5;
    [self startFire];
    animation.calculationMode = kCAAnimationCubic;
    [self.likeButton.layer addAnimation:animation forKey:@"transform.scale"];
}

#pragma mark 开始渲染粒子动画
- (void)startFire{
    CAEmitterCell *cell = self.emitterLayer.emitterCells[0];
    [cell setBirthRate:30.f];
    [self.emitterLayer setBirthRate:30.f];
    self.emitterLayer.beginTime = CACurrentMediaTime();
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          [self.emitterLayer setBirthRate:0.f];
    });
}


- (void)configerEmitterLayer{
    self.emitterLayer = [[CAEmitterLayer alloc] init];
    //发射的位置
    [self.emitterLayer setEmitterPosition:self.likeButton.center];
    //发射源的尺寸大小
    self.emitterLayer.emitterSize  = (CGSize){150,150};
    //发射源的形状
    self.emitterLayer.emitterShape = kCAEmitterLayerCircle;
    self.emitterLayer.emitterMode = kCAEmitterLayerSurface;
    CAEmitterCell *cell = [CAEmitterCell new];
    //cell的内容,即图形
    cell.contents = (id)[PMBTools getBuddleImage:@"start" imageType:@"png"].CGImage;
    //每秒中粒子的数量
    cell.birthRate = 0.f;
    //粒子从出生到结束的时间
    cell.lifetime = .8f;
    //粒子生存浮动的时间, [lifetime - lifetimeRange]
    cell.lifetimeRange = 1.2f;
    
    cell.zAcceleration = 1.f;
    //运动的速度
    cell.velocity = 30.f;
    //运动浮动速度[velocity - velocityRange]
    cell.velocityRange = 4.f;
    //Y方向的加速度 值越大每个粒子下落的速度越快
    cell.yAcceleration = 15.f;

    //粒子发射出来的角度
    cell.emissionLongitude = 0;
    //粒子发射出来的浮动角度,这个角度决定了粒子能够在多大角度范围内扩散
    cell.emissionRange = 180;
    
    //粒子的初始大小
    cell.scale = 0.003;
    //粒子的初始大小的浮动范围 [scal - scaleRange]
    cell.scaleRange = 0.06;
    //粒子缩放的速度
    cell.scaleSpeed = 0.01;
    
//    //粒子的颜色，这里cell可以对图片进行新颜色的填充
//    cell.color = getColor(1.f, 1.f, 1.f, 1).CGColor;
////
//    cell.redRange = 1.0f;
//
//    cell.greenRange = 1.0f;
//
//    cell.blueRange = 1.0f;
////
//    //粒子透明的范围
    cell.alphaRange = 0.8f;
//    //粒子透明的速度
    cell.alphaSpeed = -0.1f;
    
    [self.emitterLayer setEmitterCells:@[cell]];
    [self.view.layer addSublayer:self.emitterLayer];
}


#pragma mark 获取自定义圆形
- (UIImage *)getCircle{
    UIView *view = [[UIView alloc] initWithFrame:(CGRect){0,0,30,30}];
    [view setBackgroundColor:getColor(random()/255.0, random()/255.0, random()/255.0, 1)];
    view.layer.cornerRadius = 15;
    return [PMBTools convertViewToImage:view];
}
#pragma mark - getter and setter
#pragma mark 点赞按钮
- (UIButton *)likeButton{
    if(!_likeButton){
        UIImage *image = [PMBTools getBuddleImage:@"start" imageType:@"png"];
        CGFloat width = 120;
        CGFloat height = 80;
        _likeButton = [[UIButton alloc] initWithFrame:(CGRect){kSCREENWIDTH/2-width/2,kSCREENHEIGHT/2-height/2,width,height}];
        [_likeButton setBackgroundImage:image forState:UIControlStateNormal];
        [_likeButton addTarget:self action:@selector(likeButtonClickAction) forControlEvents:UIControlEventTouchUpInside];
    }return _likeButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
