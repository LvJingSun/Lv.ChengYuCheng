//
//  PartyDetailCell.h
//  HuiHui
//
//  Created by mac on 14-10-21.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CXAHyperlinkLabel.h"

@interface PartyDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_detailLabel;

@property (weak, nonatomic) IBOutlet UIView *m_photoView;

@property (weak, nonatomic) IBOutlet UIView *m_addressView;

@property (weak, nonatomic) IBOutlet UILabel *m_addressLabel;

@property (weak, nonatomic) IBOutlet UIView *m_view;

@property (nonatomic, strong) NSMutableArray *m_imageList;


- (void)setDetail:(NSString *)detail withPhoto:(NSMutableArray *)array withAddress:(NSString *)address;

@end


@protocol ZanDelegate <NSObject>

- (void)zanNameClicked:(NSString *)aString;

@end

@interface ZanCell : UITableViewCell{
    
    
    CXAHyperlinkLabel *zan_label;

}

@property (weak, nonatomic) IBOutlet UIButton   *m_zanBtn;

@property (weak, nonatomic) IBOutlet UIView     *m_zanView;

@property (nonatomic, assign) id <ZanDelegate>   delegate;

@property (weak, nonatomic) IBOutlet UIImageView *m_arrowImagV;


// 设置赞的字体的颜色及标题
- (void)setZanTitle:(NSString *)string withCount:(NSString *)aCount withZanArray:(NSMutableArray *)zanArray;

- (NSAttributedString *)attributedString:(NSArray *__autoreleasing *)outURLs
                               URLRanges:(NSArray *__autoreleasing *)outURLRanges
                           nicknamearray:(NSMutableArray *)array;

@end
