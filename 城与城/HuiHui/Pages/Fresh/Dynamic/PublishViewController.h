//
//  PublishViewController.h
//  HuiHui
//
//  Created by 冯海强 on 14-5-5.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"
#import "MHImagePickerMutilSelector.h"


@protocol Publishdelegate <NSObject>

- (void)Publishdelegate:(NSDictionary *)FOdic send:(NSString*)imageNO;//发表说说成功后返回需要刷新数据；

- (void)Publishfalseover:(NSDictionary *)FOdic;//假动作【结束】


@end


@interface PublishViewController : BaseViewController<UITextViewDelegate,MHImagePickerMutilSelectorDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    int pickerorphoto;
    
    NSString * waitimage;
}


@property (nonatomic,strong) NSMutableDictionary    *ImageDic;

// 选择图片时候用于计算view的大小
@property (nonatomic, assign) BOOL                  isChoosePhoto;


@property (unsafe_unretained,nonatomic)id<Publishdelegate>publishdele;


+(PublishViewController*)PshareobjectSEL;//保证只有一个；

@end
