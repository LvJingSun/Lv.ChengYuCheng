//
//  XMPPManager.h
//  ChattingDemo
//
//  Created by mac on 14-4-15.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XMPPFramework.h"

#import <QuartzCore/QuartzCore.h>

#import <AVFoundation/AVFoundation.h>

#import "MeetViewController.h"

#import "ChatGroup.h"

#define kUSER_ID @"userId"
#define kUSER_NICKNAME @"nickName"
#define kUSER_DESCRIPTION @"description"
#define kUSER_USERHEAD @"userHead"
#define kUSER_FRIEND_FLAG @"friendFlag"

@class XMPPMessage,XMPPRoster,XMPPRosterCoreDataStorage;

@interface XMPPManager : NSObject<UIApplicationDelegate>{
    
    XMPPStream                  *xmppStream;
	XMPPReconnect               *xmppReconnect;
    XMPPRoster                  *xmppRoster;
    XMPPRosterCoreDataStorage   *xmppRosterStorage;
    
   	NSString                    *password;
	
	BOOL                        allowSelfSignedCertificates;
	BOOL                        allowSSLHostNameMismatch;
	
	BOOL                        isXmppConnected;

    SystemSoundID               beepSound;
    NSURL                       *soundToPlay;
    
    
    NSMutableDictionary       *fileSis;
    NSMutableArray            *fileTranfers;
    NSMutableDictionary       *resouces;
    NSMutableSet              *needHandlKeys;
    NSMutableDictionary       *handleResult;


}

@property (readonly, nonatomic) NSManagedObjectContext          *managedObjectContext;
@property (readonly, nonatomic) NSManagedObjectModel            *managedObjectModel;
@property (readonly, nonatomic) NSPersistentStoreCoordinator    *persistentStoreCoordinator;

@property (readonly, nonatomic) XMPPStream                      *xmppStream;


@property (nonatomic, strong)   NSURL                           *soundToPlay;

@property (readonly, nonatomic) BOOL                            isXmppConnected;
@property (nonatomic, strong)   NSMutableSet                    *needHandlKeys;



- (NSManagedObjectContext *)managedObjectContext_roster;

//- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (BOOL)connect;
- (void)disconnect;


+ (XMPPManager *)sharedInstance;


#pragma mark -------配置XML流-----------

- (void)setupStream;
- (void)teardownStream;


#pragma mark ----------收发信息------------
- (void)goOnline;
- (void)goOffline;

- (void)sendMessage:(XMPPMessage *)aMessage;

// test groupChat
- (void)sendGroupMessage:(XMPPMessage *)aMessage withGroup:(ChatGroup *)group;

//- (void)sendMessage:(XMPPMessage *)aMessage withMessage:(XMPPMessage *)aChat;


- (void)addSomeBody:(NSString *)userId;


#pragma mark ---------文件传输-----------
//-(void)sendFile:(NSData*)aData toJID:(XMPPJID*)aJID;

#pragma mark - NetWork - 根据memberId来获得昵称和头像
- (void)MemberRequestSubmit:(XMPPMessage *)message;



@end
