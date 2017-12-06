//
//  CommonUtil.m
//  bazhifuApp
//
//  Created by mac on 13-6-8.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "CommonUtil.h"
#import "DateUtil.h"
#import "MD5.h"

static NSString* const PUBLIC_KEY = @"www.Maxlinks.cn20130601";

@implementation CommonUtil

+ (NSString *) getServerKey {
    NSString *account = [CommonUtil getValueByKey:ACCOUNT];
    NSString *mid = [CommonUtil getValueByKey:MEMBER_ID];
    NSTimeInterval diffTime = [[CommonUtil getValueByKey:SERVER_TIME_DIFF] doubleValue];
    NSDate *serverDate = [NSDate dateWithTimeIntervalSinceNow:diffTime];
    NSString *serverDateStr = [DateUtil formatDate:serverDate dateFormat:DATE_FORMAT_M];
    NSString *key = [NSString stringWithFormat:@"%@%@%@%@", account, PUBLIC_KEY, mid, serverDateStr];
    key = [key substringToIndex:(key.length- 1)];
    NSString *md5 = [MD5 md5Digest:key];
    //NSLog(@"key=%@, md5=%@", key, md5);
    return md5;
}

+ (NSString *) getDocumentPath:(NSString *)fileName {
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [rootPath stringByAppendingPathComponent:fileName];
    return filePath;
}

+ (id) getValueByKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults) {
        
        return [defaults valueForKey:key];
    }
    return nil;
}

+ (void) addValue:(id)object andKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults) {
        [defaults setObject:object forKey:key];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

static NSDictionary *_transactionTypeDict;

+ (NSDictionary *) transactionTypeDict {
    if (_transactionTypeDict == nil) {
        _transactionTypeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"消费", @"Consumption",
                                @"优惠", @"Preferentia",
                                @"交易担保金", @"SecurityDeposit",
                                @"商户返利", @"MerchantRebates",
                                @"平台奖励", @"Reward",
                                @"充值", @"Recharge",
                                @"提现", @"Withdrawal",
                                @"商户推荐奖励", @"MctRefRewards",
                                nil];
    }
    return _transactionTypeDict;
}

static NSDictionary *_operationsDict;

+ (NSDictionary *) operationsDict {
    if (_operationsDict == nil) {
        _operationsDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"收入", @"Income",
                                @"支出", @"Expenditure",
                                nil];
    }
    return _operationsDict;
}

static NSDictionary *_statusDict;

+ (NSDictionary *) statusDict {
    if (_statusDict == nil) {
        _statusDict = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"已完成", @"HasCompleted",
                           @"处理中", @"WAProcessing",
                           nil];
    }
    return _statusDict;
}

static NSDictionary *_keyStatusDict;

+ (NSDictionary *) keyStatusDict {
    if (_keyStatusDict == nil) {
        _keyStatusDict = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"未使用", @"0",
                          @"已使用", @"1",
                          @"已退款", @"2",
                          @"已过期", @"3",
                          nil];
    }
    return _keyStatusDict;
}

static NSDictionary *_bankcardDict;

+ (NSDictionary *) bankcardStatusDict {
    if (_bankcardDict == nil) {
        _bankcardDict = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"付款成功", @"PaySucc",
                          @"验证成功", @"VerificationSucc",
                          @"验证失败", @"Fail",
                          @"锁定", @"Locked",
                          nil];
    }
    return _bankcardDict;
}

+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((hexValue >> 16) & 0x000000FF)/255.0f
                           green:((hexValue >> 8) & 0x000000FF)/255.0f
                            blue:((hexValue) & 0x000000FF)/255.0
                           alpha:alpha];
}

+ (UIColor *)selectBackgroundColor {
    return [CommonUtil colorWithHexValue:0x333333 alpha:1];
}

+ (UIColor *)selectTabBarTitleColor {
    return [CommonUtil colorWithHexValue:0x0088ce alpha:1];
}

+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)reSize {
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

@end
