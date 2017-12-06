//
//  HH_EditTopicViewController.h
//  HuiHui
//
//  Created by mac on 14-10-28.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//  修改主题的控制器

#import "BaseViewController.h"

@protocol EditTopicDelegate <NSObject>

- (void)editPartyTopicAndDetail:(NSString *)aString withType:(NSString *)aType;

@end

@interface HH_EditTopicViewController : BaseViewController<UITextFieldDelegate,UITextViewDelegate>

//记录来自于哪个页面的值
@property (nonatomic, strong) NSString              *m_stringType;

@property (nonatomic, assign) id<EditTopicDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView         *m_topicView;

@property (weak, nonatomic) IBOutlet UIView         *m_detailView;

@property (weak, nonatomic) IBOutlet UITextView     *m_textView;

@property (weak, nonatomic) IBOutlet UITextField    *m_textField;
// 存放textField的值
@property (nonatomic, strong) NSString              *m_FieldString;
// 存放textView的值
@property (nonatomic, strong) NSString              *m_ViewString;


@end
