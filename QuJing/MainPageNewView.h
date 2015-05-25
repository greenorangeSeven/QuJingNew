//
//  MainPageNewView.h
//  QuJing
//
//  Created by Seven on 15/5/25.
//  Copyright (c) 2015年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGFocusImageFrame.h"
#import "SGFocusImageItem.h"

@interface MainPageNewView : UIViewController<SGFocusImageFrameDelegate>
{
    NSMutableArray *advDatas;
    SGFocusImageFrame *bannerView;
    int advIndex;
}

@property (weak, nonatomic) IBOutlet UIImageView *advIv;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

//社区活动
- (IBAction)activityAction:(id)sender;
//全城特价
- (IBAction)commodityAction:(id)sender;
//物业通知
- (IBAction)noticeAction:(id)sender;
//生活信息
- (IBAction)lifeInfoAction:(id)sender;
//业主发布
- (IBAction)pushTradeViewAction:(id)sender;
//2公里生活圈
- (IBAction)lifeCircleAction:(id)sender;

@end
