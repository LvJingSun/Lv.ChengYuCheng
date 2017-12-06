//
//  SynchronousadressViewController.m
//  HuiHui
//
//  Created by 冯海强 on 15-3-20.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "SynchronousadressViewController.h"

@interface SynchronousadressViewController ()

@end

@implementation SynchronousadressViewController
@synthesize PhoneContactsVC;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"备份通讯录";
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

}

- (void)leftClicked{
    
    [self goBack];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)UploadAdressRequest:(id)sender{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    [self showHudInView:self.view hint:@"正在备份..."];
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *adic = [PhoneContactsVC GetALLpersonsattribute];
    
    NSString *jsonstring = [self jsonStringWithObject:adic];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           jsonstring,@"contents",
                           @"",@"remark",
                           @"APP-iOS",@"resouce",
                           nil];
    [httpClient request:@"AddressBookUp.ashx" parameters:param success:^(NSJSONSerialization* json) {
        [self hideHud];
        BOOL success = [[json valueForKey:@"status"] boolValue];
        NSString *msg = [json valueForKey:@"msg"];
        if (success) {
            [SVProgressHUD showSuccessWithStatus:msg];
        } else {
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        [self hideHud];
        [SVProgressHUD showErrorWithStatus:@"备份失败，稍后再试"];
    }];
}

- (IBAction)DownloadAdressRequest:(id)sender{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    [self showHudInView:self.view hint:@"正在下载..."];
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           @"APP-iOS",@"resouce",
                           nil];
    [httpClient request:@"AddressBookDown.ashx" parameters:param success:^(NSJSONSerialization* json) {
        [self hideHud];
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *jsons = [json valueForKey:@"msg"];
            
            NSDictionary *ddic = [self dictionaryWithJsonString:jsons];
            
            NSArray * array = [ddic objectForKey:@"ABAddressARR"];
            
            [self DownSavepersons:array];
            
        } else {
            [SVProgressHUD showErrorWithStatus:[json valueForKey:@"msg"]];
        }
    } failure:^(NSError *error) {
        [self hideHud];
        [SVProgressHUD showErrorWithStatus:@"下载失败，稍后再试"];
    }];
}


//检测转换
-(NSString *) jsonStringWithObject:(id) object{
    NSString *value = nil;
    if (!object) {
        return value;
    }
    if ([object isKindOfClass:[NSString class]]) {
        value = [self jsonStringWithString:object];
    }else if([object isKindOfClass:[NSDictionary class]]){
        value = [self jsonStringWithDictionary:object];
    }else if([object isKindOfClass:[NSArray class]]){
        value = [self jsonStringWithArray:object];
    }
    return value;
}

-(NSString *) jsonStringWithString:(NSString *) string{
    return [NSString stringWithFormat:@"\"%@\"",
            [[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""]
            ];
}

-(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary{
    NSArray *keys = [dictionary allKeys];
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"{"];
    NSMutableArray *keyValues = [NSMutableArray array];
    for (int i=0; i<[keys count]; i++) {
        NSString *name = [keys objectAtIndex:i];
        id valueObj = [dictionary objectForKey:name];
        NSString *value = [self jsonStringWithObject:valueObj];
        if (value) {
            [keyValues addObject:[NSString stringWithFormat:@"\"%@\":%@",name,value]];
        }
    }
    [reString appendFormat:@"%@",[keyValues componentsJoinedByString:@","]];
    [reString appendString:@"}"];
    return reString;
}

-(NSString *) jsonStringWithArray:(NSArray *)array{
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"["];
    NSMutableArray *values = [NSMutableArray array];
    for (id valueObj in array) {
        NSString *value = [self jsonStringWithObject:valueObj];
        if (value) {
            [values addObject:[NSString stringWithFormat:@"%@",value]];
        }
    }
    [reString appendFormat:@"%@",[values componentsJoinedByString:@","]];
    [reString appendString:@"]"];
    return reString;
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}



//下载完成之后（根据persoID判断本地是否存在，存在：（根据 最后修改时间 判断是否需要编辑），不存在：（新增））

-(void)DownSavepersons:(NSArray *)ALLperson
{
    //    6、通讯录列表获取差异
    ABAddressBookRef addressBook = nil;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
    {
        addressBook=ABAddressBookCreateWithOptions(NULL, NULL);
        dispatch_semaphore_t sema=dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool greanted, CFErrorRef error){
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    } else
    {
        addressBook = ABAddressBookCreate();
    }
    
    for (int iii = 0; iii<ALLperson.count; iii ++) {
        ABRecordID personId = (ABRecordID)[[NSString stringWithFormat:@"%@",[[ALLperson objectAtIndex:iii] objectForKey:@"PersonId"]]integerValue];
        ABRecordRef personRecord = ABAddressBookGetPersonWithRecordID(addressBook, personId);
        if (personRecord) {
            NSString *lastknow = (__bridge NSString*)ABRecordCopyValue(personRecord, kABPersonModificationDateProperty);
            if (lastknow == nil) {
                lastknow = @"";
            }
            if (![[NSString stringWithFormat:@"%@",lastknow] isEqualToString:[[ALLperson objectAtIndex:iii] objectForKey:@"lastknow"]]) {
                // 设置公司名属性
                ABRecordSetValue(personRecord, kABPersonOrganizationProperty, (__bridge CFStringRef)[[ALLperson objectAtIndex:iii] objectForKey:@"Perorganization"], NULL);
                // 设置firstName属性
                ABRecordSetValue(personRecord, kABPersonFirstNameProperty, (__bridge CFStringRef)[[ALLperson objectAtIndex:iii] objectForKey:@"PerFirstName"], NULL);
                // 设置lastName属性
                ABRecordSetValue(personRecord, kABPersonLastNameProperty, (__bridge CFStringRef) [[ALLperson objectAtIndex:iii] objectForKey:@"PerLastName"], NULL);
                ABMultiValueRef mv = ABMultiValueCreateMutable(kABMultiStringPropertyType);
                for (int jjj =0 ; jjj <[[[ALLperson objectAtIndex:iii] objectForKey:@"ABGetPhones"]count]; jjj++) {
                    ABMultiValueIdentifier mi = ABMultiValueAddValueAndLabel(mv, (__bridge CFStringRef)[[[[ALLperson objectAtIndex:iii] objectForKey:@"ABGetPhones"]objectAtIndex:jjj] objectForKey:@"Phone"], (__bridge CFStringRef)[[[[ALLperson objectAtIndex:iii] objectForKey:@"ABGetPhones"]objectAtIndex:jjj] objectForKey:@"PhoneLabel"], &mi);
                }
                // 设置phone属性
                ABRecordSetValue(personRecord, kABPersonPhoneProperty, mv, NULL);
                // 释放该数组
                if (mv) {
                    CFRelease(mv);
                }
            }
            // 将新建的联系人添加到通讯录中
            ABAddressBookAddRecord(addressBook, personRecord, NULL);
            // 保存通讯录数据
            ABAddressBookSave(addressBook, NULL);
            
        }
        
    }
    
    // 释放通讯录对象的引用
    if (addressBook) {
        CFRelease(addressBook);
    }
    [SVProgressHUD showSuccessWithStatus:@"下载成功"];
    
    [PhoneContactsVC GetABAddressBookRef];
    
}

@end
