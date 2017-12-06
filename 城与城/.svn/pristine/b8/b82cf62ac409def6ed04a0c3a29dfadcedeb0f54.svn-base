#import "App_addtion.h"
#import <QuartzCore/QuartzCore.h>
@implementation NSObject (App)
-(void) alert:(NSString *) msg{
    if ([NSThread isMainThread]) {
        [self alert:@"提示" msg:msg];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self alert:@"提示" msg:msg];
        });

    }
}

-(void) alert:(NSString *) title msg:(NSString *) msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}


-(void) alert:(NSString *) title msg:(NSString *) msg delegate:(id) delegate cancelText:(NSString *) cancelText otherText:(NSString *)otherText{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:delegate
                                              cancelButtonTitle:cancelText
                                              otherButtonTitles:otherText,nil];
        [alert show];
        [alert release];
    });
}
@end

@implementation UIView (App)
-(void) removeAllSub{
    for (UIView *each in self.subviews) {
        [each removeFromSuperview];
    }
}
-(void) hideWithAnimation{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }];
}

-(UITableViewCell *) getParentCell{
    UIView *someView = self;
    while (someView.superview) {
        someView = someView.superview;
        if ([someView isKindOfClass:[UITableViewCell class]]) {
            return (UITableViewCell *)someView;
        }
    }
    return nil;
}
@end

@implementation NSString (App)
-(BOOL) contain:(NSString *) text{
    return [self rangeOfString:text].location != NSNotFound;
}
-(BOOL) isEmail{
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL) isMobileNumber{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES)){
        return YES;
    } else {
        return NO;
    }
}
@end

@implementation UIImageView (App)

-(void) setImage:(UIImage *)image animate:(BOOL) animate{
    self.image = image;
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    
    [self.layer addAnimation:transition forKey:nil];

}
@end

@implementation UITableView (App)
-(void) addEmptyFooter{
    UIView *empty = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableFooterView = empty;
    [empty release];
}

-(void)registerCell2:(NSArray *)nibFileNames{
    for (NSString *each in nibFileNames) {
        UINib *nib = [UINib nibWithNibName:each bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:each];
    }
}
@end

@implementation NSArray (App)
-(NSString *) joinWith:(NSString *) v withKey:(NSString *) key{
    int count = self.count;
    if (0 == count) {
        return @"";
    }
    NSString *firstValue = @"";
    {
        if (nil == key) {
            firstValue = [self objectAtIndex:0];
        }else{
            firstValue = [self objectAtIndex:0][key];
        }
    }
    if (1 == count) {
        return firstValue;
    }
    NSMutableString *result = [[NSMutableString alloc] initWithString:firstValue];
    for (int i=1; i<count; i++) {
        NSString *eachValue = @"";
        if (nil == key) {
            eachValue =  [self objectAtIndex:i];
        }else{
            eachValue = [self objectAtIndex:i][key];
        }
        [result appendFormat:@"%@%@",v, eachValue];
    }
    
    [result autorelease];
    return result;
    
}
-(NSString *) country_name{
    return self[0];
}
-(NSString *) country_nameSort{
    return self[1];
}
-(int) country_code{
    return [self[2] intValue];
}
@end

@implementation UIButton (App)

-(void) setImage:(BOOL) status y:(NSString *)y n:(NSString *) n{
    if (status) {
        [self setImage:y];
    }else{
        [self setImage:n];
    }
}
-(void) setImage:(NSString *) imageName{
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}
-(void) setBgImage:(NSString *) imageName{
    [self setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}
-(void) setSelector:(SEL) selector{
    [self addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
}
-(void) setTitle:(NSString *) title{
    [self setTitle:title forState:UIControlStateNormal];
}
@end


@implementation UIColor (HexString)

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
@end

@implementation DDXMLElement (App)

- (NSString *) valueInSub:(NSString *) key{
    NSArray *values = [self elementsForName:key];
    if (values.count > 0) {
        DDXMLElement *first = values[0];
        return [first stringValue];
    }
    return @"";
}

- (DDXMLElement *) firstInSub:(NSString *) key{
    NSArray *values = [self elementsForName:key];
    if (values.count > 0) {
        return values[0];
    }
    return nil;
}
@end

