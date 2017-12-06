//
//  MorecommentViewController.h
//  HuiHui
//
//  Created by 冯海强 on 14-5-8.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

#import "DynamicCell.h"

#import "UIImageView+AFNetworking.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "ImageCache.h"


@interface MorecommentViewController : BaseViewController<UIActionSheetDelegate,UITextFieldDelegate>
{
    int  indexpath ;
    
    ImageCache *imagechage;
    
    NSString * toMemberID;

}

@property (nonatomic, strong) NSString              *m_typeString;

@property (nonatomic, strong) NSMutableDictionary   *m_MoreDIC;//更多评论的动态

@property (nonatomic, strong) NSMutableArray        *m_imageArray;

@property (nonatomic, strong) NSMutableArray        *m_praiseArray;//赞的人

@property (nonatomic, strong) NSMutableArray        *m_commentArray;//评论

@property (nonatomic, assign) int                   m_index;



@end
