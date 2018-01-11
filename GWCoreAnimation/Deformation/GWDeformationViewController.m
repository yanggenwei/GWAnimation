//
//  GWDeformationViewController.m
//  GWCoreAnimation
//
//  Created by genwei yang on 2017/12/18.
//  Copyright © 2017年 YangGenWei. All rights reserved.
//

#import "GWDeformationViewController.h"

typedef NS_ENUM(NSInteger,GWDeformationType){
    GWAnimationDisplacementUp,//位移
    GWAnimationDisplacementDown,
    GWAnimationDisplacementLeft,
    GWAnimationDisplacementRight,
    GWAnimationZoomEnlargement,        //缩放
    GWAnimationZoomOut,
    GWAnimationRotatingClockwise,    //旋转
    GWAnimationRotatingAnticlockwise,
    GWAnimationDeformation,  //形变
    GWAnimationInvert,       //反转
    GWAnimationConcat       //合并
};


@interface GWDeformationViewController ()
@property (nonatomic,readwrite,strong)UIView *showView;
@property (nonatomic,readwrite,strong)UIView *concatView;
@end

@implementation GWDeformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem.title = @"形变";
    
    [self.view addSubview:self.concatView];
    [self.view addSubview:self.showView];
    [self addButtons];
}

#pragma mark 添加按钮视图
- (void)addButtons{
    NSArray *buttonTitles = @[@"上",@"下",@"左",@"右",@"放大",@"缩小",@"顺时针",@"逆时针",@"形变",@"反转",@"合并"];
    UIButton *button;
    CGFloat buttonHeight = 30;
    NSInteger index = 0;
    CGFloat x = 0;
    CGFloat y = kSCREENHEIGHT-84-buttonHeight*2-10;
    for (NSString *title in buttonTitles) {
        button = [[UIButton alloc] initWithFrame:(CGRect){x,y,kSCREENWIDTH/6,buttonHeight}];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = index;
        [self.view addSubview:button];
       
        if((index+1)%6==0){
            y+=buttonHeight+1;
            x = 0;
        }else{
             x += kSCREENWIDTH/6;
        }
        index++;
    }
}

#pragma mark 按钮点击事件
- (void)buttonAction:(UIButton *)button{
    
    [self.showView.layer removeAllAnimations];
    switch (button.tag) {
        case GWAnimationDisplacementUp://上移
            self.showView.transform  = CGAffineTransformTranslate(self.showView.transform, 0,-10);
            break;
        case GWAnimationDisplacementDown://下移
            self.showView.transform  = CGAffineTransformTranslate(self.showView.transform, 0,10);
            break;
        case GWAnimationDisplacementLeft://左移
            self.showView.transform  = CGAffineTransformTranslate(self.showView.transform, -10,0);
            break;
        case GWAnimationDisplacementRight://右移
            self.showView.transform  = CGAffineTransformTranslate(self.showView.transform, 10,0);
            break;
        case GWAnimationZoomEnlargement: //放大
            self.showView.transform = CGAffineTransformScale(self.showView.transform,1.5,1.5);
            break;
        case GWAnimationZoomOut://缩小
            self.showView.transform = CGAffineTransformScale(self.showView.transform,0.5,0.5);
            break;
        case GWAnimationRotatingClockwise://顺时针
            self.showView.transform = CGAffineTransformRotate(self.showView.transform, 90);
            break;
        case GWAnimationRotatingAnticlockwise://逆时针
            self.showView.transform = CGAffineTransformRotate(self.showView.transform, -90);
            break;
        case GWAnimationDeformation://形变
        {
            [UIView animateWithDuration:1 animations:^{
                self.showView.transform = CGAffineTransformMakeScale(1.5,1.5);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:1 animations:^{
                    self.showView.transform = CGAffineTransformScale(self.showView.transform,0.5,0.5);
                    self.showView.transform = CGAffineTransformRotate(self.showView.transform, 180);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:1 animations:^{
                        self.showView.transform = CGAffineTransformScale(self.showView.transform,2,2);
                        self.showView.transform = CGAffineTransformRotate(self.showView.transform, -180);
                    } completion:^(BOOL finished) {
                    }];
                }];
            }];
            break;
        }
            
        case GWAnimationInvert:
             self.showView.transform = CGAffineTransformInvert(self.showView.transform);
            break;
        case GWAnimationConcat:
             self.concatView.transform = CGAffineTransformConcat(self.concatView.transform, self.showView.transform);
            break;
            
        default:
            break;
    }
}

#pragma mark - getter and setter
#pragma mark 展示视图
- (UIView *)showView{
    if(!_showView){
        CGFloat width = 100;
        _showView = [[UIView alloc] initWithFrame:(CGRect){kSCREENWIDTH/2-width/2,marginTop(self.concatView)+10,width,width}];
        [_showView setBackgroundColor:hexStrColor(@"#EE7600")];
    }return _showView;
}
#pragma mark 连接视图
- (UIView *)concatView{
    if(!_concatView){
        CGFloat width = 100;
        _concatView = [[UIView alloc] initWithFrame:(CGRect){kSCREENWIDTH/2-width/2,kSCREENHEIGHT/2-width,width,width}];
        [_concatView setBackgroundColor:hexStrColor(@"#EB7600")];
    }return _concatView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
