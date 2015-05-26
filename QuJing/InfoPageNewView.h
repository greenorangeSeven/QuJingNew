//
//  InfoPageNewView.h
//  QuJing
//
//  Created by Seven on 15/5/25.
//  Copyright (c) 2015年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityCell.h"
#import "CityDetailView.h"

@interface InfoPageNewView : UIViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate,MBProgressHUDDelegate>
{
    BOOL isLoading;
    BOOL isLoadOver;
    int allCount;
    
    //下拉刷新
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    
    NSString *catalog;
    BOOL isInitialize;
    
    UIWebView *phoneCallWebView;
    
    MBProgressHUD *hud;
}

@property (assign, nonatomic) int typeId;
@property (copy, nonatomic) NSString *typeName;

@property (weak, nonatomic) IBOutlet UIButton *item1Btn;
@property (weak, nonatomic) IBOutlet UIButton *item2Btn;
@property (weak, nonatomic) IBOutlet UIButton *item3Btn;

- (IBAction)item1Action:(id)sender;
- (IBAction)item2Action:(id)sender;
- (IBAction)item3Action:(id)sender;

- (void)reload:(BOOL)noRefresh;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
//清空
- (void)clear;

//下拉刷新
- (void)refresh;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
