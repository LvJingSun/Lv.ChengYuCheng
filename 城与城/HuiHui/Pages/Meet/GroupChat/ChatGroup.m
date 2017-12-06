#import "ChatGroup.h"

#import "Configuration.h"

#import "CommonUtil.h"

#import "XMPPManager.h"

#import "XMPP_service.h"

@implementation ChatGroup

+(BOOL) nameExist:(NSString *) name{
   
    for (ChatGroup *each in Appdelegate.gChatGroups) {
      
        if ([each.getName isEqualToString:name]) {
            return YES;
        }
    }
    return NO;
}

- (NSString *) getName{
    return [self.data attributeStringValueForName:@"name"];
}

- (void) changeName:(NSString *) freshName{
    
    if([[self getName] isEqualToString:freshName]){
        return;
    }
    DDXMLElement *el = self.data;
    [el addAttributeWithName:@"name" stringValue:freshName];
   
    NSLog(@"self.groupId = %@,freshName = %@",self.groupId,freshName);
    
    [XMPP_service configGroup:self.groupId roomName:freshName iqId:IQ_ID_GROUP_CONFIG_CHANGE_NAME];
}

- (BOOL) isSelfOwner{
    
    NSLog(@"self.members = %@",self.members);
    
    for (DDXMLElement *each in self.members) {
    
        NSLog(@"each %@",[each attributeStringValueForName:@"jid"]);
        
        NSString *affiliation = [each attributeStringValueForName:@"affiliation"];
        if ([@"owner" isEqualToString:affiliation]) {
            NSString *jid = [each attributeStringValueForName:@"jid"];
            NSString *userId = [jid componentsSeparatedByString:@"@"][0];
            if([[CommonUtil getValueByKey:MEMBER_ID] isEqualToString:userId] ){
                return YES;
            }
            return NO;
        }
    }
    return NO;
}

-(BOOL) removeMember:(NSString *) userId{
    
    NSLog(@"self.members = %@",self.members);
    
    for (DDXMLElement *each in self.members) {
        NSString *jid = [each attributeStringValueForName:@"jid"];
        
//        NSLog(@"each = %@",each);
//        
//        NSLog(@"userId = %@",userId);
//        
//        [self.members removeObject:each];

        
        NSString *eachUserId = [jid componentsSeparatedByString:@"@"][0];
        
        if ([eachUserId isEqualToString:userId]) {
            [self.members removeObject:each];
            return YES;
        }
    }
    return NO;
}

-(NSString *) groupId{
    return [self.data attributeStringValueForName:@"jid"];
}

-(NSString *) groupIdMain{
    NSString *groupId = [self groupId];
    return [groupId componentsSeparatedByString:@"@"][0];
}

-(void)dealloc{
    self.data = nil;
    self.members = nil;
    [super dealloc];
}

@end
