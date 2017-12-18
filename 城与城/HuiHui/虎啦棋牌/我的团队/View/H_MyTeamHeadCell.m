//
//  H_MyTeamHeadCell.m
//  HuiHui
//
//  Created by mac on 2017/11/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "H_MyTeamHeadCell.h"
#import "LJConst.h"
#import "H_MyTeamHeadModel.h"
#import "H_MyTeamHeadFrame.h"
#import "H_MyTeamCountView.h"

@interface H_MyTeamHeadCell ()

@property (nonatomic, weak) H_MyTeamCountView *oneView;

@property (nonatomic, weak) H_MyTeamCountView *twoView;

@property (nonatomic, weak) H_MyTeamCountView *threeView;

@property (nonatomic, weak) H_MyTeamCountView *fourView;

@property (nonatomic, weak) UILabel *huiyuanmingLab;

@property (nonatomic, weak) UILabel *jibieLab;

@property (nonatomic, weak) UILabel *renshuLab;

@property (nonatomic, weak) UILabel *shouyiLab;

@end

@implementation H_MyTeamHeadCell

+ (instancetype)H_MyTeamHeadCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"H_MyTeamHeadCell";
    
    H_MyTeamHeadCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[H_MyTeamHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = FSB_ViewBGCOLOR;
        
        UILabel *name = [[UILabel alloc] init];
        
        self.huiyuanmingLab = name;
        
        name.textColor = [UIColor whiteColor];
        
        name.backgroundColor = FSB_StyleCOLOR;
        
        name.textAlignment = NSTextAlignmentCenter;
        
        name.font = [UIFont systemFontOfSize:17];
        
        name.text = @"会员名";
        
        [self addSubview:name];
        
        UILabel *level = [[UILabel alloc] init];
        
        self.jibieLab = level;
        
        level.text = @"代理级别";
        
        level.textColor = [UIColor whiteColor];
        
        level.backgroundColor = FSB_StyleCOLOR;
        
        level.textAlignment = NSTextAlignmentCenter;
        
        level.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:level];
        
        UILabel *delegate = [[UILabel alloc] init];
        
        self.renshuLab = delegate;
        
        delegate.text = @"代理人数";
        
        delegate.textColor = [UIColor whiteColor];
        
        delegate.backgroundColor = FSB_StyleCOLOR;
        
        delegate.textAlignment = NSTextAlignmentCenter;
        
        delegate.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:delegate];
        
        UILabel *member = [[UILabel alloc] init];
        
        self.shouyiLab = member;
        
        member.text = @"总收益";
        
        member.textColor = [UIColor whiteColor];
        
        member.backgroundColor = FSB_StyleCOLOR;
        
        member.textAlignment = NSTextAlignmentCenter;
        
        member.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:member];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(H_MyTeamHeadFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    H_MyTeamCountView *view1 = [[H_MyTeamCountView alloc] initWithFrame:self.frameModel.OneF];
    
    self.oneView = view1;
    
    [self addSubview:view1];
    
    H_MyTeamCountView *view2 = [[H_MyTeamCountView alloc] initWithFrame:self.frameModel.TwoF];
    
    self.twoView = view2;
    
    [self addSubview:view2];
    
    H_MyTeamCountView *view3 = [[H_MyTeamCountView alloc] initWithFrame:self.frameModel.ThreeF];
    
    self.threeView = view3;
    
    [self addSubview:view3];
    
    H_MyTeamCountView *view4 = [[H_MyTeamCountView alloc] initWithFrame:self.frameModel.FourF];
    
    self.fourView = view4;
    
    [self addSubview:view4];
    
    self.huiyuanmingLab.frame = self.frameModel.huiyuanmingF;
    
    self.jibieLab.frame = self.frameModel.jibieF;
    
    self.renshuLab.frame = self.frameModel.renshuF;
    
    self.shouyiLab.frame = self.frameModel.shouyiF;
    
}

- (void)setContent {
    
    H_MyTeamHeadModel *model = self.frameModel.headModel;
    
    self.oneView.title = model.title1;
    
    self.oneView.content = [NSString stringWithFormat:@"%@人",model.content1];
    
    self.twoView.title = model.title2;
    
    self.twoView.content = [NSString stringWithFormat:@"%@人",model.content2];
    
    self.threeView.title = model.title3;
    
    self.threeView.content = [NSString stringWithFormat:@"%@人",model.content3];
    
    self.fourView.title = model.title4;
    
    self.fourView.content = [NSString stringWithFormat:@"%@人",model.content4];
    
}

- (void)awakeFromNib {
    
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

}

@end
