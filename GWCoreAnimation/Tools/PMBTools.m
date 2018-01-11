//
//  PMBTools.m
//  Pangmaobao
//
//  Created by 杨根威 on 2017/10/26.
//  Copyright © 2017年 Shanghai Birkin Network Technology Co. All rights reserved.
//

#import "PMBTools.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation PMBTools

#pragma mark 将颜色转换成图片
+(UIImage *)convertUIColorToUIImage:(UIColor *)color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark 将图片转换成颜色
+ (UIColor *)convertUIImageToUIColor:(NSString *)pngName{
        return [UIColor colorWithPatternImage:[UIImage imageNamed:pngName]];
}

#pragma mark 将视图转换成图片
+(UIImage *)convertViewToImage:(UIView *)view{
    CGSize s = view.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark 十六进制颜色值转换成UIColor
+ (UIColor *)colorWithHexString: (NSString *)color{
    
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


#pragma mark 过滤空值
+ (NSString *)convertNullOrNil:(NSString *)str{
    
    if (str != nil || str != NULL || str.length > 0) {
        return str;
    }
    else  if ([str isEqual:[NSNull class]]) {
        return @"";
    }
    else{
        return @"";
    }
}


#pragma mark 将十六进制颜色值转换成图片

+(UIImage *)drawcolorInImage:(NSString *)colorName{
    CGRect rect = CGRectMake(0, 0, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context,
                                   [[self colorWithHexString:colorName] CGColor]);
    //  [[UIColor colorWithRed:222./255 green:227./255 blue: 229./255 alpha:1] CGColor]) ;
    CGContextFillRect(context, rect);
    UIImage * imge;// = [[UIImage alloc] init];
    imge = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imge;
    
}


#pragma mark 获取本地资源的图片
+(UIImage *)getBuddleImage:(NSString *)imageStr imageType:(NSString *)type{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageStr ofType:type];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
    
    return image;
}

#pragma mark 快速拨打电话
+ (void) makeCall:(NSString *)phoneNumber showView:(UIView *)showView{
    NSString* number = [NSString stringWithString:phoneNumber];
    NSString* numberAfterClear = [[[[number stringByReplacingOccurrencesOfString:@" " withString:@""]
                           //                        stringByReplacingOccurrencesOfString:@"-" withString:@""]
                           stringByReplacingOccurrencesOfString:@"(" withString:@""]
                          stringByReplacingOccurrencesOfString:@")" withString:@""] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", numberAfterClear]];
    //    //NSLog(@"make call, URL=%@", phoneNumberURL);
    
    UIWebView*callWebview =[[UIWebView alloc] init];
    
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [showView addSubview:callWebview];
    
}

#pragma mark 获取设配型号
+ (NSString *)getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone6";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone6Plus";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone6sPlus";
    if ([platform isEqualToString:@"iPhone8,3"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone7Plus";
    
    //iPod Touch
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPodTouch";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPodTouch2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPodTouch3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPodTouch4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPodTouch5G";
    if ([platform isEqualToString:@"iPod7,1"])   return @"iPodTouch6G";
    
    //iPad
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad4";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad4";
    
    //iPad Air
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad5,3"])   return @"iPadAir2";
    if ([platform isEqualToString:@"iPad5,4"])   return @"iPadAir2";
    
    //iPad mini
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,7"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,8"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,9"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad5,1"])   return @"iPadmini4";
    if ([platform isEqualToString:@"iPad5,2"])   return @"iPadmini4";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhoneSimulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhoneSimulator";
    return platform;
}

#pragma mark 判断非法字符
+ (BOOL)JudgeTheillegalCharacter:(NSString *)content canonical:(NSString *)canonical{
    //    ^[A-Za-z0-9\\u4e00-\u9fa5]+$     //只允许中文,数字,字母
    //    ^[A-Za-z0-9]+$                   //只允许数字,字母
    //    ^[1-9]\d*\.\d*|0\.\d*[1-9]\d*$   //匹配正浮点数
    //    [\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?                    //匹配是否是邮箱
    //    ^([1-9]\d{0,7}|0)([.]?|(\.\d{1,2})?)$ 匹配金额
    //提示 标签不能输入特殊字符
    NSString *str = canonical;
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if ([emailTest evaluateWithObject:content]) {
        return YES;
    }
    return NO;
}

//+ (CGFloat)heightForString:(NSString *)str fontSize:(float)fontSize andWidth:(float)width

#pragma mark  获取指定宽度情况ixa，字符串value的高度
+ (CGFloat) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize titleSize = [value boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                         options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
//    //根据label文字获取CGRect
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
//    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//
//    NSDictionary *attrDict =@{NSFontAttributeName:kFont(fontSize),
//                              NSParagraphStyleAttributeName:paragraphStyle};
//
//
//    CGRect lblRect = [value boundingRectWithSize:(CGSize){width, MAXFLOAT}
//                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
//                                      attributes:attrDict
//                                         context:nil];
    return titleSize.height;
}

#pragma mark 检查密码输入框 验证
+ (NSString *)checkPassWorkTextField:(NSString *)password{
    
    NSString *pwRegex1 = @"^[a-zA-Z0-9]{8,16}$";
    NSString *perrorMsg;
    NSPredicate *passwordlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pwRegex1];
    if ([passwordlTest evaluateWithObject:password] == NO) {
        perrorMsg = @"密码由数字和字母组成,长度8-16位";
        return perrorMsg;
    }
    
    NSString* pwRegex2 = @"^[a-zA-Z]{8,16}$";
    NSPredicate *pwTest2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pwRegex2];
    if ([pwTest2 evaluateWithObject:password]) {
        perrorMsg = @"密码必须包含至少一个数字";
        return perrorMsg;
    }
    
    NSString* pwRegex3 = @"^[0-9]{8,16}$";
    NSPredicate *pwTest3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pwRegex3];
    if ([pwTest3 evaluateWithObject:password]) {
        perrorMsg = @"密码必须至少包含一个字母";
        return perrorMsg;
    }
    
    NSString* pwRegex4 = @"([a-zA-Z0-9])\1{8}";
    NSPredicate *pwTest4 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pwRegex4];
    if ([pwTest4 evaluateWithObject:password.uppercaseString]) {
        perrorMsg = @"同一数字或字母不能出现连续8次重复；如：11111111";
        return perrorMsg;
    }
    
    NSString* pwRegex5 = @"([a-zA-Z0-9])\1{8}";
    NSPredicate *pwTest5 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pwRegex5];
    if ([pwTest5 evaluateWithObject:password.uppercaseString]) {
        perrorMsg = @"同一数字或字母不能出现连续8次重复；如：11111111";
        return perrorMsg;
    }
    return @"1";
}

#pragma mark - 正则判断是否符合金额规则
+ (BOOL)isAmountStyle:(NSString *)amount{
    NSString *regex = @"^([1-9]\\d{0,7}|0)([.]?|(\\.\\d{1,2})?)$";
    NSPredicate *predicte = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicte evaluateWithObject:amount];
}

+ (NSString *)getAppVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)formatterWithMoney:(NSString *)money{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    formatter.roundingMode = NSNumberFormatterRoundFloor;
    [formatter setMaximumFractionDigits:2];
    [formatter setMinimumFractionDigits:2];
    NSString *newMoney = [formatter stringFromNumber:[NSNumber numberWithDouble:[money doubleValue]]];
    return newMoney;
}

@end
