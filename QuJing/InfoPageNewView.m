//
//  InfoPageNewView.m
//  QuJing
//
//  Created by Seven on 15/5/25.
//  Copyright (c) 2015年 Seven. All rights reserved.
//

#import "InfoPageNewView.h"
#import "CommDetailView.h"
#import "ActivityDetailView.h"
#import "CommodityDetailView.h"
#import "CityDetailView.h"
#import "News.h"
#import "AppDelegate.h"
#import "YRSideViewController.h"

@interface InfoPageNewView ()

@end

@implementation InfoPageNewView
{
    NSMutableArray *newArray;
    NSString *cityId;
    NSString *advId;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.text = @"资讯";
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = UITextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    hud = [[MBProgressHUD alloc] initWithView:self.view];
    
    //下拉刷新
    if (_refreshHeaderView == nil)
    {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, -320.0f, self.view.frame.size.width, 320)];
        view.delegate = self;
        [self.tableView addSubview:view];
        _refreshHeaderView = view;
    }
    
    cityId = @"1143009607141700";
    
    allCount = 0;
    [_refreshHeaderView refreshLastUpdatedDate];
    self.view.backgroundColor = [Tool getBackgroundColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = [Tool getBackgroundColor];
    
    newArray = [NSMutableArray arrayWithCapacity:20];
    [self reload:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (isInitialize == NO)
    {
        isInitialize = YES;
        [self reload:YES];
    }
}

- (void)doneManualRefresh
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:self.tableView];
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:self.tableView];
}

#pragma 生命周期
- (void)viewDidUnload
{
    [self setTableView:nil];
    _refreshHeaderView = nil;
    [newArray removeAllObjects];
    newArray = nil;
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)clear
{
    allCount = 0;
    [newArray removeAllObjects];
    isLoadOver = NO;
}

#pragma 下提刷新
- (void)reloadTableViewDataSource
{
    _reloading = YES;
}

- (void)doneLoadingTableViewData
{
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}

- (void)reload:(BOOL)noRefresh
{
    
    if (isLoading || isLoadOver)
    {
        return;
    }
    
    if (!noRefresh)
    {
        allCount = 0;
    }
    int pageIndex = allCount/20 + 1;
    
    //生成获取新闻列表URL
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:[NSString stringWithFormat:@"%d", pageIndex] forKey:@"pageNumbers"];
    [param setValue:@"20" forKey:@"countPerPages"];
    [param setValue:cityId forKey:@"typeId"];
    
    NSString *getNoticeListUrl = [Tool serializeURL:[NSString stringWithFormat:@"%@%@", api_base_url, api_findInformationByPage] params:param];
    
    [[AFOSCClient sharedClient]getPath:getNoticeListUrl parameters:Nil
                               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                   NSLog(@"the res:%@",operation.responseString);
                                   NSData *data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
                                   NSError *error;
                                   NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                   
                                   NSArray *arry = [[json objectForKey:@"data"] objectForKey:@"resultsList"];
                                   
                                   NSMutableArray *newlist = [NSMutableArray arrayWithArray:[Tool readJsonToObjArray:arry andObjClass:[News class]]];
                                   
                                   isLoading = NO;
                                   if (!noRefresh)
                                   {
                                       [self clear];
                                   }
                                   
                                   @try {
                                       int count = [newlist count];
                                       allCount += count;
                                       if (count < 20)
                                       {
                                           isLoadOver = YES;
                                       }
                                       [newArray addObjectsFromArray:newlist];
                                       [self.tableView reloadData];
                                       [self doneLoadingTableViewData];
                                   }
                                   @catch (NSException *exception) {
                                       [NdUncaughtExceptionHandler TakeException:exception];
                                   }
                                   @finally {
                                       [self doneLoadingTableViewData];
                                   }
                               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                   NSLog(@"列表获取出错");
                                   //如果是刷新
                                   [self doneLoadingTableViewData];
                                   
                                   if ([UserModel Instance].isNetworkRunning == NO) {
                                       return;
                                   }
                                   isLoading = NO;
                                   if ([UserModel Instance].isNetworkRunning) {
                                       [Tool showCustomHUD:@"网络不给力" andView:self.view  andImage:@"37x-Failure.png" andAfterDelay:1];
                                   }
                               }];
    isLoading = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    [self reloadTableViewDataSource];
    [self refresh];
}

- (void)refresh
{
    if ([UserModel Instance].isNetworkRunning)
    {
        isLoadOver = NO;
        [self reload:NO];
    }
}

//2013.12.18song. tableView添加上拉更新
- (void)egoRefreshTableHeaderDidTriggerToBottom
{
    if (!isLoading)
    {
        [self performSelector:@selector(reload:)];
    }
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
{
    return _reloading;
}

- (NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    return NSDate.date;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([UserModel Instance].isNetworkRunning)
    {
        if (isLoadOver)
        {
            return newArray.count == 0 ? 1 : newArray.count + 1;
        }
        else
            return newArray.count + 1;
    }
    else
        return newArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([newArray count] > 0)
    {
        if (indexPath.row < [newArray count])
        {
            CityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityCell"];
            if (!cell)
            {
                NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"CityCell" owner:self options:nil];
                for (NSObject *o in objects)
                {
                    if ([o isKindOfClass:[CityCell class]])
                    {
                        cell = (CityCell *)o;
                        break;
                    }
                }
            }
            News *news = [newArray objectAtIndex:[indexPath row]];
            cell.titleLb.text = news.infoName;
            cell.summaryLb.text = news.synopsis;
            if (news.imgUrlFull)
            {
                [cell.thumImg sd_setImageWithURL:[NSURL URLWithString:news.imgUrlFull]];
            }
            return cell;
        }
        else
        {
            return [[DataSingleton Instance] getLoadMoreCell:tableView andIsLoadOver:isLoadOver andLoadOverString:@"已经加载全部内容" andLoadingString:(isLoading ? loadingTip : loadNext20Tip) andIsLoading:isLoading];
        }
    }
    else
    {
        return [[DataSingleton Instance] getLoadMoreCell:tableView andIsLoadOver:isLoadOver andLoadOverString:@"暂无数据" andLoadingString:(isLoading ? loadingTip : loadNext20Tip)  andIsLoading:isLoading];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < newArray.count)
    {
        return 92;
    }
    else
    {
        return 62;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    int row = [indexPath row];
    //点击“下面20条”
    if (row >= [newArray count]) {
        //启动刷新
        if (!isLoading) {
            [self performSelector:@selector(reload:)];
        }
    }
    else
    {
        News *art = [newArray objectAtIndex:[indexPath row]];
        if (art)
        {
            CityDetailView *cityDetailView = [[CityDetailView alloc] init];
            cityDetailView.infoId = art.infoId;
            cityDetailView.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cityDetailView animated:YES];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    YRSideViewController *sideViewController=[delegate sideViewController];
    [sideViewController setNeedSwipeShowMenu:NO];
}

- (IBAction)item1Action:(id)sender {
    [self.item1Btn setTitleColor:[Tool getColorForMain] forState:UIControlStateNormal];
    [self.item1Btn setBackgroundImage:[UIImage imageNamed:@"activity_tab_bg"] forState:UIControlStateNormal];
    [self.item2Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.item2Btn setBackgroundImage:nil forState:UIControlStateNormal];
    [self.item3Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.item3Btn setBackgroundImage:nil forState:UIControlStateNormal];
    cityId = @"1143009607141700";
    isLoadOver = NO;
    [self reload:NO];
}

- (IBAction)item2Action:(id)sender {
    [self.item1Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.item1Btn setBackgroundImage:nil forState:UIControlStateNormal];
    [self.item2Btn setTitleColor:[Tool getColorForMain] forState:UIControlStateNormal];
    [self.item2Btn setBackgroundImage:[UIImage imageNamed:@"activity_tab_bg"] forState:UIControlStateNormal];
    [self.item3Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.item3Btn setBackgroundImage:nil forState:UIControlStateNormal];
    cityId = @"1143009608148100";
    isLoadOver = NO;
    [self reload:NO];
}

- (IBAction)item3Action:(id)sender {
    [self.item1Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.item1Btn setBackgroundImage:nil forState:UIControlStateNormal];
    [self.item2Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.item2Btn setBackgroundImage:nil forState:UIControlStateNormal];
    [self.item3Btn setTitleColor:[Tool getColorForMain] forState:UIControlStateNormal];
    [self.item3Btn setBackgroundImage:[UIImage imageNamed:@"activity_tab_bg"] forState:UIControlStateNormal];
    cityId = @"1143009609538500";
    isLoadOver = NO;
    [self reload:NO];
}

@end
