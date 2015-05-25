//
//  DiscoveryPageView.m
//  XuChangLife
//
//  Created by Seven on 15-1-6.
//  Copyright (c) 2015年 Seven. All rights reserved.
//

#import "DiscoveryPageView.h"
#import "AppDelegate.h"
#import "YRSideViewController.h"
#import "ExpressFrameView.h"
#import "CommodityClassView.h"
#import "CommDetailView.h"
#import "ErrorView.h"
#import "GrouponClassView.h"
#import "CityView.h"
#import "AppDelegate.h"
#import "YRSideViewController.h"

@interface DiscoveryPageView ()

@end

@implementation DiscoveryPageView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.text = @"发现";
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    YRSideViewController *sideViewController=[delegate sideViewController];
    [sideViewController setNeedSwipeShowMenu:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//快递及时通
- (IBAction)expressAction:(id)sender
{
    ExpressFrameView *expressView = [[ExpressFrameView alloc] init];
    expressView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:expressView animated:YES];
}

//精品推送
- (IBAction)commodityAction:(id)sender
{
    CommodityClassView *commodityView = [[CommodityClassView alloc] init];
    commodityView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:commodityView animated:YES];
}

//团购信息
- (IBAction)tuanAction:(id)sender
{
    GrouponClassView *grouponView = [[GrouponClassView alloc] init];
    grouponView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:grouponView animated:YES];
}

//魅力曲靖
- (IBAction)fwzsAction:(id)sender
{
    CityView *cityView = [[CityView alloc] init];
    cityView.hidesBottomBarWhenPushed = YES;
    cityView.typeId = 1;
    cityView.typeName = @"魅力曲靖";
    [self.navigationController pushViewController:cityView animated:YES];
}

//我是志愿者
- (IBAction)zszxAction:(id)sender {
    CityView *cityView = [[CityView alloc] init];
    cityView.hidesBottomBarWhenPushed = YES;
    cityView.typeId = 2;
    cityView.typeName = @"志愿者";
    [self.navigationController pushViewController:cityView animated:YES];
}

//看曲靖
- (IBAction)seeAction:(id)sender
{
    CityView *cityView = [[CityView alloc] init];
    cityView.hidesBottomBarWhenPushed = YES;
    cityView.typeId = 3;
    cityView.typeName = @"看曲靖";
    [self.navigationController pushViewController:cityView animated:YES];
}

//法制曲靖
- (IBAction)fazhiAction:(id)sender
{
    CityView *cityView = [[CityView alloc] init];
    cityView.hidesBottomBarWhenPushed = YES;
    cityView.typeId = 4;
    cityView.typeName = @"法制曲靖";
    [self.navigationController pushViewController:cityView animated:YES];
}
@end
