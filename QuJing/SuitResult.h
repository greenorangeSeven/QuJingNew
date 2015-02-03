//
//  SuitResult.h
//  BBK
//
//  Created by Seven on 14-12-14.
//  Copyright (c) 2014年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SuitResult : NSObject

@property (nonatomic, retain) NSString *replyTitle;
@property (nonatomic, retain) NSString *userRecontent;
@property int score;
@property (nonatomic, retain) NSArray *imgList;
@property (nonatomic, retain) NSMutableArray *fullImgList;


@property int contentHeight;
@property int addViewHeight;

@end
