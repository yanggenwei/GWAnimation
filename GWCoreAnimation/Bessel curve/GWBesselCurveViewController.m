//
//  GWBesselCurveViewController.m
//  GWCoreAnimation
//
//  Created by genwei yang on 2017/12/18.
//  Copyright © 2017年 YangGenWei. All rights reserved.
//

#import "GWBesselCurveViewController.h"
#import "GWTableHeadView.h"
#import "GWLoadingView.h"

@interface GWBesselCurveViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,readwrite,strong)UITableView *tableView;
@property (nonatomic,readwrite,strong)GWTableHeadView *headerView;
@end

@implementation GWBesselCurveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem.title = @"贝塞尔";
    //表格下拉动画
//    self.headerView = [[GWTableHeadView alloc] initWithFrame:(CGRect){0,statusBarHeight,kSCREENWIDTH,0}];
//    [self.view addSubview:self.tableView];
//    [self.view addSubview:self.headerView];
    
    //加载动画
    GWLoadingView *loadingView = [[GWLoadingView alloc] initWithFrame:(CGRect){0,kSCREENHEIGHT/2-30,kSCREENWIDTH,60}];
    [self.view addSubview:loadingView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"tableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.textLabel.text = @"小胖子";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.headerView.offsetY = -scrollView.contentOffset.y;
    [self.headerView setNeedsDisplay];
    [self.headerView setFrame:(CGRect){0,statusBarHeight,kSCREENWIDTH,- scrollView.contentOffset.y}];

}

#pragma mark - getter and setter
#pragma mark 表格初始化
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:(CGRect){0,44,kSCREENWIDTH,kSCREENHEIGHT-44} style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
