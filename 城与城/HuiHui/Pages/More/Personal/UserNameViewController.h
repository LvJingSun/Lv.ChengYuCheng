//
//  UserNameViewController.h
//  HuiHui
//
//  Created by mac on 13-11-20.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

@protocol UserInformationDelegate <NSObject>

- (void)getUserName:(NSString *)aName;

@end

@interface UserNameViewController : BaseViewController<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *m_nameTextField;

@property (nonatomic, assign) id<UserInformationDelegate>delegate;


@end
