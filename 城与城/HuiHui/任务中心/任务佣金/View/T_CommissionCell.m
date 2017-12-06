//
//  T_CommissionCell.m
//  HuiHui
//
//  Created by mac on 2017/3/28.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "T_CommissionCell.h"
#import "T_CommissionFrame.h"
#import "T_NewTask.h"

#define NameColor [UIColor colorWithRed:23/255. green:44/255. blue:56/255. alpha:1.]
#define NameFont [UIFont systemFontOfSize:22]
#define DescColor [UIColor colorWithRed:163/255. green:163/255. blue:163/255. alpha:1.]
#define DescFont [UIFont systemFontOfSize:15]
#define BlueTextCOLOR [UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.0]
#define BoderColor [UIColor colorWithRed:255/255. green:100/255. blue:0/255. alpha:1.]

@interface T_CommissionCell ()

@property (nonatomic, weak) UIView *boderView;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *descLab;

@property (nonatomic, weak) UILabel *biaotiLab;

@property (nonatomic, weak) UITextField *countField;

@property (nonatomic, weak) UILabel *countLineLab;

@property (nonatomic, weak) UILabel *starLab;

@property (nonatomic, weak) UILabel *StarDescLab;

@property (nonatomic, weak) UILabel *rightLab;

@end

@implementation T_CommissionCell

+ (instancetype)T_CommissionCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"T_CommissionCell";
    
    T_CommissionCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[T_CommissionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *view = [[UIView alloc] init];
        
        self.boderView = view;
        
        [self addSubview:view];
        
        UILabel *name = [[UILabel alloc] init];
        
        self.nameLab = name;
        
        name.textColor = NameColor;
        
        name.font = NameFont;
        
        [self addSubview:name];
        
        UILabel *desc = [[UILabel alloc] init];
        
        self.descLab = desc;
        
        desc.textColor = DescColor;
        
        desc.font = DescFont;
        
        desc.numberOfLines = 0;
        
        [self addSubview:desc];
        
        UILabel *biaoti = [[UILabel alloc] init];
        
        self.biaotiLab = biaoti;
        
        biaoti.textColor = NameColor;
        
        biaoti.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:biaoti];
        
        UITextField *field = [[UITextField alloc] init];
        
        self.countField = field;
        
        field.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:field];
        
        UILabel *countline = [[UILabel alloc] init];
        
        self.countLineLab = countline;
        
        countline.backgroundColor = BlueTextCOLOR;
        
        [self addSubview:countline];
        
        UILabel *star = [[UILabel alloc] init];
        
        self.starLab = star;
        
        star.textColor = BoderColor;
        
        star.font = [UIFont systemFontOfSize:18];
        
        [self addSubview:star];
        
        UILabel *starDesc = [[UILabel alloc] init];
        
        self.StarDescLab = starDesc;
        
        starDesc.textColor = [UIColor lightGrayColor];
        
        starDesc.font = [UIFont systemFontOfSize:14];
        
        starDesc.numberOfLines = 0;
        
        [self addSubview:starDesc];
        
        UILabel *rightlab = [[UILabel alloc] init];
        
        self.rightLab = rightlab;
        
        rightlab.textColor = NameColor;
        
        rightlab.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:rightlab];
        
    }
    
    return self;
    
}

- (void)setFrameModel:(T_CommissionFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.nameLab.frame = self.frameModel.nameF;
    
    self.descLab.frame = self.frameModel.descF;
    
    self.boderView.frame = self.frameModel.borderF;
    
    self.boderView.layer.masksToBounds = YES;
    
    self.boderView.layer.cornerRadius = 5;
    
    self.boderView.layer.borderWidth = 1;
    
    self.boderView.layer.borderColor = BoderColor.CGColor;
    
    self.biaotiLab.frame = self.frameModel.biaotiF;
    
    self.countField.frame = self.frameModel.countF;
    
    self.countLineLab.frame = self.frameModel.countLineF;
    
    self.starLab.frame = self.frameModel.starF;
    
    self.StarDescLab.frame = self.frameModel.starDescF;
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

- (void)setContent {

    T_NewTask *task = self.frameModel.taskModel;
    
    self.nameLab.text = [NSString stringWithFormat:@"%@",task.TaskName];
    
    self.descLab.text = [NSString stringWithFormat:@"%@",task.TaskDescription];
    
    self.biaotiLab.text = @"任务佣金:";
    
    self.countField.rightViewMode = UITextFieldViewModeAlways;
    
    CGSize size = [self sizeWithText:@"  (元)" font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(0, self.frameModel.countF.size.height)];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, self.frameModel.countF.size.height)];
    
    lab.textColor = NameColor;
    
    lab.font = [UIFont systemFontOfSize:15];
    
    lab.text = @"  (元)";
    
    self.countField.rightView = lab;
    
    self.starLab.text = @" * ";
    
    self.StarDescLab.text = @"每位任务伙伴完成任务后当天可获得的佣金（每日返利金额大于官方规定金额时需发布任务并邀请朋友完成）";
    
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
