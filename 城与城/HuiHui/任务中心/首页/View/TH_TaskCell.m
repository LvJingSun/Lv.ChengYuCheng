//
//  TH_TaskCell.m
//  HuiHui
//
//  Created by mac on 2017/4/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "TH_TaskCell.h"
#import "TH_TaskModel.h"
#import "TH_TaskCellFrameModel.h"

#define TaskNameColor [UIColor colorWithRed:23/255. green:44/255. blue:56/255. alpha:1.]
#define TaskNameFont [UIFont systemFontOfSize:18]
#define TypeColor [UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.0]
#define TypeFont [UIFont systemFontOfSize:14]
#define LineColor [UIColor colorWithRed:243/255.f green:243/255.f blue:243/255.f alpha:1.0]
#define T_HANGCOLOR [UIColor colorWithRed:244/255. green:244/255. blue:244/255. alpha:1.]
#define LightColor [UIColor colorWithRed:163/255. green:163/255. blue:163/255. alpha:1.]
#define LightFont [UIFont systemFontOfSize:16]
#define CountColor [UIColor colorWithRed:255/255. green:100/255. blue:0/255. alpha:1.]
#define CountFont [UIFont systemFontOfSize:30]
#define JinXingZhongColor [UIColor colorWithRed:69/255. green:191/255. blue:89/255. alpha:1.]
#define JuJueColor [UIColor colorWithRed:254/255. green:73/255. blue:63/255. alpha:1.]

@interface TH_TaskCell ()

@property (nonatomic, weak) UILabel *tasknameLab;

@property (nonatomic, weak) UILabel *typeLab;

@property (nonatomic, weak) UIButton *addBtn;

@property (nonatomic, weak) UILabel *lineLab;

@property (nonatomic, weak) UILabel *bottomLab;

@property (nonatomic, weak) UILabel *personLab;

@property (nonatomic, weak) UILabel *completeLab;

@property (nonatomic, weak) UILabel *statusTitleLab;

@property (nonatomic, weak) UILabel *statusLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *timeLab;

@end

@implementation TH_TaskCell

+ (instancetype)TH_TaskCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"TH_TaskCell";
    
    TH_TaskCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[TH_TaskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *taskname = [[UILabel alloc] init];
        
        self.tasknameLab = taskname;
        
        taskname.textColor = TaskNameColor;
        
        taskname.font = TaskNameFont;
        
        [self addSubview:taskname];
        
        UILabel *type = [[UILabel alloc] init];
        
        self.typeLab = type;
        
        type.textColor = TypeColor;
        
        type.font = TypeFont;
        
        [self addSubview:type];
        
        UIButton *add = [[UIButton alloc] init];
        
        self.addBtn = add;
        
        [self addSubview:add];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = LineColor;
        
        [self addSubview:line];
        
        UILabel *person = [[UILabel alloc] init];
        
        self.personLab = person;
        
        person.textColor = LightColor;
        
        person.font = LightFont;
        
        [self addSubview:person];
        
        UILabel *complete = [[UILabel alloc] init];
        
        self.completeLab = complete;
        
        complete.textColor = LightColor;
        
        complete.font = LightFont;
        
        [self addSubview:complete];
        
        UILabel *statustitle = [[UILabel alloc] init];
        
        self.statusTitleLab = statustitle;
        
        statustitle.textColor = LightColor;
        
        statustitle.font = LightFont;
        
        [self addSubview:statustitle];
        
        UILabel *status = [[UILabel alloc] init];
        
        self.statusLab = status;
        
        status.font = LightFont;
        
        [self addSubview:status];
        
        UILabel *count = [[UILabel alloc] init];
        
        self.countLab = count;
        
        count.textColor = CountColor;
        
        count.font = CountFont;
        
        count.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:count];
        
        UILabel *time = [[UILabel alloc] init];
        
        self.timeLab = time;
        
        time.textColor = LightColor;
        
        time.font = LightFont;
        
        [self addSubview:time];
        
        UILabel *bottom = [[UILabel alloc] init];
        
        self.bottomLab = bottom;
        
        bottom.backgroundColor = T_HANGCOLOR;
        
        [self addSubview:bottom];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(TH_TaskCellFrameModel *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.tasknameLab.frame = self.frameModel.TaskNameF;
    
    self.typeLab.frame = self.frameModel.TaskTypeF;
    
    self.addBtn.frame = self.frameModel.AddF;
    
    self.lineLab.frame = self.frameModel.LineF;
    
    self.bottomLab.frame = self.frameModel.bottomF;
    
    self.personLab.frame = self.frameModel.PersonF;
    
    self.completeLab.frame = self.frameModel.CompleteF;
    
    self.statusTitleLab.frame = self.frameModel.StatusTitleF;
    
    self.statusLab.frame = self.frameModel.StatusF;
    
    self.countLab.frame = self.frameModel.CountF;
    
    self.timeLab.frame = self.frameModel.TimeF;
    
}

- (void)btnClick:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(addBtnClick:)]) {
        
        [self.delegate addBtnClick:sender];
        
    }
    
}

- (void)setContent {

    TH_TaskModel *task = self.frameModel.taskmodel;
    
    self.statusTitleLab.text = @"状态：";
    
    if ([task.IsFriendsTaskOrMyTask isEqualToString:@"0"]) {
        
        self.tasknameLab.text = [NSString stringWithFormat:@"%@",task.ReMemName];
        
        [self.addBtn setImage:[UIImage imageNamed:@"icon_bank_card_add@2x.png"] forState:0];
        
        [self.addBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        self.completeLab.text = [NSString stringWithFormat:@"今日已完成：%@/%@",task.CompletedNum,task.NeedNum];
        
        self.timeLab.text = [NSString stringWithFormat:@"发布时间：%@",task.ReTime];
        
        if ([task.StatusIs isEqualToString:@"已完成"]) {
            
            self.statusLab.textColor = TypeColor;
            
        }else if ([task.StatusIs isEqualToString:@"进行中"]) {
            
            self.statusLab.textColor = JinXingZhongColor;
            
        }
        
        self.statusLab.text = [NSString stringWithFormat:@"%@",task.StatusIs];
        
    }else if ([task.IsFriendsTaskOrMyTask isEqualToString:@"1"]) {
    
        self.tasknameLab.text = [NSString stringWithFormat:@"%@",task.TaskName];
        
        self.typeLab.text = @"（好友任务）";
        
        self.personLab.text = [NSString stringWithFormat:@"发布人：%@",task.RName];
        
        self.countLab.text = [NSString stringWithFormat:@"+%@",task.TaskBonuses];
        
        self.timeLab.text = [NSString stringWithFormat:@"接受时间：%@",task.WTime];
        
        if ([task.WhetherComplete isEqualToString:@"已完成"]) {
            
            self.statusLab.textColor = TypeColor;
            
        }else if ([task.WhetherComplete isEqualToString:@"进行中"]) {
            
            self.statusLab.textColor = JinXingZhongColor;
            
        }else if ([task.WhetherComplete isEqualToString:@"已拒绝"]) {
            
            self.statusLab.textColor = JuJueColor;
            
        }
        
        self.statusLab.text = [NSString stringWithFormat:@"%@",task.WhetherComplete];

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
