/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import <Foundation/Foundation.h>

#define KFIRETIME 20

@interface MessageModel : NSObject
{
    BOOL _isPlaying;
}

@property (nonatomic) MessageBodyType type;
@property (nonatomic) MessageDeliveryState status;

@property (nonatomic) BOOL isSender;    //是否是发送者
@property (nonatomic) BOOL isRead;      //是否已读
@property (nonatomic) BOOL isChatGroup;  //是否是群聊

@property (nonatomic, strong) NSString *messageId;
@property (nonatomic, strong) NSURL *headImageURL;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *username;


/*
//////////////////////////////////////////////////
//自定义
 */

//1、产品或链接用的一个实例；
@property (nonatomic, strong) NSString *m_type;
@property (nonatomic, strong) NSString *PROphotoURl;
@property (nonatomic, strong) NSString *PROtitle;
@property (nonatomic, strong) NSString *Sharestring;

@property (nonatomic, strong) NSString *m_FromDPId;
@property (nonatomic, strong) NSString *m_productId;
@property (nonatomic, strong) NSString *m_merchantShopId;

//2、活动
@property (nonatomic, strong) NSURL *ACTphotoURl;
@property (nonatomic, strong) NSString *ACTtitle;

//3、代理商（售后服务：评分系统）
@property (nonatomic, strong) NSString *Dalititle;
@property (nonatomic, strong) NSString *Dalicontent;
@property (nonatomic, strong) NSString *Daliopinion;//不满意时的 意见
@property (nonatomic, strong) NSString *DaliserviceId;

//4、菜单下单成功的订单提示
@property (nonatomic, strong) NSString *m_menuTime;
@property (nonatomic, strong) NSString *m_menuPhone;
@property (nonatomic, strong) NSString *m_menuName;
@property (nonatomic, strong) NSString *m_menuTitle;

@property (nonatomic, strong) NSString *isWaimai;
@property (nonatomic, strong) NSString *isMact;
@property (nonatomic, strong) NSString *m_shopPhone;
@property (nonatomic, strong) NSString *m_linkName;
@property (nonatomic, strong) NSString *m_orderNO;



/*
 //////////////////////////////////////////////////
 //自定义
 */


//text
@property (nonatomic, strong) NSString *content;

//image
@property (nonatomic) CGSize size;
@property (nonatomic) CGSize thumbnailSize;
@property (nonatomic, strong) NSURL *imageRemoteURL;
@property (nonatomic, strong) NSURL *thumbnailRemoteURL;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *thumbnailImage;

//audio
@property (nonatomic, strong) NSString *localPath;
@property (nonatomic, strong) NSString *remotePath;
@property (nonatomic) NSInteger time;
@property (nonatomic, strong) EMChatVoice *chatVoice;
@property (nonatomic) BOOL isPlaying;
@property (nonatomic) BOOL isPlayed;

//location
@property (nonatomic, strong) NSString *address;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@property (nonatomic, strong)id<IEMMessageBody> messageBody;
@property (nonatomic, strong)EMMessage *message;

@end
