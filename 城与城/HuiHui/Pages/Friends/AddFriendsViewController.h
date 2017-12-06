//
//  AddFriendsViewController.h
//  HuiHui
//
//  Created by mac on 13-11-21.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface AddFriendsViewController : BaseViewController<UIActionSheetDelegate, ABPeoplePickerNavigationControllerDelegate,UITextFieldDelegate>


@property (nonatomic, strong) NSDictionary  *m_dic;

@end
