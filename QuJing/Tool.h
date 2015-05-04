//
//  Tool.h
//  oschina
//
//  Created by wangjun on 12-3-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"
#import <CommonCrypto/CommonCryptor.h>
#import "RMMapper.h"
#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>

#import "City.h"
#import "Community.h"
#import "Region.h"
#import "Building.h"
#import "Unit.h"
#import "HouseNum.h"
#import "UserInfo.h"
#import "Activity.h"
#import "Repair.h"
#import "RepairBasic.h"
#import "RepairDispatch.h"
#import "RepairFinish.h"
#import "RepairResult.h"
#import "ADInfo.h"
#import "Notice.h"
#import "Suit.h"
#import "SuitBasic.h"
#import "SuitReply.h"
#import "SuitResult.h"
#import "ExpressInfo.h"
#import "CommodityClass.h"
#import "Commodity.h"
#import "CommodityPropery.h"
#import "Bill.h"
#import "Integral.h"
#import "PeripheralShop.h"
#import "ExpressCompany.h"
#import "MyOrder.h"
#import "MyOrderCommodity.h"
#import "FriendsList.h"
#import "ImgList.h"
#import "FriendsInfo.h"
#import "FriendsReply.h"
#import "OderSubmitVO.h"
#import "OrderShopVO.h"
#import "OderSubmitVO.h"
#import "Jastor.h"

@interface Tool : NSObject

+ (UIAlertView *)getLoadingView:(NSString *)title andMessage:(NSString *)message;

+ (NSMutableArray *)getRelativeNews:(NSString *)request;
+ (NSString *)generateRelativeNewsString:(NSArray *)array;

+ (UIColor *)getColorForCell:(int)row;
+ (UIColor *)getColorForMain;

+ (void)clearWebViewBackground:(UIWebView *)webView;

+ (void)doSound:(id)sender;

+ (NSString *)getBBSIndex:(int)index;

+ (void)toTableViewBottom:(UITableView *)tableView isBottom:(BOOL)isBottom;

+ (void)borderView:(UIView *)view;
+ (void)roundTextView:(UIView *)txtView andBorderWidth:(float)width andCornerRadius:(float)radius;
+ (void)roundView:(UIView *)view andCornerRadius:(float)radius;

+ (void)noticeLogin:(UIView *)view andDelegate:(id)delegate andTitle:(NSString *)title;

+ (void)processLoginNotice:(UIActionSheet *)actionSheet andButtonIndex:(NSInteger)buttonIndex andNav:(UINavigationController *)nav andParent:(UIViewController *)parent;

+ (NSString *)getCommentLoginNoticeByCatalog:(int)catalog;

+ (void)playAudio:(BOOL)isAlert;

+ (NSString *)intervalSinceNow: (NSString *) theDate;

+ (BOOL)isToday:(NSString *) theDate;

+ (int)getDaysCount:(int)year andMonth:(int)month andDay:(int)day;

+ (NSString *)getAppClientString:(int)appClient;

+ (void)ReleaseWebView:(UIWebView *)webView;

+ (int)getTextViewHeight:(UITextView *)txtView andUIFont:(UIFont *)font andText:(NSString *)txt;
+ (int)getTextHeight:(int)width andUIFont:(UIFont *)font andText:(NSString *)txt;
/**
 @method 获取指定宽度情况ixa，字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param andWidth 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+ (float)heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;

+ (UIColor *)getBackgroundColor;
+ (UIColor *)getCellBackgroundColor;

+ (BOOL)isValidateEmail:(NSString *)email;

+ (void)saveCache:(int)type andID:(int)_id andString:(NSString *)str;
+ (NSString *)getCache:(int)type andID:(int)_id;

+ (void)deleteAllCache;

+ (NSString *)getHTMLString:(NSString *)html;

+ (void)showHUD:(NSString *)text andView:(UIView *)view andHUD:(MBProgressHUD *)hud;
+ (void)showCustomHUD:(NSString *)text andView:(UIView *)view andImage:(NSString *)image andAfterDelay:(int)second;

+ (UIImage *) scale:(UIImage *)sourceImg toSize:(CGSize)size;

+ (CGSize)scaleSize:(CGSize)sourceSize;

+ (NSString *)getOSVersion;

+ (void)ToastNotification:(NSString *)text andView:(UIView *)view andLoading:(BOOL)isLoading andIsBottom:(BOOL)isBottom;

+ (void)CancelRequest:(ASIFormDataRequest *)request;

+ (NSDate *)NSStringDateToNSDate:(NSString *)string;
//时间戳转指定格式时间字符串
+ (NSString *)TimestampToDateStr:(NSString *)timestamp andFormatterStr:(NSString *)formatter;

+ (NSString *)GenerateTags:(NSMutableArray *)tags;

+ (void)saveCache:(NSString *)catalog andType:(int)type andID:(int)_id andString:(NSString *)str;
+ (NSString *)getCache:(NSString *)catalog andType:(int)type andID:(int)_id;
//保留数值几位小数
+ (NSString *)notRounding:(float)price afterPoint:(int)position;

+ (BOOL)testAlipayInstall;
+ (BOOL)testWeiXinInstall;

+ (NSDictionary*)getObjectData:(id)obj;
+(NSData*)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error;
+(id)getObjectInternal:(id)obj;

//平台接口生成验签
+ (NSDictionary *)parseQueryString:(NSString *)query;
+ (NSString *)serializeURL:(NSString *)baseURL params:(NSDictionary *)params;
//平台接口生成验签Sign中文转UFT-8
+ (NSString *)serializeUFT8Sign:(NSString *)baseURL params:(NSDictionary *)params;
//平台接口生成验签Sign中文
+ (NSString *)serializeSign:(NSString *)baseURL params:(NSDictionary *)params;
+ (NSString* )databasePath;

//解析城市JSON
+ (NSMutableArray *)readJsonStrToCityArray:(NSString *)str;
//解析社区JSON（包含社区、楼栋、门牌）
+ (NSMutableArray *)readJsonStrToCommunityArray:(NSString *)str;
//解析社区JSON（楼栋、门牌）
+ (NSMutableArray *)readJsonStrToUnitArray:(NSString *)str;
//解析登陆JSON
+ (UserInfo *)readJsonStrToLoginUserInfo:(NSString *)str;
//解析社区活动JSON
+ (NSMutableArray *)readJsonStrToActivityArray:(NSString *)str;
//解析社区活动详情JSON
+ (Activity *)readJsonStrToActivityDetail:(NSString *)str;
//解析报修列表JSON
+ (NSMutableArray *)readJsonStrToRepairArray:(NSString *)str;
//解析报修详情JSON
+ (NSMutableArray *)readJsonStrToRepairItemArray:(NSString *)str;
//解析广告JSON
+ (NSMutableArray *)readJsonStrToAdinfoArray:(NSString *)str;
//解析小区通知JSON
+ (NSMutableArray *)readJsonStrToNoticeArray:(NSString *)str;
//解析投诉列表JSON
+ (NSMutableArray *)readJsonStrToSuitArray:(NSString *)str;
//解析投诉详情JSON
+ (NSMutableArray *)readJsonStrToSuitItemArray:(NSString *)str;
//解析收件列表列表JSON
+ (NSMutableArray *)readJsonStrToExpressArray:(NSString *)str;
//解析快递公司列表JSON
+ (NSMutableArray *)readJsonStrToExpressCompanyArray:(NSString *)str;
//解析商品分类JSON
+ (NSMutableArray *)readJsonStrToCommodityClassArray:(NSString *)str;
//解析商品JSON
+ (NSMutableArray *)readJsonStrToCommodityArray:(NSString *)str;
//解析单个商品详情JSON
+ (Commodity *)readJsonStrToCommodityDetail:(NSString *)str;
//解析账单列表JSON
+ (NSMutableArray *)readJsonStrToBillArray:(NSString *)str;
//解析积分列表JSON
+ (NSMutableArray *)readJsonStrToIntegralArray:(NSString *)str;
//解析周边商家JSON
+ (NSMutableArray *)readJsonStrToPeripheralShopArray:(NSString *)str;
//解析活动用户JSON
+ (NSMutableArray *)readJsonStrToActivityUsersArray:(NSString *)str;
//解析订单列表JSON
+ (NSMutableArray *)readJsonStrToOrderArray:(NSString *)str;
//解析朋友圈列表JSON
+ (NSMutableArray *)readJsonStrToFriendsArray:(NSString *)str;
//解析朋友圈详情JSON
+ (FriendsInfo *)readJsonStrToFriendsInfo:(NSString *)str;

//将订单对象转换成json
+ (NSString *)readOderSubmitVOToJson:(OderSubmitVO *)submit;

//通过对象返回一个NSDictionary，键是属性名称，值是属性值。
+ (NSDictionary*)getObjectData:(id)obj;

//将getObjectData方法返回的NSDictionary转化成JSON
+ (NSData*)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error;

//将json字符串转换成对象
+ (id) readJsonToObj:(NSString *)json andObjClass:(Class)objClass;

//将json字典转换成对象
+ (id)readJsonDicToObj:(NSDictionary *)jsonDic andObjClass:(Class)objClass;

//将json集合转换成对象集合
+ (NSArray *)readJsonToObjArray:(NSArray *)jsonArray andObjClass:(Class)objClass;
@end
