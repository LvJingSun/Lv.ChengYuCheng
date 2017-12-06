//
//  H_TuiJianCell.m
//  HuiHui
//
//  Created by mac on 2017/11/3.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "H_TuiJianCell.h"
#import "H_TuiJianModel.h"
#import "H_TuiJianFrame.h"
#import "LJConst.h"

@interface H_TuiJianCell ()

@property (nonatomic, weak) UIImageView *urlImg;

@property (nonatomic, weak) UIButton *shareBtn;

@property (nonatomic, weak) UIButton *copybtn;

@property (nonatomic, weak) UIButton *emailBtn;

@end

@implementation H_TuiJianCell

+ (instancetype)H_TuiJianCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"H_TuiJianCell";
    
    H_TuiJianCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[H_TuiJianCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = FSB_ViewBGCOLOR;
        
        UIImageView *urlimg = [[UIImageView alloc] init];
        
        self.urlImg = urlimg;
        
        [self addSubview:urlimg];
        
        UIButton *share = [[UIButton alloc] init];
        
        self.shareBtn = share;
        
        share.backgroundColor = FSB_StyleCOLOR;
        
        share.layer.masksToBounds = YES;
        
        share.layer.cornerRadius = 5;
        
        [self addSubview:share];
        
        UIButton *copy = [[UIButton alloc] init];
        
        self.copybtn = copy;
        
        copy.backgroundColor = FSB_StyleCOLOR;
        
        copy.layer.masksToBounds = YES;
        
        copy.layer.cornerRadius = 5;
        
        [self addSubview:copy];
        
        UIButton *email = [[UIButton alloc] init];
        
        self.emailBtn = email;
        
        email.backgroundColor = FSB_StyleCOLOR;
        
        email.layer.masksToBounds = YES;
        
        email.layer.cornerRadius = 5;
        
        [self addSubview:email];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(H_TuiJianFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.urlImg.frame = self.frameModel.imgF;
    
    self.shareBtn.frame = self.frameModel.shareF;
    
    self.copybtn.frame = self.frameModel.copyF;
    
    self.emailBtn.frame = self.frameModel.emailF;
    
}

- (void)setContent {
    
    H_TuiJianModel *model = self.frameModel.model;
    
    [self.urlImg setImageWithURL:[NSURL URLWithString:model.urlImg]];
    
    [self.shareBtn setTitle:@"将邀请码分享给好友" forState:0];
    
    [self.shareBtn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.copybtn setTitle:@"复制二维码链接" forState:0];
    
    [self.copybtn addTarget:self action:@selector(copyClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.emailBtn setTitle:@"给好友发短信" forState:0];
    
    [self.emailBtn addTarget:self action:@selector(mailClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)shareClick {
    
    if (self.shareBlock) {
        
        self.shareBlock();
        
    }
    
}

- (void)copyClick {
    
    if (self.copyBlock) {
        
        self.copyBlock();
        
    }
    
}

- (void)mailClick {
    
    if (self.mailBlock) {
        
        self.mailBlock();
        
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
