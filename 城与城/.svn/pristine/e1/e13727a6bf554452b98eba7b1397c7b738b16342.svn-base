//
//  HomeCell.h
//  HuiHui
//
//  Created by mac on 14-7-28.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GrayPageControl.h"

#import "ImageCache.h"

@interface HomeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *m_btn1;

@property (weak, nonatomic) IBOutlet UIButton *m_btn2;

@property (weak, nonatomic) IBOutlet UIImageView *m_imagV1;

@property (weak, nonatomic) IBOutlet UIImageView *m_imagV2;

@property (weak, nonatomic) ImageCache *imageCache;


- (void)setImageView:(NSDictionary *)dic;

@end


@protocol AdvDelegate <NSObject>

- (void)imageClicked:(id)sender;

@end

@interface HomeAdvCell : UITableViewCell<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@property (nonatomic, strong) GrayPageControl *m_pageControl;

@property (nonatomic, assign) id<AdvDelegate>delegate;

- (void)setImage:(NSMutableArray *)aInfoList;

@end



@protocol CategoryTypeDelegate <NSObject>

- (void)btnClicked:(id)sender;

@end

@interface CategoryCell : UITableViewCell<UIScrollViewDelegate>

@property (nonatomic, assign) id<CategoryTypeDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIButton *m_vipBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_diandanBtn;


@property (weak, nonatomic) IBOutlet UIButton *m_btn1;
@property (weak, nonatomic) IBOutlet UIButton *m_btn2;
@property (weak, nonatomic) IBOutlet UIButton *m_btn3;
@property (weak, nonatomic) IBOutlet UIButton *m_btn4;
@property (weak, nonatomic) IBOutlet UIButton *m_btn5;
@property (weak, nonatomic) IBOutlet UILabel *m_label1;
@property (weak, nonatomic) IBOutlet UILabel *m_label2;
@property (weak, nonatomic) IBOutlet UILabel *m_label3;
@property (weak, nonatomic) IBOutlet UILabel *m_label4;
@property (weak, nonatomic) IBOutlet UILabel *m_label5;
@property (weak, nonatomic) IBOutlet UIImageView *m_imagV1;
@property (weak, nonatomic) IBOutlet UIImageView *m_imagV2;
@property (weak, nonatomic) IBOutlet UIImageView *m_imagV3;
@property (weak, nonatomic) IBOutlet UIImageView *m_imagV4;
@property (weak, nonatomic) IBOutlet UIImageView *m_imagV5;

@property (weak, nonatomic) IBOutlet UIButton *m_btn6;
@property (weak, nonatomic) IBOutlet UIButton *m_btn7;
@property (weak, nonatomic) IBOutlet UIButton *m_btn8;
@property (weak, nonatomic) IBOutlet UIButton *m_btn9;
@property (weak, nonatomic) IBOutlet UIButton *m_btn10;
@property (weak, nonatomic) IBOutlet UILabel *m_label6;
@property (weak, nonatomic) IBOutlet UILabel *m_label7;
@property (weak, nonatomic) IBOutlet UILabel *m_label8;
@property (weak, nonatomic) IBOutlet UILabel *m_label9;
@property (weak, nonatomic) IBOutlet UILabel *m_label10;
@property (weak, nonatomic) IBOutlet UIImageView *m_imagV6;
@property (weak, nonatomic) IBOutlet UIImageView *m_imagV7;
@property (weak, nonatomic) IBOutlet UIImageView *m_imagV8;
@property (weak, nonatomic) IBOutlet UIImageView *m_imagV9;
@property (weak, nonatomic) IBOutlet UIImageView *m_imagV10;

@property (weak, nonatomic) ImageCache *imageCache;



//- (void)setBtnImage:(NSMutableArray *)array;



@end

@interface HHFlightsHotelCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *m_flightsBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_hotelBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_merchantBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_brandBtn;

@property (weak, nonatomic) IBOutlet UIView *m_hotelView;

@property (weak, nonatomic) IBOutlet UIView *m_flightView;

@property (weak, nonatomic) IBOutlet UIView *m_quanquanView;

@property (weak, nonatomic) IBOutlet UIView *m_scneryView;

@property (weak, nonatomic) IBOutlet UIView *m_hotel1view;

@property (weak, nonatomic) IBOutlet UIView *m_cardView;

@property (weak, nonatomic) IBOutlet UIButton *m_hotel1Btn;

@property (weak, nonatomic) IBOutlet UIButton *m_cardBtn;


@end
