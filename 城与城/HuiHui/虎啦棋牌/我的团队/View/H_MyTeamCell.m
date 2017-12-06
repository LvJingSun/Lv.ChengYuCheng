//
//  H_MyTeamCell.m
//  HuiHui
//
//  Created by mac on 2017/11/3.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "H_MyTeamCell.h"
#import "LJConst.h"
#import "H_MyTeamModel.h"
#import "H_MyTeamFrame.h"

@interface H_MyTeamCell ()

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *levelLab;

@property (nonatomic, weak) UILabel *delegateLab;

@property (nonatomic, weak) UILabel *memberLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation H_MyTeamCell

+ (instancetype)H_MyTeamCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"H_MyTeamCell";
    
    H_MyTeamCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[H_MyTeamCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *name = [[UILabel alloc] init];
        
        self.nameLab = name;
        
        name.textColor = [UIColor darkTextColor];
        
        name.textAlignment = NSTextAlignmentCenter;
        
        name.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:name];
        
        UILabel *level = [[UILabel alloc] init];
        
        self.levelLab = level;
        
        level.textColor = [UIColor darkTextColor];
        
        level.textAlignment = NSTextAlignmentCenter;
        
        level.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:level];
        
        UILabel *delegate = [[UILabel alloc] init];
        
        self.delegateLab = delegate;
        
        delegate.textColor = [UIColor darkTextColor];
        
        delegate.textAlignment = NSTextAlignmentCenter;
        
        delegate.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:delegate];
        
        UILabel *member = [[UILabel alloc] init];
        
        self.memberLab = member;
        
        member.textColor = [UIColor darkTextColor];
        
        member.textAlignment = NSTextAlignmentCenter;
        
        member.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:member];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(H_MyTeamFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.nameLab.frame = self.frameModel.nameF;
    
    self.delegateLab.frame = self.frameModel.delegateF;
    
    self.levelLab.frame = self.frameModel.levelF;
    
    self.memberLab.frame = self.frameModel.memberF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {
    
    H_MyTeamModel *model = self.frameModel.model;
    
    self.nameLab.text = model.name;
    
    self.levelLab.text = model.level;
    
    self.delegateLab.text = model.delegateCount;
    
    self.memberLab.text = model.memberCount;
    
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
