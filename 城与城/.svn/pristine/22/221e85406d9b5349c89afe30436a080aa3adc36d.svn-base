//
//  CommentDetailCell.h
//  HuiHui
//
//  Created by mac on 14-10-23.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentDelegate <NSObject>

- (void)partyCommentClicked:(NSDictionary *)dic;

@end

@interface CommentDetailCell : UITableViewCell

@property (nonatomic, assign) id<CommentDelegate>delegate;

@property (nonatomic, strong) NSMutableArray  *m_commentArray;

- (void)getCommentView:(NSMutableArray *)array;

@end

@interface CommentDetailView : UIView

@property (nonatomic, strong) UILabel       *m_nameLabel;

@property (nonatomic, strong) UILabel       *m_timeLabel;

@property (nonatomic, strong) UILabel       *m_content;

@property (nonatomic, strong) UIButton      *m_btn;



@end
