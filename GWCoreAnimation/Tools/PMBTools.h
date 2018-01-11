//
//  PMBTools.h
//  Pangmaobao
//
//  Created by 杨根威 on 2017/10/26.
//  Copyright © 2017年 Shanghai Birkin Network Technology Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PMBTools : NSObject

/**
 将UIColor转换成UIImage

 @param color UIColor
 @return 转换后的UIImage
 */
+ (UIImage*)convertUIColorToUIImage:(UIColor*) color;


/**
 将UIImage转换成UIColor

 @param pngName 图片名称
 @return 转换后的UIColor
 */
+ (UIColor *)convertUIImageToUIColor:(NSString *)pngName;


/**
 将视图转换成图片

 @param view 视图
 @return 转换后的Image
 */
+ (UIImage*)convertViewToImage:(UIView*)view;


/**
 十六进制颜色值转换成UIColor

 @param color 十六进制颜色值
 @return 转换后的UIColor
 */
+ (UIColor *) colorWithHexString: (NSString *)color;


/**
 过滤空值

 @param str 字符串
 @return 过滤后的字符串
 */
+ (NSString *)convertNullOrNil:(NSString *)str;


/**
 将十六进制颜色值转换成图片

 @param colorName 十六进制颜色值
 @return 转换后的图片
 */
+(UIImage *)drawcolorInImage:(NSString *)colorName;


/**
 获取本地资源的图片

 @param imageStr 图片名称
 @param type 图片类型
 @return 图片对象
 */
+(UIImage *)getBuddleImage:(NSString *)imageStr imageType:(NSString *)type;


/**
 快速拨打电话

 @param phoneNumber 电话号码
 @param showView 载体
 */
+ (void) makeCall:(NSString *)phoneNumber showView:(UIView *)showView;


/**
 获取设备型号

 @return <#return value description#>
 */
+ (NSString *)getCurrentDeviceModel;


/**
 根据提供的正则进行判断,之后返回相应的结果

 @param content <#content description#>
 @param canonical <#canonical description#>
 @return <#return value description#>
 */
+ (BOOL)JudgeTheillegalCharacter:(NSString *)content canonical:(NSString *)canonical;

/**
 @method 获取指定宽度情况ixa，字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+ (CGFloat)heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;


/**
 检查密码

 @param password 密码
 @return <#return value description#>
 */
+ (NSString *)checkPassWorkTextField:(NSString *)password;


/**
 正则判断是否符合金额规则

 @param amount 金额
 @return <#return value description#>
 */
+ (BOOL)isAmountStyle:(NSString *)amount;

//获取APP版本
+ (NSString *)getAppVersion;

+ (NSString *)formatterWithMoney:(NSString *)money;

@end
