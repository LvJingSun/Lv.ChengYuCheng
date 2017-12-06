//
//  MultiUserChatViewCtl.h
//  BaseProject
//
//  Created by Huan Cho on 13-8-3.
//  Copyright (c) 2013年 ch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@protocol XMPPRoomDelegate;

//@protocol XMPPMUCDelegate;

@interface MultiUserChatViewCtl : BaseViewController<UITableViewDelegate, UITableViewDataSource,XMPPRoomDelegate,XMPPMUCDelegate>

@property(nonatomic, retain) NSString *roomName;                    //房间名称

@property (retain, nonatomic) IBOutlet UITableView *tView;          
@property (retain, nonatomic) IBOutlet UITextField *messageTextField;
@property (retain, nonatomic) IBOutlet UILabel *roomNameLabel;

- (IBAction)sendButton:(id)sender;

@end
