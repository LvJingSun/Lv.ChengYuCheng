//
//  WwebViewController.h
//  baozhifu
//
//  Created by 冯海强 on 14-2-21.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "ImageCache.h"
#import "UIImageView+AFNetworking.h"
#import "DowncellViewController.h"

@interface WwebViewController : BaseViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate,ChosesDelegate>
{
    int pickerorphoto;
    
    NSString *chosemerchantId;
    
    NSString *code;//状态是新增还是编辑；
    
    NSString *wxsiteID;//微网站ID；
    
    NSString * Imagepath;//图片地址，用户分享

}

@property (weak, nonatomic) IBOutlet UIScrollView *m_WwebView;

@property (nonatomic,strong) NSMutableDictionary * imagedic;

@property(nonatomic,strong)ImageCache*imageCache;

@end
