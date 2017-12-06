//
//  Ctrip_hotelPlaceorderViewController.h
//  HuiHui
//
//  Created by 冯海强 on 15-1-4.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"
#import "ZHPickView.h"
@protocol Ctrip_hotelorderdelegate <NSObject>

- (void)Ctrip_hotelorderdelegate;//订单成功返回

@end


@interface Ctrip_hotelPlaceorderViewController : BaseViewController<ZHPickViewDelegate>

@property (unsafe_unretained,nonatomic)id<Ctrip_hotelorderdelegate>hotelorderdelegate;

@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)ZHPickView *RoomNumpickview;
@property(nonatomic,strong)ZHPickView *TimeINpickview;
@property (weak, nonatomic) IBOutlet UITableView *Ctrip_POtableview;

@property (weak, nonatomic) IBOutlet UILabel *Ctrip_HotelName;
@property (weak, nonatomic) IBOutlet UILabel *Ctrip_RoomName;
@property (weak, nonatomic) IBOutlet UILabel *Ctrip_TimeName;
@property (weak, nonatomic) IBOutlet UIView *Ctrip_Headview;//headview

@property (weak, nonatomic) IBOutlet UILabel *Ctrip_ALLListPrice;//总价钱

@property (weak, nonatomic) IBOutlet UIView *PO_alphaView;//透明层

@property (strong, nonatomic)  NSMutableDictionary *Ctrip_hotelInfomation;////入住信息的存储；

@end
