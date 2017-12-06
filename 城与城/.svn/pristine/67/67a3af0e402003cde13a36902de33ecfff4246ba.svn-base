//
//  XMPP_service.m
//  HuiHui
//
//  Created by mac on 14-8-26.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "XMPP_service.h"

#import "CommonUtil.h"

#import "AppDelegate.h"

#import "NSDate+BBExtensions.h"

#import "App_addtion.h"

@implementation XMPP_service

+ (void) presenceGroup{
    NSXMLElement *show = [NSXMLElement elementWithName:@"show"];
    [show setStringValue:@"chat"];
    
    NSXMLElement *status = [NSXMLElement elementWithName:@"status"];
    [status setStringValue:@"hello"];
    
    NSXMLElement *iq = [NSXMLElement elementWithName:@"presence"];
    
    [iq addAttributeWithName:@"id" stringValue:IQ_ID_GROUP_PRESENCE];
    
    id ts = @([NSDate currentTimeMillis]);
    NSString *groupJid = [NSString stringWithFormat:@"%@@conference.%@",ts,@"home.cityandcity.com"];
    
    Appdelegate.HHcreateingGroupJid = nil;
    Appdelegate.HHcreateingGroupJid = groupJid;
    
    [iq addAttributeWithName:@"to" stringValue:[NSString stringWithFormat:@"%@/%@", groupJid,[CommonUtil getValueByKey:MEMBER_ID]]];
    
    [[XMPPManager sharedInstance].xmppStream sendElement:iq];
    
}

+ (void) createGroup:(NSString *) groupJid{
    
    NSXMLElement *query = [NSXMLElement elementWithName:@"query"];
    query.xmlns = @"http://jabber.org/protocol/muc#owner";
    
    NSXMLElement *iq = [NSXMLElement elementWithName:@"iq"];
    
    [iq addAttributeWithName:@"id" stringValue:IQ_ID_CREATE_GROUP];
    [iq addAttributeWithName:@"type" stringValue:@"get"];
    [iq addAttributeWithName:@"to" stringValue:groupJid];
    
    NSString *from = [NSString stringWithFormat:@"%@@%@",[CommonUtil getValueByKey:MEMBER_ID],@"home.cityandcity.com"];
    [iq addAttributeWithName:@"from" stringValue:from];
    [iq addChild:query];
    
    [[XMPPManager sharedInstance].xmppStream sendElement:iq];
    
}

+ (void) bindUsers2group:(NSString *) groupJid{
    NSXMLElement *item = [NSXMLElement elementWithName:@"item"];
    [item addAttributeWithName:@"affiliation" stringValue:@"all"];
    
    NSXMLElement *query = [NSXMLElement elementWithName:@"query"];
    query.xmlns = @"http://x.jabber.org/protocol/muc#user";
    [query addChild:item];
    
    NSXMLElement *iq = [NSXMLElement elementWithName:@"iq"];
    
    [iq addAttributeWithName:@"id" stringValue:IQ_ID_GROUP_BIND_USER];
    [iq addAttributeWithName:@"type" stringValue:@"get"];
    [iq addAttributeWithName:@"to" stringValue:groupJid];
    
    
    NSString *from = [NSString stringWithFormat:@"%@@%@",[CommonUtil getValueByKey:MEMBER_ID],@"home.cityandcity.com"];
    [iq addAttributeWithName:@"from" stringValue:from];
    [iq addChild:query];
    
    
    NSLog(@"iq444444 = %@",iq);

    
    //    AppDelegate *app = _app_;
    [[XMPPManager sharedInstance].xmppStream sendElement:iq];
}

+ (void) configGroup:(NSString *) groupJid roomName:(NSString *) roomName{
    [self configGroup:groupJid roomName:roomName iqId:IQ_ID_GROUP_CONFIG];
}

+ (void) configGroup:(NSString *) groupJid roomName:(NSString *) roomName iqId:(NSString *) iqId{
    //TODO
    NSXMLElement *query = [NSXMLElement elementWithName:@"query"];
    query.xmlns = @"http://jabber.org/protocol/muc#owner";
    {
        NSXMLElement *x = [NSXMLElement elementWithName:@"x"];
        x.xmlns = @"jabber:x:data";
        [x addAttributeWithName:@"type" stringValue:@"submit"];
        [query addChild:x];
        {
            NSDictionary *config = @{
                                     @"muc#roomconfig_roomname":         roomName,
                                     @"muc#roomconfig_roomdesc":         @"",
                                     @"muc#roomconfig_changesubject":    @"1",
                                     @"muc#roomconfig_persistentroom":   @"1",
                                     @"muc#roomconfig_membersonly":      @"1",
                                     @"x-muc#roomconfig_registration":   @"1",
                                     @"muc#roomconfig_maxusers":         @"0",
                                     };
            for (NSString *key in config) {
                NSXMLElement *field = [NSXMLElement elementWithName:@"field"];
                [field addAttributeWithName:@"var" stringValue:key];
                [x addChild:field];
                NSXMLElement *value = [NSXMLElement elementWithName:@"value"];
                [value setStringValue:config[key]];
                [field addChild:value];
            }
        }
    }
    
    
    NSXMLElement *iq = [NSXMLElement elementWithName:@"iq"];
    
    [iq addAttributeWithName:@"id" stringValue:iqId];
    [iq addAttributeWithName:@"type" stringValue:@"set"];
    [iq addAttributeWithName:@"to" stringValue:groupJid];
    
    NSString *from = [NSString stringWithFormat:@"%@@%@",[CommonUtil getValueByKey:MEMBER_ID],@"home.cityandcity.com"];
    
    [iq addAttributeWithName:@"from" stringValue:from];
    [iq addChild:query];
    
    
    NSLog(@"iq = %@",iq);
    
    //    AppDelegate *app = _app_;
    [[XMPPManager sharedInstance].xmppStream sendElement:iq];
}

+ (void) inviteUser2group:(NSString *) groupJid userId:(NSString *) userId{
    
    NSXMLElement *invite = [NSXMLElement elementWithName:@"invite"];
    
    [invite addAttributeWithName:@"to"
                     stringValue:[NSString stringWithFormat:@"%@@%@", userId,@"home.cityandcity.com"]];
    //@"Welcome"
//    NSXMLElement *reason = [NSXMLElement elementWithName:@"reason"
//                                             stringValue:@"Welcome"];
    
    NSXMLElement *reason = [NSXMLElement elementWithName:@"reason"
                                             stringValue:[NSString stringWithFormat:@"%@邀请你加入群/%@",[CommonUtil getValueByKey:NICK], Appdelegate.AllMessageOfGroup]];
    
    
//    NSXMLElement *reason = [NSXMLElement elementWithName:@"reason"
//                                             stringValue:[NSString stringWithFormat:@"%@邀请你加入群/%@",[CommonUtil getValueByKey:NICK], Appdelegate.GroupMembers]];
    
    
    [invite addChild:reason];
    
    NSXMLElement *x = [NSXMLElement elementWithName:@"x"];
    x.xmlns = @"http://jabber.org/protocol/muc#user";
    [x addChild:invite];
    
    
    NSXMLElement *message = [NSXMLElement elementWithName:@"message"];
    [message addAttributeWithName:@"to" stringValue:groupJid];
    
    NSString *from = [NSString stringWithFormat:@"%@@%@",[CommonUtil getValueByKey:MEMBER_ID],@"home.cityandcity.com"];
    [message addAttributeWithName:@"from" stringValue:from];
    [message addChild:x];
    
    [[XMPPManager sharedInstance].xmppStream sendElement:message];
}

+ (void) presenceGroupWithGroup:(DDXMLElement *) group{
    
    NSXMLElement *show = [NSXMLElement elementWithName:@"show"];
    [show setStringValue:@"chat"];
    
    NSXMLElement *status = [NSXMLElement elementWithName:@"status"];
    [status setStringValue:@"hello"];
    
    NSXMLElement *iq = [NSXMLElement elementWithName:@"presence"];
    
    [iq addAttributeWithName:@"id" stringValue:IQ_ID_GROUP_PRESENCE2];
    [iq addAttributeWithName:@"to"
                 stringValue:[NSString stringWithFormat:@"%@/%@", [group attributeStringValueForName:@"jid"],[CommonUtil getValueByKey:MEMBER_ID]]];
    
    [[XMPPManager sharedInstance].xmppStream sendElement:iq];
    
}

+ (void) getGroupUsers:(DDXMLElement *) group{
    NSXMLElement *item = [NSXMLElement elementWithName:@"item"];
    [item addAttributeWithName:@"affiliation" stringValue:@"all"];
    
    NSXMLElement *query = [NSXMLElement elementWithName:@"query"];
    query.xmlns = @"http://x.jabber.org/protocol/muc#user";
    [query addChild:item];
    
    NSXMLElement *iq = [NSXMLElement elementWithName:@"iq"];
    
    [iq addAttributeWithName:@"id" stringValue:IQ_ID_GET_GROUP_USERS];
    [iq addAttributeWithName:@"type" stringValue:@"get"];
    [iq addAttributeWithName:@"to" stringValue:[group attributeStringValueForName:@"jid"]];
    
    NSString *from = [NSString stringWithFormat:@"%@@%@",[CommonUtil getValueByKey:MEMBER_ID],@"home.cityandcity.com"];
    [iq addAttributeWithName:@"from" stringValue:from];
    [iq addChild:query];
    
    
     NSLog(@"iq5555555 = %@",iq);
    
    
    //    AppDelegate *app = _app_;
    [[XMPPManager sharedInstance].xmppStream sendElement:iq];
}

+ (void) getGroups{
    
    NSXMLElement *query = [NSXMLElement elementWithName:@"query"];
    query.xmlns = @"http://jabber.org/protocol/disco#items";
    
    NSXMLElement *iq = [NSXMLElement elementWithName:@"iq"];
    
    [iq addAttributeWithName:@"id" stringValue:IQ_ID_GET_GROUPS];
    [iq addAttributeWithName:@"type" stringValue:@"get"];
    [iq addAttributeWithName:@"to" stringValue:[NSString stringWithFormat:@"conference.%@",@"home.cityandcity.com"]];
    
    NSString *from = [NSString stringWithFormat:@"%@@%@",[CommonUtil getValueByKey:MEMBER_ID],@"home.cityandcity.com"];
    
    [iq addAttributeWithName:@"from" stringValue:from];
    [iq addChild:query];
    
    NSLog(@"Iq2222 = %@",iq);
    
    [[XMPPManager sharedInstance].xmppStream sendElement:iq];
    
}

+(void) sendLeave:(DDXMLElement *) group{
    
    NSXMLElement *query = [NSXMLElement elementWithName:@"query"];
    query.xmlns = @"http://jabber.org/protocol/muc#admin";
    {
        NSXMLElement *item = [NSXMLElement elementWithName:@"item"];
        [item addAttributeWithName:@"affiliation" stringValue:@"quit"];
        [item addAttributeWithName:@"jid" stringValue:[NSString stringWithFormat:@"%@@%@",[CommonUtil getValueByKey:MEMBER_ID],@"home.cityandcity.com"]];
        [query addChild:item];
    }
    NSXMLElement *iq = [NSXMLElement elementWithName:@"iq"];
    
    [iq addAttributeWithName:@"id" stringValue:IQ_ID_GROUP_LEAVE];
    [iq addAttributeWithName:@"type" stringValue:@"set"];
    [iq addAttributeWithName:@"to" stringValue:[group attributeStringValueForName:@"jid"]];
    
    NSString *from = [NSString stringWithFormat:@"%@@%@",[CommonUtil getValueByKey:MEMBER_ID],@"home.cityandcity.com"];
    [iq addAttributeWithName:@"from" stringValue:from];
    [iq addChild:query];
    
    NSLog(@"to = %@,from = %@",[group attributeStringValueForName:@"jid"],from);
    
    NSLog(@"iq343434 = %@",iq);
    
    [[XMPPManager sharedInstance].xmppStream sendElement:iq];

}


+(void) sendDismiss:(DDXMLElement *) group{
    NSXMLElement *query = [NSXMLElement elementWithName:@"query"];
    query.xmlns = @"http://jabber.org/protocol/muc#owner";
    {
        NSXMLElement *destroy = [NSXMLElement elementWithName:@"destroy"];
        {
            NSXMLElement *reason = [NSXMLElement elementWithName:@"reason"];
            [destroy addChild:reason];
        }
        [query addChild:destroy];
    }
    NSXMLElement *iq = [NSXMLElement elementWithName:@"iq"];
    
    [iq addAttributeWithName:@"id" stringValue:IQ_ID_GROUP_DISMISS];
    [iq addAttributeWithName:@"type" stringValue:@"set"];
    [iq addAttributeWithName:@"to" stringValue:[group attributeStringValueForName:@"jid"]];
    
    NSString *from = [NSString stringWithFormat:@"%@@%@",[CommonUtil getValueByKey:MEMBER_ID],@"home.cityandcity.com"];
    [iq addAttributeWithName:@"from" stringValue:from];
    [iq addChild:query];
    
    [[XMPPManager sharedInstance].xmppStream sendElement:iq];
}

+(void) kickUserInGroup:(DDXMLElement *) group userId:(int) userId{
    NSXMLElement *query = [NSXMLElement elementWithName:@"query"];
    query.xmlns = @"http://jabber.org/protocol/muc#admin";
    {
        NSXMLElement *item = [NSXMLElement elementWithName:@"item"];
        [item addAttributeWithName:@"affiliation" stringValue:@"none"];
        [item addAttributeWithName:@"jid" stringValue:[NSString stringWithFormat:@"%@@%@",[CommonUtil getValueByKey:MEMBER_ID],@"home.cityandcity.com"]];
        [query addChild:item];
    }
    NSXMLElement *iq = [NSXMLElement elementWithName:@"iq"];
    
    [iq addAttributeWithName:@"id" stringValue:IQ_ID_GROUP_KICK_USER];
    [iq addAttributeWithName:@"type" stringValue:@"set"];
    [iq addAttributeWithName:@"to" stringValue:[group attributeStringValueForName:@"jid"]];
    
    NSString *from = [NSString stringWithFormat:@"%@@%@",[CommonUtil getValueByKey:MEMBER_ID],@"home.cityandcity.com"];
    [iq addAttributeWithName:@"from" stringValue:from];
    [iq addChild:query];
    
   [[XMPPManager sharedInstance].xmppStream sendElement:iq];
    
    {
        NSXMLElement *headers = [NSXMLElement elementWithName:@"headers"];
        headers.xmlns = @"http://jabber.org/protocol/shim";
        {
            NSXMLElement *header = [NSXMLElement elementWithName:@"header"];
            [header addAttributeWithName:@"name" stringValue:@"CustomMsgType"];
            header.stringValue = @"WorkGroupDelMember";
            [headers addChild:header];
        }
        {
            NSXMLElement *header = [NSXMLElement elementWithName:@"header"];
            [header addAttributeWithName:@"name" stringValue:@"CustomMsgValue"];
            header.stringValue = [NSString stringWithFormat:@"%@@%@",[CommonUtil getValueByKey:MEMBER_ID],@"home.cityandcity.com"];
            [headers addChild:header];
        }
        NSXMLElement *message = [NSXMLElement elementWithName:@"message"];
        
        [message addAttributeWithName:@"type" stringValue:@"groupchat"];
        [message addAttributeWithName:@"to" stringValue:[group attributeStringValueForName:@"jid"]];
        [message addChild:headers];
        
       [[XMPPManager sharedInstance].xmppStream sendElement:iq];
    
    }
}


@end
