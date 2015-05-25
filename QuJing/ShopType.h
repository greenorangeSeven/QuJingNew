//
//  ShopType.h
//  XuChangLife
//
//  Created by mac on 15/4/16.
//  Copyright (c) 2015年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopType : Jastor

@property (copy, nonatomic) NSString *shopTypeId;
@property (copy, nonatomic) NSString *shopTypeName;
@property (copy, nonatomic) NSString *imgUrl;
@property (copy, nonatomic) NSString *accessId;
@property (copy, nonatomic) NSString *classType;
@property (copy, nonatomic) NSString *sort;
@property (copy, nonatomic) NSString *imgUrlFull;

@property (nonatomic, retain) UIImage *imgData;

@end
