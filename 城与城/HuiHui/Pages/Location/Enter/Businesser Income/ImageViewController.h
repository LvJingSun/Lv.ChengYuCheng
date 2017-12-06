//
//  ImageViewController.h
//  Receive
//
//  Created by 冯海强 on 14-1-2.
//  Copyright (c) 2014年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "UIImageView+AFNetworking.h"


@interface ImageViewController : BaseViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
int pickerorphoto;
int whichBtn;//哪一个图片btn；
}

@property (weak, nonatomic) IBOutlet UIScrollView *m_ImageView;

@property (nonatomic,strong) NSMutableDictionary * ALLdic;
@property (nonatomic,strong) NSMutableDictionary * imagedic;

@property (nonatomic,strong) NSString * memberBankCardID;



@end
