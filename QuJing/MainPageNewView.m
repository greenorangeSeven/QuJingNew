//
//  MainPageNewView.m
//  QuJing
//
//  Created by Seven on 15/5/25.
//  Copyright (c) 2015年 Seven. All rights reserved.
//

#import "MainPageNewView.h"
#import "AppDelegate.h"
#import "YRSideViewController.h"
#import "MyFrameView.h"
#import "CommDetailView.h"
#import "ActivityDetailView.h"
#import "CommodityDetailView.h"
#import "CreateRepairView.h"
#import "NoticeTableView.h"
#import "CreateSuitView.h"
#import "PayFeeView.h"
#import "ActivityTableView.h"
#import "OverviewFrameView.h"
#import "ExpressFrameView.h"
#import "CommodityClassView.h"
#import "TradeFrameView.h"
#import "ConvenienceTypeView.h"

@interface MainPageNewView ()
{
    UserInfo *userInfo;
}

@property (strong, nonatomic) YRSideViewController *sideViewController;

@end

@implementation MainPageNewView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.text = @"曲靖智慧社区";
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = UITextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    UIButton *lBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 21, 19)];
    [lBtn addTarget:self action:@selector(showLeftAction:) forControlEvents:UIControlEventTouchUpInside];
    [lBtn setImage:[UIImage imageNamed:@"leftbtn"] forState:UIControlStateNormal];
    UIBarButtonItem *btnLeft = [[UIBarButtonItem alloc]initWithCustomView:lBtn];
    self.navigationItem.leftBarButtonItem = btnLeft;
    
    UIButton *rBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 21, 19)];
    [rBtn addTarget:self action:@selector(showSettingAction:) forControlEvents:UIControlEventTouchUpInside];
    [rBtn setImage:[UIImage imageNamed:@"header_my"] forState:UIControlStateNormal];
    UIBarButtonItem *btnTel = [[UIBarButtonItem alloc]initWithCustomView:rBtn];
    self.navigationItem.rightBarButtonItem = btnTel;
    
    userInfo = [[UserModel Instance] getUserInfo];
    
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.sideViewController = [delegate sideViewController];
    
    [self getADVData];
}

- (void)getADVData
{
    //如果有网络连接
    if ([UserModel Instance].isNetworkRunning) {
        //生成获取广告URL
        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
        [param setValue:@"1141788149430600" forKey:@"typeId"];
        [param setValue:userInfo.defaultUserHouse.cellId forKey:@"cellId"];
        [param setValue:@"1" forKey:@"timeCon"];
        NSString *getADDataUrl = [Tool serializeURL:[NSString stringWithFormat:@"%@%@", api_base_url, api_findAdInfoList] params:param];
        
        [[AFOSCClient sharedClient]getPath:getADDataUrl parameters:Nil
                                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                       @try {
                                           advDatas = [Tool readJsonStrToAdinfoArray:operation.responseString];
                                           int length = [advDatas count];
                                           
                                           NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:length+2];
                                           if (length > 1)
                                           {
                                               ADInfo *adv = [advDatas objectAtIndex:length-1];
                                               
                                               NSString *title = [NSString stringWithFormat:@"  %@\n", adv.adName];
                                               NSMutableAttributedString *title_NSAS = [[NSMutableAttributedString alloc] initWithString:title];
                                               [title_NSAS addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:14.0] range:NSMakeRange(0, [adv.adName length] + 2)];
                                               
                                               NSString *content = [NSString stringWithFormat:@"  %@", adv.synopsis];
                                               NSMutableAttributedString *C_NSAS = [[NSMutableAttributedString alloc] initWithString:content];
                                               [C_NSAS addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:12.0] range:NSMakeRange(0, [content length])];
                                               
                                               [title_NSAS appendAttributedString:C_NSAS];
                                               
                                               SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithTitle:title_NSAS image:adv.imgUrlFull tag:length-1];
                                               [itemArray addObject:item];
                                           }
                                           for (int i = 0; i < length; i++)
                                           {
                                               ADInfo *adv = [advDatas objectAtIndex:i];
                                               
                                               NSString *title = [NSString stringWithFormat:@"  %@\n", adv.adName];
                                               NSMutableAttributedString *title_NSAS = [[NSMutableAttributedString alloc] initWithString:title];
                                               [title_NSAS addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:14.0] range:NSMakeRange(0, [adv.adName length] + 2)];
                                               
                                               NSString *content = [NSString stringWithFormat:@"  %@", adv.synopsis];
                                               NSMutableAttributedString *C_NSAS = [[NSMutableAttributedString alloc] initWithString:content];
                                               [C_NSAS addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:12.0] range:NSMakeRange(0, [content length])];
                                               
                                               [title_NSAS appendAttributedString:C_NSAS];
                                               
                                               SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithTitle:title_NSAS image:adv.imgUrlFull tag:i];
                                               [itemArray addObject:item];
                                               
                                           }
                                           //添加第一张图 用于循环
                                           if (length >1)
                                           {
                                               ADInfo *adv = [advDatas objectAtIndex:0];
                                               
                                               NSString *title = [NSString stringWithFormat:@"  %@\n", adv.adName];
                                               NSMutableAttributedString *title_NSAS = [[NSMutableAttributedString alloc] initWithString:title];
                                               [title_NSAS addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:14.0] range:NSMakeRange(0, [adv.adName length] + 2)];
                                               
                                               NSString *content = [NSString stringWithFormat:@"  %@", adv.synopsis];
                                               NSMutableAttributedString *C_NSAS = [[NSMutableAttributedString alloc] initWithString:content];
                                               [C_NSAS addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:12.0] range:NSMakeRange(0, [content length])];
                                               
                                               [title_NSAS appendAttributedString:C_NSAS];
                                               
                                               SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithTitle:title_NSAS image:adv.imgUrlFull tag:0];
                                               [itemArray addObject:item];
                                           }
                                           bannerView = [[SGFocusImageFrame alloc] initWithFrame:CGRectMake(0, 0, 320, 207) delegate:self imageItems:itemArray isAuto:YES];
                                           [bannerView scrollToIndex:0];
                                           [self.advIv addSubview:bannerView];
                                       }
                                       @catch (NSException *exception) {
                                           [NdUncaughtExceptionHandler TakeException:exception];
                                       }
                                       @finally {
                                           
                                       }
                                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                       if ([UserModel Instance].isNetworkRunning == NO) {
                                           return;
                                       }
                                       if ([UserModel Instance].isNetworkRunning) {
                                           [Tool showCustomHUD:@"网络不给力" andView:self.view  andImage:@"37x-Failure.png" andAfterDelay:1];
                                       }
                                   }];
    }
}

//顶部图片滑动点击委托协议实现事件
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(SGFocusImageItem *)item
{
    ADInfo *adv = (ADInfo *)[advDatas objectAtIndex:advIndex];
    if (adv)
    {
        //0：通知（如果URL为空就是广告）     1:活动      2：商品
        if (adv.expansionTypeId == 0) {
            if ([adv.url length] > 0) {
                NSString *pushDetailHtm = [NSString stringWithFormat:@"%@%@%@", api_base_urlnotport, htm_pushDetailHtm ,adv.url];
                CommDetailView *detailView = [[CommDetailView alloc] init];
                detailView.titleStr = @"物业通知";
                detailView.urlStr = pushDetailHtm;
                detailView.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:detailView animated:YES];
            }
            else
            {
                NSString *adDetailHtm = [NSString stringWithFormat:@"%@%@%@", api_base_urlnotport, htm_adDetail ,adv.adId];
                CommDetailView *detailView = [[CommDetailView alloc] init];
                detailView.titleStr = @"详情";
                detailView.urlStr = adDetailHtm;
                detailView.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:detailView animated:YES];
            }
        }
        else if (adv.expansionTypeId == 1) {
            ActivityDetailView *detailView = [[ActivityDetailView alloc] init];
            detailView.activityId = adv.url;
            detailView.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailView animated:YES];
        }
        else if (adv.expansionTypeId == 2) {
            CommodityDetailView *detailView = [[CommodityDetailView alloc] init];
            detailView.commodityId = adv.url;
            detailView.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailView animated:YES];
        }
    }
}

//顶部图片自动滑动委托协议实现事件
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame currentItem:(int)index;
{
    advIndex = index;
}

- (void)showLeftAction:(id)sender
{
    [self.sideViewController showLeftViewController:YES];
}

- (void)showSettingAction:(id)sender
{
    MyFrameView *myView = [[MyFrameView alloc] init];
    myView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myView animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    
    [self.sideViewController setNeedSwipeShowMenu:YES];
    [self.sideViewController setRootViewMoveBlock:^(UIView *rootView, CGRect orginFrame, CGFloat xoffset) {
        //使用简单的平移动画
        rootView.frame=CGRectMake(xoffset, orginFrame.origin.y, orginFrame.size.width, orginFrame.size.height);
    }];
    
    bannerView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    bannerView.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

//便民生活
- (IBAction)lifeInfoAction:(id)sender {
    NSString *yellowPageHtm = [NSString stringWithFormat:@"%@%@%@", api_base_urlnotport, htm_yellowPage, AccessId];
    CommDetailView *yellowPageView = [[CommDetailView alloc] init];
    yellowPageView.titleStr = @"便民生活";
    yellowPageView.urlStr = yellowPageHtm;
    yellowPageView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:yellowPageView animated:YES];
}

//社区活动
- (IBAction)activityAction:(id)sender {
    ActivityTableView *activityView = [[ActivityTableView alloc] init];
    activityView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:activityView animated:YES];
}

//物业通知
- (IBAction)noticeAction:(id)sender {
    NoticeTableView *noticeView = [[NoticeTableView alloc] init];
    noticeView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:noticeView animated:YES];
}

//全城特价
- (IBAction)commodityAction:(id)sender {
    CommodityClassView *commodityView = [[CommodityClassView alloc] init];
    commodityView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:commodityView animated:YES];
}

//业主发布
- (IBAction)pushTradeViewAction:(id)sender
{
    TradeFrameView *tradeView = [[TradeFrameView alloc] init];
    tradeView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tradeView animated:YES];
}

//2公里生活圈
- (IBAction)lifeCircleAction:(id)sender
{
    ConvenienceTypeView *convenienceView = [[ConvenienceTypeView alloc] init];
    convenienceView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:convenienceView animated:YES];
}

@end
