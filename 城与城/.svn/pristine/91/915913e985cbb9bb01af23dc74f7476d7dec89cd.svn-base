//
//  CtriphoteldetailViewController.h
//  HuiHui
//
//  Created by 冯海强 on 14-9-16.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"
#import "TableViewWithBlock.h"
#import "Ctrip_hotelPlaceorderViewController.h"
#import "Ctrip_hotelorderdetailViewController.h"


@class TableViewWithBlock;

@interface CtriphoteldetailViewController : BaseViewController<Ctrip_hotelorderdelegate>
{
    int indexRow;//检测房间是否可预订，房间列表数组的下标，
    
    BOOL Pushdingdan;//预订成功 代理返回后 push订单界面
    
    BOOL RequestFin;//房间请求结束；不管有没有房间 隐藏Activing控件；
}


@property (nonatomic,strong) NSMutableDictionary * Ctriphotel_detailheadD;//列表传过来的酒店名之类；

//@property (nonatomic, strong) NSString *StartTimeANDendTime;//例：今天 入住1晚

@property (strong, nonatomic) IBOutlet UIView *m_showViewRoom;//显示房间的大视图
@property (strong, nonatomic) IBOutlet UIView *m_showDetailRoom;//显示房间的详情
@property (strong, nonatomic) IBOutlet UIControl *m_showUIControl;//显示房间图层




@property (nonatomic,strong) IBOutlet TableViewWithBlock * DetailRoomTableview;//房间详情
@property (nonatomic, weak) IBOutlet UILabel *m_showRoomName;//显示房间名称
@property (nonatomic, strong) IBOutlet UIImageView *m_showRoomImg;//显示房间图片
@property (nonatomic, weak) IBOutlet UILabel *m_showRoomPrice;//显示房间价钱
@property (nonatomic, weak) IBOutlet UIButton *CheckRoomAvai;//预订按钮


@property (strong, nonatomic)  NSMutableDictionary *Ctrip_hotelInfomation;////入住信息的存储；

@end
