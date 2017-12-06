//
//  XMPP_service.h
//  HuiHui
//
//  Created by mac on 14-8-26.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DDXMLElement.h"

#import "XMPPManager.h"

@interface XMPP_service : NSObject

+ (void) presenceGroup;
+ (void) createGroup:(NSString *) groupJid;
+ (BOOL) handleIfKick:(XMPPMessage *) message;
+ (void) bindUsers2group:(NSString *) groupJid;
+ (void) configGroup:(NSString *) groupJid roomName:(NSString *) roomName;
+ (void) configGroup:(NSString *) groupJid roomName:(NSString *) roomName iqId:(NSString *) iqId;
+ (void) inviteUser2group:(NSString *) groupJid userId:(NSString *) userId;
+ (void) presenceGroupWithGroup:(DDXMLElement *) group;
+ (void) getGroupUsers:(DDXMLElement *) group;
+ (void) getGroups;
+(void) sendLeave:(DDXMLElement *) group;
+(void) sendDismiss:(DDXMLElement *) group;
+(void) kickUserInGroup:(DDXMLElement *) group userId:(int) userId;

@end
