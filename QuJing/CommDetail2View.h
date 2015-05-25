//
//  CommDetail2View.h
//  QuJing
//
//  Created by Seven on 15/5/25.
//  Copyright (c) 2015年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommDetail2View : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) UIView *frameView;

@property (copy, nonatomic) NSString *present;
@property (copy, nonatomic) NSString *titleStr;
@property (copy, nonatomic) NSString *urlStr;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
