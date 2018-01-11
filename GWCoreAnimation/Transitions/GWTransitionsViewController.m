//
//  GWTransitionsViewController.m
//  GWCoreAnimation
//
//  Created by genwei yang on 2017/12/18.
//  Copyright © 2017年 YangGenWei. All rights reserved.
//

#import "GWTransitionsViewController.h"
#define  DURATION  1

typedef NS_ENUM(NSInteger,GWTransitionsAnimationType){
    FadeAnimationType = 0,                   //淡入淡出
    PushAnimationType,                       //推挤
    RevealAnimationType,                     //揭开
    MoveInAnimationType,                     //覆盖
    CubeAnimationType,                       //立方体
    SuckEffectAnimationType,                 //吮吸
    OglFlipAnimationType,                    //翻转
    RippleEffectAnimationType,               //波纹
    PageCurlAnimationType,                   //翻页
    PageUnCurlAnimationType,                 //反翻页
    CameraIrisHollowOpenAnimationType,       //开镜头
    CameraIrisHollowCloseAnimationType,      //关镜头
    CurlDownAnimationType,                   //下翻页
    CurlUpAnimationType,                     //上翻页
    FlipFromLeftAnimationType,               //左翻转
    FlipFromRightAnimationType,              //右翻转
    CustomAnimationType//自定义动画
};

@interface GWTransitionsViewController ()<CAAnimationDelegate>
@property (nonatomic,readwrite,strong)UIImageView *fView;
@end

@implementation GWTransitionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"转场动画";
    self.tabBarItem.title = @"转场";
    
    [self.view addSubview:self.fView];

    [self.view addSubview:[self buttonsView]];
}

- (UIView *)buttonsView{
    NSArray *buttonNames = @[@"淡化",@"Push",@"揭开",@"覆盖",@"立方体",@"吮吸",@"翻转",@"波纹",@"正向翻页",@"反向翻页",@"开镜头",@"关镜头",@"下翻页",@"上翻页",@"左翻转",@"右翻转"];
    UIView *newView = [UIView new];
    UIButton *button = nil;
    int x = 0;
    int y = 0;
    CGFloat buttonWidth = kSCREENWIDTH/5;
    CGFloat buttonHeight = 30;
    int count = 0;
    for (NSString *title in buttonNames) {
        button = [[UIButton alloc] initWithFrame:(CGRect){x,y,buttonWidth,buttonHeight}];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button layer].cornerRadius = 3;
        [button layer].borderColor = [UIColor clearColor].CGColor;
        [button layer].borderWidth = 0;
        button.tag = count++;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        if(count %5 == 0){
            x = 0;
            y+=buttonHeight;
        }else{
            x+=buttonWidth;
        }
        [newView addSubview:button];
    }
    
    [newView setFrame:(CGRect){0,kSCREENHEIGHT-170,kSCREENWIDTH,120}];
    return newView;
}


- (void)buttonAction:(UIButton *)button{
    
    NSInteger subType = random()%4;
    NSString *subStr = @"";
    NSLog(@"subType:%ld",subType);
    switch (subType) {
        case 0:
            subStr = kCATransitionFromLeft;
            break;
        case 1:
            subStr = kCATransitionFromBottom;
            break;
        case 2:
            subStr = kCATransitionFromRight;
            break;
        case 3:
            subStr = kCATransitionFromTop;
            break;
        default:
            break;
    }
    
    switch (button.tag) {
        case FadeAnimationType://淡入淡出
            [self animationWithType:kCATransitionFade subType:subStr forView:self.fView];
            break;
        case PushAnimationType://推挤
            [self animationWithType:kCATransitionPush subType:subStr forView:self.fView];
            break;
        case RevealAnimationType://揭开
            [self animationWithType:kCATransitionReveal subType:subStr forView:self.fView];
            break;
        case MoveInAnimationType://覆盖
            [self animationWithType:kCATransitionMoveIn subType:subStr forView:self.fView];
            break;
        case CubeAnimationType: //立方体
             [self animationWithType:@"cube" subType:subStr forView:self.fView];
            break;
        case SuckEffectAnimationType://吮吸
             [self animationWithType:@"suckEffect" subType:subStr forView:self.fView];
            break;
        case OglFlipAnimationType://翻转
             [self animationWithType:@"oglFlip" subType:subStr forView:self.fView];
            break;
        case RippleEffectAnimationType://波纹
             [self animationWithType:@"rippleEffect" subType:subStr forView:self.fView];
            break;
        case PageCurlAnimationType://翻页
             [self animationWithType:@"pageCurl" subType:subStr forView:self.fView];
            break;
        case PageUnCurlAnimationType://反翻页
             [self animationWithType:@"pageUnCurl" subType:subStr forView:self.fView];
            break;
        case CameraIrisHollowOpenAnimationType://开镜头
             [self animationWithType:@"cameraIrisHollowOpen" subType:subStr forView:self.fView];
            break;
        case CameraIrisHollowCloseAnimationType: //关镜头
             [self animationWithType:@"cameraIrisHollowClose" subType:subStr forView:self.fView];
            break;
        case CurlDownAnimationType://下翻页
            [self animationWithView:self.fView transitionType:UIViewAnimationTransitionCurlDown];
            break;
        case CurlUpAnimationType://上翻页
            [self animationWithView:self.fView transitionType:UIViewAnimationTransitionCurlUp];
            break;
        case FlipFromLeftAnimationType: //左翻页
            [self animationWithView:self.fView transitionType:UIViewAnimationTransitionFlipFromLeft];
            break;
        case FlipFromRightAnimationType://右翻页
            [self animationWithView:self.fView transitionType:UIViewAnimationTransitionFlipFromRight];
            break;
        default:
            break;
            
    }
    
    static int i = 0;
    [_fView setImage:[UIImage imageNamed:(i = !i)?@"gyy1":@"gyy2"]];
}

- (void)animationWithType:(NSString *)type subType:(NSString *)subType forView:(UIView *)forView{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    //设置运动时间
    animation.duration = DURATION;
    animation.delegate = self;
    //设置运动type
    animation.type = type;
    if(animation.subtype !=nil){
        animation.subtype = subType;
    }
    //设置运动速度
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [forView.layer addAnimation:animation forKey:@"animation"];
}


- (void)animationWithView:(UIView *)view transitionType:(UIViewAnimationTransition) transition
{
    [UIView animateWithDuration:DURATION animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}

- (void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"动画已经开始了");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"动画已经结束了");
}

- (UIImageView *)fView{
    if(!_fView){
        _fView = [[UIImageView alloc] initWithFrame:(CGRect){0,0,kSCREENWIDTH,kSCREENHEIGHT - 170}];
        [_fView setImage:[UIImage imageNamed:@"gyy1"]];
    }return _fView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
