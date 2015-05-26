//
//  PropertyPageNewView.m
//  QuJing
//
//  Created by Seven on 15/5/26.
//  Copyright (c) 2015年 Seven. All rights reserved.
//

#import "PropertyPageNewView.h"
#import "AppDelegate.h"
#import "YRSideViewController.h"
#import "CommDetailView.h"
#import "ActivityDetailView.h"
#import "CommodityDetailView.h"
#import "CreateRepairView.h"
#import "CreateSuitView.h"
#import "PayFeeView.h"
#import "ExpressFrameView.h"

@interface PropertyPageNewView ()
{
    UserInfo *userInfo;
}

@property (strong, nonatomic) YRSideViewController *sideViewController;

@end

@implementation PropertyPageNewView

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.text = @"物业";
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = UITextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    userInfo = [[UserModel Instance] getUserInfo];
    
    [self getADVData];
}

- (void)getADVData
{
    //如果有网络连接
    if ([UserModel Instance].isNetworkRunning) {
        //生成获取广告URL
        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
        [param setValue:@"1143009618960400" forKey:@"typeId"];
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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    bannerView.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    bannerView.delegate = self;
    
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    YRSideViewController *sideViewController=[delegate sideViewController];
    [sideViewController setNeedSwipeShowMenu:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//水电缴费
- (IBAction)payFeeAction:(id)sender
{
    PayFeeView *payView = [[PayFeeView alloc] init];
    payView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:payView animated:YES];
}

//房屋报修
- (IBAction)repairAction:(id)sender
{
    CreateRepairView *createRepairView = [[CreateRepairView alloc] init];
    createRepairView.parentView = self.view;
    createRepairView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:createRepairView animated:YES];
}

//投诉建议
- (IBAction)suitAction:(id)sender
{
    CreateSuitView *createSuitView = [[CreateSuitView alloc] init];
    createSuitView.parentView = self.view;
    createSuitView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:createSuitView animated:YES];
}

//快递及时通
- (IBAction)expressAction:(id)sender
{
    ExpressFrameView *expressView = [[ExpressFrameView alloc] init];
    expressView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:expressView animated:YES];
}

//办事指南
- (IBAction)compassAction:(id)sender
{
    NSString *workingManualHtm = [NSString stringWithFormat:@"%@%@%@", api_base_urlnotport, htm_workingManual ,AccessId];
    CommDetailView *workingManualView = [[CommDetailView alloc] init];
    workingManualView.titleStr = @"办事指南";
    workingManualView.urlStr = workingManualHtm;
    workingManualView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:workingManualView animated:YES];
}

//物业信息
- (IBAction)coninforAction:(id)sender
{
    NSString *managerInfoHtm = [NSString stringWithFormat:@"%@%@%@", api_base_urlnotport, htm_managerInfo ,userInfo.defaultUserHouse.cellId];
    CommDetailView *managerInfoView = [[CommDetailView alloc] init];
    managerInfoView.titleStr = @"物业信息";
    managerInfoView.urlStr = managerInfoHtm;
    managerInfoView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:managerInfoView animated:YES];
}

@end
