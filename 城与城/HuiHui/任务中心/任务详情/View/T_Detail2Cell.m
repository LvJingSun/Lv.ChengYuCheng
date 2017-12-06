//
//  T_Detail2Cell.m
//  HuiHui
//
//  Created by mac on 2017/3/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "T_Detail2Cell.h"
#import "T_Detail2Frame.h"
//#import "T_TaskMember.h"

#import "TH_TaskMemberModel.h"
#import "UIImageView+AFNetworking.h"

#define NameColor [UIColor colorWithRed:23/255. green:44/255. blue:56/255. alpha:1.]
#define YiWanChengColor [UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.0]
#define JinXingZhongColor [UIColor colorWithRed:69/255. green:191/255. blue:89/255. alpha:1.]
#define JuJueColor [UIColor colorWithRed:254/255. green:73/255. blue:63/255. alpha:1.]
#define CountColor [UIColor colorWithRed:255/255. green:100/255. blue:0/255. alpha:1.]

@interface T_Detail2Cell ()

@property (nonatomic, weak) UIImageView *iconImageview;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *statusLab;

@property (nonatomic, weak) UILabel *countLab;

@end

@implementation T_Detail2Cell

+ (instancetype)T_Detail2CellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"T_Detail2Cell";
    
    T_Detail2Cell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[T_Detail2Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *icon = [[UIImageView alloc] init];
        
        self.iconImageview = icon;
        
        [self addSubview:icon];
        
        UILabel *name = [[UILabel alloc] init];
        
        self.nameLab = name;
        
        name.textColor = NameColor;
        
        name.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:name];
        
        UILabel *status = [[UILabel alloc] init];
        
        self.statusLab = status;
        
        status.font = [UIFont systemFontOfSize:16];
        
        status.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:status];
        
        UILabel *count = [[UILabel alloc] init];
        
        self.countLab = count;
        
        count.font = [UIFont systemFontOfSize:20];
        
        count.textColor = CountColor;
        
        self.countLab.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:count];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(T_Detail2Frame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.iconImageview.frame = self.frameModel.iconF;
    
    self.iconImageview.layer.masksToBounds = YES;
    
    self.iconImageview.layer.cornerRadius = self.frameModel.iconF.size.width * 0.5;
    
    self.nameLab.frame = self.frameModel.nameF;
    
    self.statusLab.frame = self.frameModel.statusF;
    
    self.countLab.frame = self.frameModel.countF;
    
}

- (void)setContent {

    TH_TaskMemberModel *member = self.frameModel.th_memberModel;
    
    [self.iconImageview setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",member.MemPhoto]] placeholderImage:[UIImage imageNamed:@"timg.jpeg"]];
    
    self.nameLab.text = [NSString stringWithFormat:@"%@",member.MemName];
    
    if ([member.WhetherComplete isEqualToString:@"已完成"]) {
        
        self.statusLab.textColor = YiWanChengColor;
        
        self.statusLab.text = [NSString stringWithFormat:@"%@",member.WhetherComplete];
        
        self.countLab.text = [NSString stringWithFormat:@"+%@",member.TaskBonuses];
        
    }else if ([member.WhetherComplete isEqualToString:@"进行中"]) {
    
        self.statusLab.textColor = JinXingZhongColor;
        
        self.statusLab.text = [NSString stringWithFormat:@"%@",member.WhetherComplete];
        
    }else if ([member.WhetherToAccept isEqualToString:@"已拒绝"]) {
        
        self.statusLab.textColor = JuJueColor;
        
        self.statusLab.text = [NSString stringWithFormat:@"%@",member.WhetherToAccept];
        
    }
    
}

- (void)awakeFromNib {
    
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
