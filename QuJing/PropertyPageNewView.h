//
//  PropertyPageNewView.h
//  QuJing
//
//  Created by Seven on 15/5/26.
//  Copyright (c) 2015年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGFocusImageFrame.h"
#import "SGFocusImageItem.h"

@interface PropertyPageNewView : UIViewController<SGFocusImageFrameDelegate>
{
    NSMutableArray *advDatas;
    SGFocusImageFrame *bannerView;
    int advIndex;
}

@property (weak, nonatomic) IBOutlet UIImageView *advIv;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

//水电缴费
- (IBAction)payFeeAction:(id)sender;
//房屋报修
- (IBAction)repairAction:(id)sender;
//投诉建议
- (IBAction)suitAction:(id)sender;
//快递及时通
- (IBAction)expressAction:(id)sender;
//办事指南
- (IBAction)compassAction:(id)sender;
//物业信息
- (IBAction)coninforAction:(id)sender;

@end
