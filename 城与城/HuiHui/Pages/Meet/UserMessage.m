//
//  UserMessage.m
//  HuiHui
//
//  Created by mac on 14-1-24.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "UserMessage.h"

@implementation UserMessage

@end


@implementation Userinfo

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userID forKey:@"userID"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.userAge forKey:@"userAge"];
    [aCoder encodeObject:self.userSex forKey:@"userSex"];
    [aCoder encodeObject:self.userImageURL forKey:@"userImageURL"];
    [aCoder encodeObject:self.userSign forKey:@"userSign"];
    [aCoder encodeObject:self.userSign forKey:@"userType"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.userID =[aDecoder decodeObjectForKey:@"userID"];
    self.userName =[aDecoder decodeObjectForKey:@"userName"];
    self.userAge =[aDecoder decodeObjectForKey:@"userAge"];
    self.userSex =[aDecoder decodeObjectForKey:@"userSex"];
    self.userImageURL =[aDecoder decodeObjectForKey:@"userImageURL"];
    self.userSign =[aDecoder decodeObjectForKey:@"userSign"];
    self.userID =[aDecoder decodeObjectForKey:@"userID"];
    
    NSString*friendslistFile=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),self.userImageURL];
    self.userImage=[UIImage imageWithContentsOfFile:friendslistFile];
    
    
    return self;
    
}


@end