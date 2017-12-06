//
//  XMPPManager.m
//  ChattingDemo
//
//  Created by mac on 14-4-15.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "XMPPManager.h"
#import "GCDAsyncSocket.h"
#import "XMPP.h"
#import "XMPPReconnect.h"
#import "XMPPCapabilities.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "XMPPRoster.h"
#import "XMPPMessage.h"
#import "TURNSocket.h"
#import "MessageObject.h"
#import "Userobject.h"
#import "NSObject+SBJson.h"
#import "Configuration.h"
#import "AppDelegate.h"
#import "CommonUtil.h"
#import "AppHttpClient.h"
#import "NSData+Base64.h"
#import "NSDate+BBExtensions.h"
#import "GTMBase64.h"
#import "App_addtion.h"
#import "XMPP_service.h"
#import "GroupObject.h"
#import "GroupChatObject.h"
#import "MessageAndUserObject.h"
#import "SI.h"


#if DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_INFO;
#endif




#define DOCUMENT_PATH NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]
#define CACHES_PATH NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]

@implementation XMPPManager

@synthesize soundToPlay;

@synthesize isXmppConnected;

@synthesize xmppStream;

@synthesize needHandlKeys;

static XMPPManager *sharedManager;

+ (XMPPManager *)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager=[[XMPPManager alloc]init];
        [DDLog addLogger:[DDTTYLogger sharedInstance]];

  
        [sharedManager setupStream];
  
    });
    
    // Setup the XMPP stream
    

    
    
    return sharedManager;
}

- (void)dealloc
{
//    [super dealloc];
	[self teardownStream];
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


- (void)sendGroupMessage:(XMPPMessage *)aMessage withGroup:(ChatGroup *)group
{
    // 保存用户收到信息的userId
    //    [self saveUserIdString];
    [xmppStream sendElement:aMessage];
    
    
  
//    NSString *body = [[aMessage elementForName:@"body"] stringValue];
//    
//    // NSString *meesageStyle=[[aMessage attributeForName:@"type"] stringValue];
//    NSString *meesageTo = [[aMessage to]bare];
//    NSArray *strs = [meesageTo componentsSeparatedByString:@"@"];
//    
//    //创建message对象
//    GroupChatObject *msg = [[GroupChatObject alloc]init];
//    [msg setMessageDate:[NSDate date]];
//    [msg setMessageFrom:[[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID]];
//    
//    [msg setMessageTo:strs[0]];
//    
//    NSLog(@"strs[0] = %@",strs[0]);
//    
//    
//    //判断多媒体消息
//    NSDictionary *messageDic = [body JSONValue];
//    
//    [msg setMessageType:[NSNumber numberWithInt:[[messageDic objectForKey:@"messageType"] intValue]]];
// 
//    // 判断是发送的语音还是文本还是图片
////    if ( [[messageDic objectForKey:@"messageType"] intValue] == kWCMessageTypeVoice ) {
////        // 语音的情况下，将文本转换成wav文件路径存储
////        NSData *voiceData = [NSData dataFromBase64String:[messageDic objectForKey:@"text"]];
////        
////        // 将语音保存为以时间
////        long long timeMills = [NSDate currentTimeMillis];
////        
////        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
////        NSString *documentPath = [paths objectAtIndex:0];
////        
////        NSString *saveVoiceFilePath = [NSString stringWithFormat:@"%@/%@_%lld_send.wav",documentPath,[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_ID],timeMills];
////        
////        [voiceData writeToFile:saveVoiceFilePath atomically:YES];
////        
////        // 保存语音的保存路径
////        [msg setMessageContent:saveVoiceFilePath];
////        
////        // 保存语音的文本形式用于下面的判断
////        [CommonUtil addValue:[messageDic objectForKey:@"text"] andKey:@"VoiceFileKey"];
////        
////        
////        
////    }else if ( [[messageDic objectForKey:@"messageType"] intValue] == kWCMessageTypePlain ){
//    
//        // 不是语音的情况下直接存储文本
//        //        [msg setMessageContent:[messageDic objectForKey:@"text"]];
//        [msg setMessageContent:[GTMBase64 stringByBase64String:[messageDic objectForKey:@"text"]]];
//        
////    }
////    else
////    {
////        [msg setMessageContent:[messageDic objectForKey:@"text"]];
////        
////    }
//    
//    
//    [msg setIsRead:@"0"];
//    
////    NSString *otherId = [CommonUtil getValueByKey:OTHERMEMBERID];
//    
////    NSLog(@"%@,%@,%@",otherId,[CommonUtil getValueByKey:OTHERHEADERIMAGE],[CommonUtil getValueByKey:OTHERUSERNAME]);
//    
//    // 判断数据库里面是否已经存在
//    if ( ![GroupObject haveSaveUserById:strs[0] withFriendId:[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_ID]]) {
//        
//        // 保存
////        NSString *messageFrom = [CommonUtil getValueByKey:kFromMessage];
//        
////        NSLog(@"messageFrom = %@,kFriendFlag = %@",messageFrom,[CommonUtil getValueByKey:kFriendFlag]);
//        
////        if ( [messageFrom isEqualToString:@"1"] ) {
//        
////            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_ID],kUSER_FRIENDID,otherId,kUSER_ID,[CommonUtil getValueByKey:OTHERUSERNAME],kUSER_NICKNAME,[messageDic objectForKey:@"text"],kUSER_DESCRIPTION,[CommonUtil getValueByKey:OTHERHEADERIMAGE],kUSER_USERHEAD,[NSNumber numberWithInt:[[CommonUtil getValueByKey:kFriendFlag] intValue]],kUSER_FRIEND_FLAG, nil];
////            
////            Userobject *user = [Userobject userFromDictionary:dic];
////            [Userobject saveNewUser:user];
//        
////        }else{
//        
//        NSLog(@"text = %@",[messageDic objectForKey:@"text"]);
//        
//            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_ID],kUSER_FRIENDID,strs[0],kUSER_ID,[group getName],kUSER_NICKNAME,[messageDic objectForKey:@"text"],kUSER_DESCRIPTION,@"",kUSER_USERHEAD,[NSNumber numberWithInt:1],kUSER_FRIEND_FLAG, nil];
//        
//        NSLog(@"dic = %@",dic);
//            
//            GroupObject *user = [GroupObject userFromDictionary:dic];
//            [GroupObject saveNewUser:user];
//            
////        }
//        
//        
//    }
//    
//    // 保存聊天发送的时间
//    [CommonUtil addValue:msg.messageDate andKey:@"SendDateKey"];
//    
//    [GroupChatObject save:msg];
//    
//    //发送全局通知
//    [[NSNotificationCenter defaultCenter]postNotificationName:kXMPPSendNewMsgNotifaction object:msg];
    
     
    
}


#pragma  mark ------收发消息-------
- (void)sendMessage:(XMPPMessage *)aMessage
{
    // 保存用户收到信息的userId
//    [self saveUserIdString];
    
    [xmppStream sendElement:aMessage];
    
    NSString *body = [[aMessage elementForName:@"body"] stringValue];
    
    // NSString *meesageStyle=[[aMessage attributeForName:@"type"] stringValue];
    NSString *meesageTo = [[aMessage to]bare];
    NSArray *strs = [meesageTo componentsSeparatedByString:@"@"];
    
    //创建message对象
    MessageObject *msg = [[MessageObject alloc]init];
    [msg setMessageDate:[NSDate date]];
    [msg setMessageFrom:[[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID]];
    
    [msg setMessageTo:strs[0]];
    //判断多媒体消息
    NSDictionary *messageDic = [body JSONValue];

    [msg setMessageType:[NSNumber numberWithInt:[[messageDic objectForKey:@"messageType"] intValue]]];
    
    // 判断是发送的语音还是文本还是图片
    if ( [[messageDic objectForKey:@"messageType"] intValue] == kWCMessageTypeVoice ) {
        // 语音的情况下，将文本转换成wav文件路径存储
        NSData *voiceData = [NSData dataFromBase64String:[messageDic objectForKey:@"text"]];

        // 将语音保存为以时间
        long long timeMills = [NSDate currentTimeMillis];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *documentPath = [paths objectAtIndex:0];

        NSString *saveVoiceFilePath = [NSString stringWithFormat:@"%@/%@_%lld_send.wav",documentPath,[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_ID],timeMills];
        
        [voiceData writeToFile:saveVoiceFilePath atomically:YES];
        
        // 保存语音的保存路径
        [msg setMessageContent:saveVoiceFilePath];
        
        // 保存语音的文本形式用于下面的判断
        [CommonUtil addValue:[messageDic objectForKey:@"text"] andKey:@"VoiceFileKey"];
        
        
        
    }else if ( [[messageDic objectForKey:@"messageType"] intValue] == kWCMessageTypePlain ){
        
        // 不是语音的情况下直接存储文本
//        [msg setMessageContent:[messageDic objectForKey:@"text"]];
        [msg setMessageContent:[GTMBase64 stringByBase64String:[messageDic objectForKey:@"text"]]];
  
    }
    else
    {
        [msg setMessageContent:[messageDic objectForKey:@"text"]];
  
    }
    
    
    [msg setIsRead:@"0"];
  
    NSString *otherId = [CommonUtil getValueByKey:OTHERMEMBERID];
    
    // 判断数据库里面是否已经存在
    if ( ![Userobject haveSaveUserById:otherId withFriendId:[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_ID]]) {
    
        // 保存
        NSString *messageFrom = [CommonUtil getValueByKey:kFromMessage];
        
        if ( [messageFrom isEqualToString:@"1"] ) {
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_ID],kUSER_FRIENDID,otherId,kUSER_ID,[CommonUtil getValueByKey:OTHERUSERNAME],kUSER_NICKNAME,[messageDic objectForKey:@"text"],kUSER_DESCRIPTION,[CommonUtil getValueByKey:OTHERHEADERIMAGE],kUSER_USERHEAD,[NSNumber numberWithInt:[[CommonUtil getValueByKey:kFriendFlag] intValue]],kUSER_FRIEND_FLAG, nil];
            
            Userobject *user = [Userobject userFromDictionary:dic];
            [Userobject saveNewUser:user];
            
        }else{
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_ID],kUSER_FRIENDID,otherId,kUSER_ID,[CommonUtil getValueByKey:OTHERUSERNAME],kUSER_NICKNAME,[messageDic objectForKey:@"text"],kUSER_DESCRIPTION,[CommonUtil getValueByKey:OTHERHEADERIMAGE],kUSER_USERHEAD,[NSNumber numberWithInt:1],kUSER_FRIEND_FLAG, nil];
            
            Userobject *user = [Userobject userFromDictionary:dic];
            [Userobject saveNewUser:user];
            
        }
        
        
   }
    
    // 保存聊天发送的时间
    [CommonUtil addValue:msg.messageDate andKey:@"SendDateKey"];

    [MessageObject save:msg];
    
    //发送全局通知
    [[NSNotificationCenter defaultCenter]postNotificationName:kXMPPSendNewMsgNotifaction object:msg];
 
}

#pragma mark --------配置XML流---------
- (void)setupStream
{
    
    //==========
    needHandlKeys = [[NSMutableSet alloc] initWithCapacity:5];
    handleResult = [[NSMutableDictionary alloc] initWithCapacity:5];
    fileSis = [[NSMutableDictionary alloc] initWithCapacity:5];
    fileTranfers = [[NSMutableArray alloc] initWithCapacity:5];
    
    if (nil == resouces) {
        resouces = [[NSMutableDictionary alloc] initWithCapacity:5];
    }
    //===========
    
    beepSound = -1;

	NSAssert(xmppStream == nil, @"Method setupStream invoked multiple times");
    
	xmppStream = [[XMPPStream alloc] init];
	
#if !TARGET_IPHONE_SIMULATOR
	{
        xmppStream.enableBackgroundingOnSocket = YES;
	}
#endif
	
	
	
	xmppReconnect = [[XMPPReconnect alloc] init];
	
    // Setup capabilities
	//
	// The XMPPCapabilities module handles all the complex hashing of the caps protocol (XEP-0115).
	// Basically, when other clients broadcast their presence on the network
	// they include information about what capabilities their client supports (audio, video, file transfer, etc).
	// But as you can imagine, this list starts to get pretty big.
	// This is where the hashing stuff comes into play.
	// Most people running the same version of the same client are going to have the same list of capabilities.
	// So the protocol defines a standardized way to hash the list of capabilities.
	// Clients then broadcast the tiny hash instead of the big list.
	// The XMPPCapabilities protocol automatically handles figuring out what these hashes mean,
	// and also persistently storing the hashes so lookups aren't needed in the future.
	//
	// Similarly to the roster, the storage of the module is abstracted.
	// You are strongly encouraged to persist caps information across sessions.
	//
	// The XMPPCapabilitiesCoreDataStorage is an ideal solution.
	// It can also be shared amongst multiple streams to further reduce hash lookups.
	
	// Activate xmpp modules
    
    xmppRosterStorage = [[XMPPRosterCoreDataStorage alloc] init];
	
	xmppRoster = [[XMPPRoster alloc] initWithRosterStorage:xmppRosterStorage];
	
	xmppRoster.autoFetchRoster = YES;
	xmppRoster.autoAcceptKnownPresenceSubscriptionRequests = YES;
    
	[xmppReconnect         activate:xmppStream];
    [xmppRoster            activate:xmppStream];
    
	// Add ourself as a delegate to anything we may be interested in
    
	[xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
	
	// Optional:
	//
	// Replace me with the proper domain and port.
	// The example below is setup for a typical google talk account.
	//
	// If you don't supply a hostName, then it will be automatically resolved using the JID (below).
	// For example, if you supply a JID like 'user@quack.com/rsrc'
	// then the xmpp framework will follow the xmpp specification, and do a SRV lookup for quack.com.
	//
	// If you don't specify a hostPort, then the default (5222) will be used.
	
//	[xmppStream setHostName:kXMPPHost];
//	[xmppStream setHostPort:5222];
	
    
	// You may need to alter these settings depending on the server you're connecting to
	allowSelfSignedCertificates = NO;
	allowSSLHostNameMismatch = NO;
    
    
    if (![self connect]) {
        [[[UIAlertView alloc]initWithTitle:@"服务器连接失败"
                                   message:nil
                                  delegate:self
                         cancelButtonTitle:@"确定"
                         otherButtonTitles: nil]show];
    };
}

- (void)teardownStream
{
	[xmppStream removeDelegate:self];
	
	[xmppReconnect         deactivate];
	
	[xmppStream disconnect];
	
	xmppStream = nil;
	xmppReconnect = nil;
}

// It's easy to create XML elments to send and to read received XML elements.
// You have the entire NSXMLElement and NSXMLNode API's.
//
// In addition to this, the NSXMLElement+XMPP category provides some very handy methods for working with XMPP.
//
// On the iPhone, Apple chose not to include the full NSXML suite.
// No problem - we use the KissXML library as a drop in replacement.
//
// For more information on working with XML elements, see the Wiki article:
// http://code.google.com/p/xmppframework/wiki/WorkingWithElements

- (void)goOnline
{
	XMPPPresence *presence = [XMPPPresence presence]; // type="available" is implicit
	
	[xmppStream sendElement:presence];
}

- (void)goOffline
{
	XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
	
	[xmppStream sendElement:presence];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Connect/disconnect
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (BOOL)connect
{
	if (![xmppStream isDisconnected]) {
		return YES;
	}
    
	NSString *myJID = [[NSUserDefaults standardUserDefaults] stringForKey:kXMPPmyJID];
	NSString *myPassword = [[NSUserDefaults standardUserDefaults] stringForKey:kXMPPmyPassword];
    
	//
	// If you don't want to use the Settings view to set the JID,
	// uncomment the section below to hard code a JID and password.
	//
	// myJID = @"user@gmail.com/xmppframework";
	// myPassword = @"";
	
	if (myJID == nil || myPassword == nil) {
		return NO;
	}
    
    [xmppStream setHostName:kXMPPHost];
    [xmppStream setHostPort:5222];
    
	[xmppStream setMyJID:[XMPPJID jidWithString:myJID]];
    
    //    [xmppStream setMyJID:[XMPPJID jidWithUser:myJID domain:@"mx-server" resource:@"ios"]];
    
	password = myPassword;
    
	NSError *error = nil;
	if (![xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error])
	{
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error connecting"
		                                                    message:@"See console for error details."
		                                                   delegate:nil
		                                          cancelButtonTitle:@"Ok"
		                                          otherButtonTitles:nil];
		[alertView show];
        
		DDLogError(@"Error connecting: %@", error);
        
		return NO;
	}
    
	return YES;
}

- (void)disconnect
{
	[self goOffline];
	[xmppStream disconnect];
}

- (NSManagedObjectContext *)managedObjectContext_roster
{
	return [xmppRosterStorage mainThreadManagedObjectContext];
}
// Returns the URL to the application's Documents directory.

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark XMPPStream Delegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)xmppStream:(XMPPStream *)sender socketDidConnect:(GCDAsyncSocket *)socket
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
}

- (void)xmppStream:(XMPPStream *)sender willSecureWithSettings:(NSMutableDictionary *)settings
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
	
	if (allowSelfSignedCertificates)
	{
		[settings setObject:[NSNumber numberWithBool:YES] forKey:(NSString *)kCFStreamSSLAllowsAnyRoot];
	}
	
	if (allowSSLHostNameMismatch)
	{
		[settings setObject:[NSNull null] forKey:(NSString *)kCFStreamSSLPeerName];
	}
	else
	{
		// Google does things incorrectly (does not conform to RFC).
		// Because so many people ask questions about this (assume xmpp framework is broken),
		// I've explicitly added code that shows how other xmpp clients "do the right thing"
		// when connecting to a google server (gmail, or google apps for domains).
		
		NSString *expectedCertName = nil;
		
		NSString *serverDomain = xmppStream.hostName;
		NSString *virtualDomain = [xmppStream.myJID domain];
		
		if ([serverDomain isEqualToString:@"talk.google.com"])
		{
			if ([virtualDomain isEqualToString:@"gmail.com"])
			{
				expectedCertName = virtualDomain;
			}
			else
			{
				expectedCertName = serverDomain;
			}
		}
		else if (serverDomain == nil)
		{
			expectedCertName = virtualDomain;
		}
		else
		{
			expectedCertName = serverDomain;
		}
		
		if (expectedCertName)
		{
			[settings setObject:expectedCertName forKey:(NSString *)kCFStreamSSLPeerName];
		}
	}
}

- (void)xmppStreamDidSecure:(XMPPStream *)sender
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
}

- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
	
	isXmppConnected = YES;
	
	NSError *error = nil;
	
	if (![xmppStream authenticateWithPassword:password error:&error])
	{
		DDLogError(@"Error authenticating: %@", error);
	}
}

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
	
	[self goOnline];
    [xmppRoster fetchRoster];
}

- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    
}

//返回IQ的
- (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq
{
	DDLogVerbose(@"%@: %@ - %@", THIS_FILE, THIS_METHOD, [iq elementID]);
    
//    [[NSNotificationCenter defaultCenter]postNotificationName:kXMPPNewMsgNotifaction object:nil];
    
    NSString *idd = [iq attributeStringValueForName:@"id" withDefaultValue:@"0"];
    
    // IQ_CREATE_GROUP
  
    if( [IQ_ID_CREATE_GROUP isEqualToString:idd] ){
      
        [XMPP_service bindUsers2group:iq.fromStr];
        
    } else if([IQ_ID_GROUP_BIND_USER isEqualToString:idd]){
      
        [XMPP_service configGroup:iq.fromStr roomName:Appdelegate.HHcreateRoomName];
        
    } else if ( [IQ_ID_GROUP_CONFIG isEqualToString:idd] ){
        
        if ( Appdelegate.gChatGroups.count == 0 ) {
            
            for (NSString *each in Appdelegate.HHinitRoomUsers) {
                
                [XMPP_service inviteUser2group:iq.fromStr userId:each];
                
            }
                        
            DDXMLElement *item = [DDXMLElement elementWithName:@"item"];
            [item addAttributeWithName:@"name" stringValue:Appdelegate.HHcreateRoomName];
            [item addAttributeWithName:@"node" stringValue:[NSString stringWithFormat:@"%@@%@",[CommonUtil getValueByKey:MEMBER_ID],@"home.cityandcity.com"]];
            [item addAttributeWithName:@"jid" stringValue:iq.fromStr];
            
            ChatGroup *group = [[ChatGroup alloc] init];
            group.data = item;
            
            [Appdelegate.gChatGroups insertObject:group atIndex:0];
            
            [XMPP_service presenceGroupWithGroup:group.data];
            [XMPP_service getGroupUsers:group.data];
            
            Appdelegate.HHcreateGroupResult = group;
            
        }
        
    }else if([IQ_ID_GET_GROUP_USERS isEqualToString:idd]){
       
        for (ChatGroup *each in Appdelegate.gChatGroups) {
            
            NSString *jid = [each.data attributeStringValueForName:@"jid"];
            
            if ([jid isEqualToString:iq.fromStr]) {
              
                NSArray *array = [[iq elementForName:@"query"] children];

                NSMutableArray *mArray = [array mutableCopy];
                each.members = mArray;
                                
                break;
            }
        }
        
        // 创建群聊成功后通知
        [[NSNotificationCenter defaultCenter]postNotificationName:@"CreateGroupChatting" object:nil];
        
    }else if([IQ_ID_GET_GROUPS isEqualToString:idd]){
        
        [Appdelegate.gChatGroups removeAllObjects];
        
        NSArray *child = [[iq elementForName:@"query"] children];
        
        for (DDXMLElement *each in child) {
            
            ChatGroup *cg = [[ChatGroup alloc] init];
            cg.data = each;
            
            [XMPP_service presenceGroupWithGroup:cg.data];
            
            [Appdelegate.gChatGroups addObject:cg];
            
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"groups_change"object:nil];
        
    }else if ( [IQ_ID_GROUP_CONFIG_CHANGE_NAME isEqualToString:idd] ){
        
        NSLog(@"response IQ_ID_GROUP_CONFIG %@",iq);
        // 群主修改群的名字修改成功的操作
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_MODIFY_GROUPNAME object:nil];
        
    }
    
//    else if ( [IQ_ID_GROUP_LEAVE isEqualToString:idd] ){
//     
//        NSLog(@"response IQ_ID_GROUP_CONFIG %@",iq);
//        
//        NSLog(@"iq.toStr = %@",iq.toStr);
//
//        
//        NSArray *parts = [[iq fromStr] componentsSeparatedByString:@"@"];
//        NSArray *parts1 = [[iq toStr] componentsSeparatedByString:@"@"];
//
//        
//        NSLog(@"parts= %@,parts1 = %@",parts,parts1);
//        
//        ChatGroup *group = [self getGroupById:parts[0]];
//        
//        NSLog(@"group = %@，parts1[0] = %@",group,parts1[0]);
//        
//        if( group ){
//            
//            [group removeMember:parts1[0]];
//            
//        }
//        
//    }
    
    else{
        
        NSLog(@"else");
    
        BOOL handled = [self handleIfIgnore:iq];
        
        if(NO == handled){
            
            handled = [self handleIfFileTranferSi:iq];
        }
        if(NO == handled){
            
            handled = [self handleIfFileTranfer:iq];
        }
        //
        if(NO == handled){
            
            [self handleIfFileStreamHost:iq];
            return NO;
        }

        
        
    }

    
	return YES;
}

//=======

- (void) handleIfFileStreamHost:(XMPPIQ *) iq{
    NSString *idd = [iq attributeStringValueForName:@"id"];
    
    if (idd && [needHandlKeys containsObject:idd]) {
        NSXMLElement *streamhost = [[iq elementForName:@"query"] elementForName:@"streamhost"];
        if (streamhost) {
            NSString *_port = [streamhost attributeStringValueForName:@"port"];
            NSString *_host = [streamhost attributeStringValueForName:@"host"];
            NSString *_jid = [streamhost attributeStringValueForName:@"jid"];
            if (_port && _host && _jid) {
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:5];
                [dict setObject:_port forKey:@"port"];
                [dict setObject:_host forKey:@"host"];
                [dict setObject:_jid forKey:@"jid"];
                [handleResult setObject:dict forKey:idd];
            }
        }
        [needHandlKeys removeObject:idd];
    }else{
//        NSLog(@"no handle for %@",iq);
        
    }
    
}

- (BOOL) handleIfIgnore:(XMPPIQ *) iq{
    NSString *idd = [iq attributeStringValueForName:@"id"];
    if (idd && [idd rangeOfString:@"ignore"].location == 0) {
        return YES;
    }
    return NO;
}

- (BOOL) handleIfFileTranferSi:(XMPPIQ *) el{
    NSString *type = [el attributeStringValueForName:@"type"];

    
    if(NO == [@"set" isEqualToString:type]){
        return NO;
    }
    DDXMLElement *siEl = [el elementForName:@"si"];
    if(nil == siEl){
        return NO;
    }
    
    NSString *profile = [siEl attributeStringValueForName:@"profile"];
    if(NO == [profile isEqualToString:@"http://jabber.org/protocol/si/profile/file-transfer"]){
        return NO;
    }
    //记录下 sid 相关的文件信息
    NSString *sid = [siEl attributeStringValueForName:@"id"];
    DDXMLElement *fileEl =[siEl elementForName:@"file"];
    NSString *name = [fileEl attributeStringValueForName:@"name"];
    int size = [fileEl attributeIntValueForName:@"size"];
    
    NSString *from = [el attributeStringValueForName:@"from"];
    NSString *to = [el attributeStringValueForName:@"to"];
    
    SI *si = [[SI alloc] init];
    si.sid = sid;
    si.name = name;
    si.size = size;
    si.from = from;
    [fileSis setObject:si forKey:sid];
//    [si release];
    
    
    NSLog(@"sid = %@,name = %@,size = %i",sid,name,size);
    
//    [from retain];
//    [to retain];
    [fileEl detach];
    [el removeAttributeForName:@"from"];
    [el removeAttributeForName:@"to"];
    [el addAttributeWithName:@"from" stringValue:to];
    [el addAttributeWithName:@"to" stringValue:from];
    [el addAttributeWithName:@"type" stringValue:@"result"];
    
    
    DDXMLElement *x = [[siEl elementForName:@"feature"] elementForName:@"x"];
    [x removeAttributeForName:@"type"];
    [x addAttributeWithName:@"type" stringValue:@"submit"];
    
    DDXMLElement *field = [x elementForName:@"field"];
    [field removeAttributeForName:@"type"];
    
    [field removeChildAtIndex:0];
    [field addChild:[DDXMLElement elementWithName:@"value" stringValue:@"http://jabber.org/protocol/bytestreams"]];
    
    [xmppStream sendElement:el];
    
    return YES;
}

-(BOOL) handleIfFileTranfer:(XMPPIQ *) el{
    NSString *type = [el attributeStringValueForName:@"type"];
    if(NO == [@"set" isEqualToString:type]){
        return NO;
    }
    
    
    DDXMLElement *query = [el elementForName:@"query"];
    if(nil == query){
        return NO;
    }
    
    NSString *xmlns = [query xmlns];
    if(nil == xmlns || NO == [xmlns isEqualToString:@"http://jabber.org/protocol/bytestreams"]){
        return NO;
    }
    NSString *sid = [query attributeStringValueForName:@"sid"];
    
    
    NSLog(@"sid111212= %@",sid);
    
    NSLog(@"fileSis = %@",fileSis);
  
    SI *si = [fileSis objectForKey:sid];
    if(nil == si){
        return NO;
    }
    TURNSocket *socket = [[TURNSocket alloc] initWithStream:xmppStream incomingTURNRequest:el];
//    socket.fileSize = si.size;
//    FileTransfer *fileTransfer = [[FileTransfer alloc] init];
//    fileTransfer.si = si;
//    [fileTranfers addObject:fileTransfer];
//    [socket startWithDelegate:fileTransfer delegateQueue:dispatch_get_main_queue()];
//    [fileTransfer release];
     
    [socket startWithDelegate:self delegateQueue:dispatch_get_main_queue()];

    return YES;
}

//=============

- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    
    NSLog(@"message = %@",message);
 
    if ([[message attributeStringValueForName:@"type"] isEqualToString: @"groupchat"]) {

        if ([Appdelegate.HHcreateingGroupJid isEqualToString:message.fromStr]) {
            
            // 创建群时执行的delegate方法
            [XMPP_service createGroup:message.fromStr];
            
            return;
            
        }else{
            
            // 发起聊天执行的delegate方法
            
//            NSString *jid = [NSString stringWithFormat:@"%@",[message attributeStringValueForName:@"jid"]];

//            if ( ![jid isEqualToString:@"(null)"] ) {
            
                if ( [message.fromStr rangeOfString:@"/"].location != NSNotFound ) {
                    
                    NSArray *part = [message.fromStr componentsSeparatedByString:@"/"];
                    
                    if (part.count == 2 && [part[1] isEqualToString:[NSString stringWithFormat:@"%@", [CommonUtil getValueByKey:MEMBER_ID]]]) {
                       
                        // 表示是自己发的消息的时候处理的一些方法
                        // 保存数据到数据库中
                        [self GroupRequestSubmit:message];
                        
                        return;
                        
                    }else{
                        
                        // 保存数据到数据库中
                        [self GroupRequestSubmit:message];
                        
                        return;
                        
                    }

                }else{
                    
                    return;
                }

                
                BOOL handleIfKick = [self handleIfKick:message];
                
                if(handleIfKick){
                    return;
                }
                
            
           
        }
    }else{
    
        // 发起群聊时执行的方法
        if ([Appdelegate.HHcreateingGroupJid isEqualToString:message.fromStr]) {
            
            // 将数据保存到数据库中
            
            return;
            
        }else{
            
//            return;
        }
        
        
    }

    //TODO ignore groupchat
	if ([message isChatMessageWithBody]){

        //    NSString *body = [[message elementForName:@"body"] stringValue];
        NSString *displayName = [[message to]bare];
        NSArray *strs = [displayName componentsSeparatedByString:@"@"];
        
        NSString *displayName1 = [[message from]bare];
        
        NSArray *strs1 = [displayName1 componentsSeparatedByString:@"@"];
        
        
        if ( [strs[0] isEqualToString:strs1[0]] ) {
            
            return;
            
        }else{
            
            // 根据用户的memberId，请求数据来获得用户的昵称和头像等
            [self MemberRequestSubmit:message];
            
            
        }
        
    }else{
        
        NSString *type = [NSString stringWithFormat:@"%@",[message attributeStringValueForName:@"type"]];
        
        NSLog(@"message = %@",message);

        
        if ( [type isEqualToString:@"(null)"] ) {
            
            Appdelegate.isAddToBase = YES;
            
            NSString *invite = [[message elementForName:@"x"] stringValue];
            
            if ( invite.length > 0 && ![invite isEqualToString:@"(null)"] ) {
                
                if ( [invite rangeOfString:@"邀请"].location != NSNotFound ) {
                    
                    NSArray *l_arr = [invite componentsSeparatedByString:@"/"];
                    
                    // 说明是邀请来的
                    //创建message对象
                    GroupChatObject *msg = [[GroupChatObject alloc]init];
                    [msg setMessageDate:[NSDate date]];
                    
                   // 判断是否是名字、memberId和头像拼接的字符
                    if ( [l_arr[1] rangeOfString:@"|"].location == NSNotFound ) {
                        // 表示不是拼接的字符
                        NSArray *arr = [message.fromStr componentsSeparatedByString:@"@"];
                        
                        NSLog(@"arr33323 = %@,l_arr[1] = %@,message.toStr = %@",arr,l_arr[1],message.toStr);
                        
                        if ( arr.count > 0 ) {
                            
                            [msg setMessageFrom:l_arr[1]];
                            
                            [msg setMessageTo:arr[0]];
                            
                            [msg setMessageType:[NSNumber numberWithInt:kWCMessageTypePlain]];
                            [msg setMessageContent:[GTMBase64 stringByBase64String:l_arr[0]]];
                            
                            [msg setMessageContent:l_arr[0]];
                            
                            // 设置群组的图标 =====
                            [msg setMessageImageV:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:USER_PHOTO]]];
                            
                            [msg setIsRead:@"1"];
                            if ( ![GroupObject haveSaveUserById:arr[0] withFriendId:[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_ID]]) {
                                
                                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_ID],kUSER_FRIENDID,arr[0],kUSER_ID,l_arr[1],kUSER_NICKNAME,l_arr[0],kUSER_DESCRIPTION,@"",kUSER_USERHEAD,[NSNumber numberWithInt:1],kUSER_FRIEND_FLAG, nil];
                                
                                GroupObject *user = [GroupObject userFromDictionary:dic];
                                [GroupObject saveNewUser:user];
                                
                                
                                
                            }
                            
                            
                            [GroupChatObject save:msg];
                            
                        }
                        
                       
                        
                    }else{
                        
                        // 表示是名字拼接的字符
                        NSArray *arr = [message.fromStr componentsSeparatedByString:@"@"];
                        
                        NSLog(@"arr4444 = %@,l_arr[1] = %@,message.toStr = %@",arr,l_arr[1],message.toStr);
                        
                        
                        NSArray *l_array = [invite componentsSeparatedByString:@"邀请你加入群/"];
                        
                        if ( arr.count > 0 ) {
                            
                            if ( l_array.count != 0 ) {
                                
                                NSLog(@"l_array = %@",l_array);
                                
                                NSArray *l_aa = [l_array[1] componentsSeparatedByString:@"|"];
                                
                                NSLog(@"l_aa = %@",l_aa);
                                
                                if ( l_aa.count != 0 ) {
                                    
                                    [msg setMessageFrom:l_aa[1]];
                                    
                                    [msg setMessageTo:arr[0]];
                                    
                                    [msg setMessageType:[NSNumber numberWithInt:kWCMessageTypePlain]];
                                    [msg setMessageContent:[GTMBase64 stringByBase64String:l_arr[0]]];
                                    
                                    [msg setMessageContent:l_arr[0]];
                                    
                                    // 设置群组的图标 =====
                                    [msg setMessageImageV:[NSString stringWithFormat:@"%@",l_aa[2]]];
                                    
                                    [msg setIsRead:@"1"];
                                    if ( ![GroupObject haveSaveUserById:arr[0] withFriendId:[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_ID]]) {
                                        
                                        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_ID],kUSER_FRIENDID,arr[0],kUSER_ID,[NSString stringWithFormat:@"%@|%@",l_aa[0],l_aa[1]],kUSER_NICKNAME,l_arr[0],kUSER_DESCRIPTION,l_aa[2],kUSER_USERHEAD,[NSNumber numberWithInt:1],kUSER_FRIEND_FLAG, nil];
                                        
                                        GroupObject *user = [GroupObject userFromDictionary:dic];
                                        [GroupObject saveNewUser:user];
                                        
                                    }
                                    
                                    
                                    [GroupChatObject save:msg];
                                    
                                }
                            }
                         
                        }
                      
                    }
                    
                    //合局通知
                    [[NSNotificationCenter defaultCenter]postNotificationName:kXMPPNewMsgNotifaction object:msg];
                    [[NSNotificationCenter defaultCenter]postNotificationName:kXMPPSendNewMsgNotifaction object:msg];
                    
                    // 收到消息后有声音提示 (包含这值说明有新的消息发送过来)
                    NSBundle *mainBundle = [NSBundle mainBundle];
                    
                    self.soundToPlay = [NSURL fileURLWithPath:[mainBundle pathForResource:@"Void" ofType:@"mp3"] isDirectory:YES];
                    
                    if ( [self soundToPlay] != nil) {
                        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[self soundToPlay], &beepSound);
                        if (error != kAudioServicesNoError) {
                            //                    NSLog(@"Problem loading nearSound.caf");
                        }
                    }
                    
                    
                    if (beepSound != (SystemSoundID)-1) {
                        AudioServicesPlaySystemSound(beepSound);
                    }
                    
                }
            }

            
        }else{
            
            
            return;
        }
        
        
        if ([message.fromStr rangeOfString:@"conference"].location != NSNotFound) {
            
            [XMPP_service getGroups];
        }
        
    }

}

- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{
    
	DDLogVerbose(@"%@: %@ - %@", THIS_FILE, THIS_METHOD, [presence fromStr]);
    
    
//    NSLog(@"TYPE = %@",[presence type]);
    
    if([@"unavailable" isEqualToString:[presence type]]){
        
        BOOL handled = [self handleIfKickPresence:presence];
        
        if(handled){
            return;
        }
    }
    
    if([@"unavailable" isEqualToString:[presence type]]){
       
        [self handleIfGroupDismiss:presence];
    }
}

-(BOOL) handleIfKickPresence:(XMPPPresence *) presence{
    
    DDXMLElement *xEl = [presence firstInSub:@"x"];
        
    if(nil == xEl){
        return NO;
    }
    DDXMLElement *statusEl = [xEl firstInSub:@"status"];
    
    
//    if(nil == statusEl){
//        return NO;
//    }
    
//    if(NO == [@"321" isEqualToString:[statusEl attributeStringValueForName:@"code" withDefaultValue:@""]]){
//        return NO;
//    }
    NSArray *parts = [[presence fromStr] componentsSeparatedByString:@"@"];
    
    if(parts.count != 2){
        return NO;
    }
    ChatGroup *group = [self getGroupById:parts[0]];

    if( group ){
        
        NSArray *parts2 = [[presence fromStr] componentsSeparatedByString:@"/"];
        
        if(parts2.count == 2){
            
            if([[CommonUtil getValueByKey:MEMBER_ID] isEqualToString:parts2[1]]){

                // 删除数组中的值
                [Appdelegate.gChatGroups removeObject:group];
                // 数据库中删除数据
                if ( [GroupChatObject deleteMessageFromUserId:group.groupIdMain] ) {
                    if ( [GroupChatObject delereUserId:group.groupIdMain] ) {
                    }
                }
                // 发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_KICK_OUT_ME object:group];
            }else{
                
                [group removeMember:parts2[1]];
               
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_KICK_OUT_OTHER object:group];
            }
            return YES;
        }
        
    }
    return NO;
}

-(BOOL) handleIfGroupDismiss:(XMPPPresence *) presence{
    
    DDXMLElement *xEl = [presence firstInSub:@"x"];
    if(nil == xEl){
        return NO;
    }
    DDXMLElement *destroyEl = [xEl firstInSub:@"destroy"];
    if(nil == destroyEl){
        return NO;
    }
    NSString *jid = [destroyEl attributeStringValueForName:@"jid" withDefaultValue:@""];
    NSArray *parts = [jid componentsSeparatedByString:@"@"];
    if(parts.count != 2){
        return NO;
    }
    ChatGroup *group = [self getGroupById:parts[0]];
    if(group){
//        [group retain];
//        [group autorelease];
//        [DAO deleteWithGroupId:group.groupIdMain];
        [Appdelegate.gChatGroups removeObject:group];
        // 数据库中删除数据
        if ( [GroupChatObject deleteMessageFromUserId:group.groupIdMain] ) {
            if ( [GroupChatObject delereUserId:group.groupIdMain] ) {
            }
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_KICK_OUT_ME object:group];
        return YES;
    }
    return NO;
}
- (ChatGroup *) getGroupById:(NSString *) key{
    
    for (ChatGroup *each in Appdelegate.gChatGroups) {
        
        if ([each.groupIdMain rangeOfString:key].location != NSNotFound) {
            return each;
        }
    }
    return nil;
}

-(BOOL) handleIfKick:(XMPPMessage *) message{
    
    DDXMLElement *el = [message firstInSub:@"headers"];
    if(nil == el){
        return NO;
    }
    NSArray *elChildren = [el children];
    if(2 != elChildren.count){
        return NO;
    }
    NSMutableDictionary *infos = [NSMutableDictionary dictionaryWithCapacity:5];
    for(DDXMLElement *each in elChildren){
        infos[[each attributeStringValueForName:@"name" withDefaultValue:@""]] = [each stringValue];
    }
    if(NO == [@"WorkGroupDelMember" isEqualToString:infos[@"CustomMsgType"]]){
        return NO;
    }
    NSString *groupId = [message.fromStr componentsSeparatedByString:@"@"][0];
    ChatGroup *group = [self getGroupById:groupId];
    if(nil == group){
        return NO;
    }
    NSString *kickId = [infos[@"CustomMsgValue"] componentsSeparatedByString:@"@"][0];
    [group removeMember:kickId];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_KICK_OUT_OTHER object:group];
 
    return YES;
    
}


- (void)xmppStream:(XMPPStream *)sender didReceiveError:(id)error
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
}

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
	
	if (!isXmppConnected)
	{
		DDLogError(@"Unable to connect to server. Check xmppStream.hostName");
        
        [SVProgressHUD showErrorWithStatus:@"未能连接到聊天服务器"];
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark XMPPRosterDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence
{
    
    XMPPJID *jid = [XMPPJID jidWithString:[presence stringValue]];
    [xmppRoster acceptPresenceSubscriptionRequestFrom:jid andAddToRoster:YES];
}

- (void)addSomeBody:(NSString *)userId
{
    [xmppRoster subscribePresenceToUser:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@@home.cityandcity.com",userId]]];
}

//有人在群里发言(实现代理方法)
-(void)xmppRoom:(XMPPRoom *)sender didReceiveMessage:(XMPPMessage *)message fromOccupant:(XMPPJID *)occupantJID{
    
    [self alert:@"有人在群里发言"];
}
 //新人加入群聊
- (void)xmppRoom:(XMPPRoom *)sender occupantDidJoin:(XMPPJID *)occupantJID
{
    NSLog(@"新人加入群聊");
    [self alert:@"新人加入群聊"];

}
// 有人退出群聊
- (void)xmppRoom:(XMPPRoom *)sender occupantDidLeave:(XMPPJID *)occupantJID
{
    NSLog(@"有人退出群聊");
    [self alert:@"有人退出群聊"];

}

//接收到邀请后客户端调用XMPPMUCDelegate里的回调函数
//实现这个方法做出响应。
-(void)xmppMUC:(XMPPMUC *)sender roomJID:(XMPPJID *)roomJID didReceiveInvitation:(XMPPMessage *)message;
{
    
    [self alert:@"有人加你群聊"];
    
}

- (void)fetchUser:(NSString*)userId
{
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"加载中" message:@"刷新好友列表中，请稍候" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
    [av show];
}

#pragma mark - 群里发来消息时候请求数据的处理
- (void)GroupRequestSubmit:(XMPPMessage *)message{
 
    NSString *body = [[message elementForName:@"body"] stringValue];
    
//    NSString *displayName = [[message from]bare];
   
// NSArray *strs = [displayName componentsSeparatedByString:@"/"];
   
    NSArray *strs = [message.fromStr componentsSeparatedByString:@"/"];

    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           strs[1],@"getMemberId",nil];
    
    //    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"ChatUserDetail.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        NSString * string;
        
        if (success) {
            
            NSDictionary *messageDic = [body JSONValue];
            
            //创建message对象
            GroupChatObject *msg = [[GroupChatObject alloc]init];
            
            // 设置时间的值
            if ( [[messageDic objectForKey:@"dateKey"] isEqualToString:@"(null)"] ) {
                
                [msg setMessageDate:[NSDate date]];
                
            }else{
                
                [msg setMessageDate:[self dateFromString:[messageDic objectForKey:@"dateKey"]]];
                
            }
            
            [msg setMessageImageV:[NSString stringWithFormat:@"%@",[json valueForKey:@"PhotoMid"]]];
            
            // 解决重复发送图片的问题=======
          /* {
                
                NSDate *defaultDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"SendDateKey"];
                
                NSTimeInterval interval = [msg.messageDate timeIntervalSinceDate:defaultDate];
                
                {
                    
                    NSMutableArray *arr = [MessageObject fetchMessageListWithUser:strs[0] byPage:1];
                    if ( arr.count != 0 ) {
                        
                        MessageObject *message = [arr objectAtIndex:arr.count - 1];
                        
                        if ( [[messageDic objectForKey:@"messageType"] intValue] == kWCMessageTypeImage ) {
                            
                            if ( [[messageDic objectForKey:@"text"] isEqualToString:message.messageContent] && [message.messageType isEqualToNumber:[NSNumber numberWithInt:kWCMessageTypeImage]] && interval <= 50.000000 ) {
                                
                                return ;
                                
                            }
                            
                        }else if ( [[messageDic objectForKey:@"messageType"] intValue] == kWCMessageTypeVoice ) {
                            
                            NSString *voiceString = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"VoiceFileKey"]];
                            
                            if ( [[messageDic objectForKey:@"text"] isEqualToString:voiceString] && [message.messageType isEqualToNumber:[NSNumber numberWithInt:kWCMessageTypeVoice]] && interval <= 50.000000 ) {
                                
                                return ;
                                
                            }
                            
                        }else  if ( [[messageDic objectForKey:@"messageType"] intValue] == kWCMessageTypePlain ) {
                            
                            if ( [[messageDic objectForKey:@"text"] isEqualToString:message.messageContent] && [message.messageType isEqualToNumber:[NSNumber numberWithInt:kWCMessageTypePlain]] && interval <= 50.000000 ) {
                                
                                return ;
                                
                            }
                            
                        }else{
                            
                            
                        }
                        
                        
                    }
                    
                }
                
            }*/
            
            [msg setMessageFrom:strs[1]];
            
            
            // 判断来自不同的类型
            if ( [[messageDic objectForKey:@"messageType"] intValue] == kWCMessageTypeVoice ) {
                // 语音的情况下，将文本转换成wav文件路径存储
                
                //                NSData *voiceData = [GTMBase64 encodeData:[[messageDic objectForKey:@"text"] dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO]];
                
                
                NSData* encodeData = [[NSString stringWithFormat:@"%@",[messageDic objectForKey:@"text"]] dataUsingEncoding:NSUTF8StringEncoding];
                
                NSData* voiceData = [GTMBase64 decodeData:encodeData];
                
                
                long long timeMills = [NSDate currentTimeMillis];
                
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
                NSString *documentPath = [paths objectAtIndex:0];
                
                
                NSString *saveVoiceFilePath = [NSString stringWithFormat:@"%@/%@_%lld_send.wav",documentPath,strs[0],timeMills];
                
                
                [voiceData writeToFile:saveVoiceFilePath atomically:YES];
                
                
                // 保存语音的保存路径
                [msg setMessageContent:saveVoiceFilePath];
            
                
            }else if ( [[messageDic objectForKey:@"messageType"] intValue] == kWCMessageTypePlain ){
            
                //                [msg setMessageContent:[messageDic objectForKey:@"text"]];
                
                //                string = [NSData base64Decode:[NSString stringWithFormat:@"%@",[messageDic objectForKey:@"text"]]];
                
                string = [GTMBase64 stringByBase64String:[messageDic objectForKey:@"text"]];
                
                [msg setMessageContent:string];
                
                
            }else
            {
                [msg setMessageContent:[messageDic objectForKey:@"text"]];
                
            }
        
            
            //==========
            
            NSArray *l_aa = [strs[0]componentsSeparatedByString:@"@"];
            
            [msg setMessageTo:l_aa[0]];
            
            //============

            [msg setMessageType:[NSNumber numberWithInt:[[messageDic objectForKey:@"messageType"] intValue]]];
            
            
            // 判断如果是第一次进入app后收到的群消息都为已读
            if ( Appdelegate.isFirstGroup ) {
                
                [msg setIsRead:@"0"];
                
            }else{

                // 判断是收到别人的消息还是自己发出的消息
                if ( ![strs[1] isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID]] ) {
                    
                    [msg setIsRead:@"1"];
                    
                }else{
                    
                    [msg setIsRead:@"0"];
                    
                }
            }
          
            
            [GroupChatObject save:msg];

            if ( ![GroupObject haveSaveUserById:l_aa[0] withFriendId:[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_ID]] ) {
                

                // =======
                Appdelegate.isAddToBase = YES;
              
                // 保存
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID],kUSER_FRIENDID,l_aa[0],kUSER_ID,[NSString stringWithFormat:@"%@|%@",[json valueForKey:@"NickName"],strs[1]],kUSER_NICKNAME,string,kUSER_DESCRIPTION,[json valueForKey:@"PhotoMid"],kUSER_USERHEAD,[NSNumber numberWithInt:1],kUSER_FRIEND_FLAG, nil];
                
                GroupObject *user = [GroupObject userFromDictionary:dic];
                [GroupObject saveNewUser:user];
                
            }else{
                

                // =======
                Appdelegate.isAddToBase = NO;
              
                NSString *description = nil;
                
                // 判断是收到图片还是文本信息还是语音 -- 更换数据库中的值的内容
                if ( [msg.messageType intValue] == kWCMessageTypeImage ) {
                    
                     // 如果是自己发出的则只显示我不显示名字
                     if ( ![strs[1] isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID]] ) {
                         
                          description  = [NSString stringWithFormat:@"%@:[一张图片]",[json valueForKey:@"NickName"]];
                         
                     }else{
                         
                         description  = @"我:[一张图片]";
                     }
                    
                }else if ( [msg.messageType intValue] == kWCMessageTypePlain ){
                    
                    
                    // 如果是自己发出的则只显示我不显示名字
                    if ( ![strs[1] isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID]] ) {
                        
                        description = [NSString stringWithFormat:@"%@:%@",[json valueForKey:@"NickName"],string];
                        
                    }else{
                        
                        description = [NSString stringWithFormat:@"我:%@",string];

                        
                    }
                    
                }else if ( [msg.messageType intValue] == kWCMessageTypeVoice ) {
                    
                    // 如果是自己发出的则只显示我不显示名字
                    if ( ![strs[1] isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID]] ) {
                        
                        description = [NSString stringWithFormat:@"%@:[一段语音]",[json valueForKey:@"NickName"]];

                    }else{
                        
                        description = @"我:[一段语音]";
                        
                    }
                    
                }else{
                    
                    
                }
                
                // 更改群聊消息的最后一条信息
                [GroupObject updateGroupMessage:description withUserId:l_aa[0]];
                

            }
            
            //合局通知
            [[NSNotificationCenter defaultCenter]postNotificationName:kXMPPNewMsgNotifaction object:msg];
            [[NSNotificationCenter defaultCenter]postNotificationName:kXMPPSendNewMsgNotifaction object:msg];
            
            if ( Appdelegate.isFirstGroup ) {
                
                
            }else{
               
                if ( ![strs[1] isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID]] ) {
                    // 收到消息后有声音提示 (包含这值说明有新的消息发送过来)
                    NSBundle *mainBundle = [NSBundle mainBundle];
                    
                    self.soundToPlay = [NSURL fileURLWithPath:[mainBundle pathForResource:@"Void" ofType:@"mp3"] isDirectory:YES];
                    
                    if ( [self soundToPlay] != nil) {
                        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[self soundToPlay], &beepSound);
                        if (error != kAudioServicesNoError) {
                            //                    NSLog(@"Problem loading nearSound.caf");
                        }
                    }
                    
                    
                    if (beepSound != (SystemSoundID)-1) {
                        AudioServicesPlaySystemSound(beepSound);
                    }
                    

                }
                
            }
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

    
    
}

#pragma mark - NetWork - 根据memberId来获得昵称和头像
- (void)MemberRequestSubmit:(XMPPMessage *)message{
    
    NSString *body = [[message elementForName:@"body"] stringValue];
    NSString *displayName = [[message from]bare];
    NSArray *strs = [displayName componentsSeparatedByString:@"@"];
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           strs[0],@"getMemberId",nil];
    
//    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"ChatUserDetail.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        
        NSString * string;
        
        if (success) {
            
            NSDictionary *messageDic = [body JSONValue];
            
            //创建message对象
            MessageObject *msg = [[MessageObject alloc]init];
            [msg setMessageDate:[NSDate date]];
            
            // 解决重复发送图片的问题=======
            {
                
                NSDate *defaultDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"SendDateKey"];
                
                NSTimeInterval interval = [msg.messageDate timeIntervalSinceDate:defaultDate];
                
                {
                    
                    NSMutableArray *arr = [MessageObject fetchMessageListWithUser:strs[0] byPage:1];
                    if ( arr.count != 0 ) {
                        
                        MessageObject *message = [arr objectAtIndex:arr.count - 1];
                        
                        if ( [[messageDic objectForKey:@"messageType"] intValue] == kWCMessageTypeImage ) {
                            
                            if ( [[messageDic objectForKey:@"text"] isEqualToString:message.messageContent] && [message.messageType isEqualToNumber:[NSNumber numberWithInt:kWCMessageTypeImage]] && interval <= 50.000000 ) {
                                
                                return ;
                                
                            }
                            
                        }else if ( [[messageDic objectForKey:@"messageType"] intValue] == kWCMessageTypeVoice ) {
                            
                            NSString *voiceString = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"VoiceFileKey"]];
                            
                            if ( [[messageDic objectForKey:@"text"] isEqualToString:voiceString] && [message.messageType isEqualToNumber:[NSNumber numberWithInt:kWCMessageTypeVoice]] && interval <= 50.000000 ) {
                                
                                return ;
                                
                            }
                            
                        }else  if ( [[messageDic objectForKey:@"messageType"] intValue] == kWCMessageTypePlain ) {
                            
                            if ( [[messageDic objectForKey:@"text"] isEqualToString:message.messageContent] && [message.messageType isEqualToNumber:[NSNumber numberWithInt:kWCMessageTypePlain]] && interval <= 50.000000 ) {
                                
                                return ;
                                
                            }
                            
                        }else{
                            
                            
                        }
                       
                       
                    }
                    
                }

            }
            
            [msg setMessageFrom:strs[0]];
            

            // 判断来自不同的类型
            if ( [[messageDic objectForKey:@"messageType"] intValue] == kWCMessageTypeVoice ) {
                // 语音的情况下，将文本转换成wav文件路径存储
                
//                NSData *voiceData = [GTMBase64 encodeData:[[messageDic objectForKey:@"text"] dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO]];


                NSData* encodeData = [[NSString stringWithFormat:@"%@",[messageDic objectForKey:@"text"]] dataUsingEncoding:NSUTF8StringEncoding];
                
                NSData* voiceData = [GTMBase64 decodeData:encodeData];
                
                
                long long timeMills = [NSDate currentTimeMillis];
                
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
                NSString *documentPath = [paths objectAtIndex:0];
                
                
                NSString *saveVoiceFilePath = [NSString stringWithFormat:@"%@/%@_%lld_send.wav",documentPath,strs[0],timeMills];
                

                [voiceData writeToFile:saveVoiceFilePath atomically:YES];

                
                // 保存语音的保存路径
                [msg setMessageContent:saveVoiceFilePath];
                

            }else if ( [[messageDic objectForKey:@"messageType"] intValue] == kWCMessageTypePlain ){
                
//                [msg setMessageContent:[messageDic objectForKey:@"text"]];
                
//                string = [NSData base64Decode:[NSString stringWithFormat:@"%@",[messageDic objectForKey:@"text"]]];
                
                string = [GTMBase64 stringByBase64String:[messageDic objectForKey:@"text"]];
                
                [msg setMessageContent:string];


            }else
            {
                [msg setMessageContent:[messageDic objectForKey:@"text"]];

            }
            
            
            [msg setMessageTo:[[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID]];
            [msg setMessageType:[NSNumber numberWithInt:[[messageDic objectForKey:@"messageType"] intValue]]];
            
            [msg setIsRead:@"1"];
            
            [MessageObject save:msg];
            
            if ( ![Userobject haveSaveUserById:strs[0] withFriendId:[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_ID]] ) {
                
                // 保存
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID],kUSER_FRIENDID,strs[0],kUSER_ID,[json valueForKey:@"NickName"],kUSER_NICKNAME,[messageDic objectForKey:@"text"],kUSER_DESCRIPTION,[json valueForKey:@"PhotoMid"],kUSER_USERHEAD,[NSNumber numberWithInt:1],kUSER_FRIEND_FLAG, nil];
                
                Userobject *user = [Userobject userFromDictionary:dic];
                [Userobject saveNewUser:user];
                
            }
            
            //合局通知
            [[NSNotificationCenter defaultCenter]postNotificationName:kXMPPNewMsgNotifaction object:msg];
            [[NSNotificationCenter defaultCenter]postNotificationName:kXMPPSendNewMsgNotifaction object:msg];


            // 收到消息后有声音提示 (包含这值说明有新的消息发送过来)
            NSBundle *mainBundle = [NSBundle mainBundle];
            
            self.soundToPlay = [NSURL fileURLWithPath:[mainBundle pathForResource:@"Void" ofType:@"mp3"] isDirectory:YES];
            
            if ( [self soundToPlay] != nil) {
                OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[self soundToPlay], &beepSound);
                if (error != kAudioServicesNoError) {
//                    NSLog(@"Problem loading nearSound.caf");
                }
            }
            
            
            if (beepSound != (SystemSoundID)-1) {
                AudioServicesPlaySystemSound(beepSound);
            }

            
            XMPPUserCoreDataStorageObject *user = [xmppRosterStorage userForJID:[message from]
                                                                     xmppStream:xmppStream
                                                           managedObjectContext:[self managedObjectContext_roster]];
            
            if ( [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive )
            {
             
                
                
            }else{
                
                UILocalNotification *localNotification = [[UILocalNotification alloc] init];
                localNotification.alertAction = @"Ok";
                
                
                // 判断是收到图片还是文本信息还是语音
                if ( [msg.messageType intValue] == kWCMessageTypeImage ) {
                    
                    localNotification.alertBody = [NSString stringWithFormat:@"%@:[一张图片]",[json valueForKey:@"NickName"]];
                    
                }else if ( [msg.messageType intValue] == kWCMessageTypePlain ){
                    
                    // 表情时候做的判断
                    NSString *result = string;
                    
                    while (true) {
                        
                        NSRange range = [result rangeOfString:@"/:HH"];
                        
                        if (range.location == NSNotFound ) {
                            
                            break;
                        }
                        
                        // 判断字符的长度用于删除字符时做的处理
                        if ( result.length < range.location + 8 ) {
                            
                            break;
                        }
                        //====
                        
                        NSString *endString = [result substringWithRange:NSMakeRange(range.location+7, 1)];
                        
                        if(nil == endString || NO == [@":" isEqualToString:endString]){
                            
                            break;
                        }
                        
                        NSString *rawTag = [result substringWithRange:NSMakeRange(range.location,8)];
                        
                        NSString *coreText = @"[表情]";
                        
                        result = [result stringByReplacingOccurrencesOfString:rawTag withString:coreText];
                    }
                    
                    // =======
                    // 设置有消息显示的数字
                    Appdelegate.m_badgeNumber = Appdelegate.m_badgeNumber + 1;
                    
                    localNotification.alertBody = [NSString stringWithFormat:@"%@:%@",[json valueForKey:@"NickName"],result];
                    
//                    localNotification.soundName = @"Void.mp3";
                    
                    localNotification.applicationIconBadgeNumber = Appdelegate.m_badgeNumber;
                    
//                    localNotification.alertBody = [NSString stringWithFormat:@"%@:%@",[json valueForKey:@"NickName"],string];
                }else if ( [msg.messageType intValue] == kWCMessageTypeVoice ) {
                    
                    localNotification.alertBody = [NSString stringWithFormat:@"%@:[一段语音]",[json valueForKey:@"NickName"]];
                    
                }else{
                    
                    
                }


                [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
            }
        
            
          } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

// 日期转换成字符类型
- (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    //    NSDate *date = [formatter dateFromString:dateStr];
    NSString *dateStr = [formatter stringFromDate:date];
    
    return dateStr;
}

- (NSDate *)dateFromString:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:dateStr];
    return date;
}


@end
         
         
