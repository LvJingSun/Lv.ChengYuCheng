//
//  T_Detail1Cell.m
//  HuiHui
//
//  Created by mac on 2017/3/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "T_Detail1Cell.h"
//#import "T_Task.h"
#import "T_Detail1Frame.h"

#import "TH_TaskModel.h"

#define TaskNameColor [UIColor colorWithRed:23/255. green:44/255. blue:56/255. alpha:1.]
#define TaskNameFont [UIFont systemFontOfSize:22]
#define TypeColor [UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.0]
#define TypeFont [UIFont systemFontOfSize:16]
#define LineColor [UIColor colorWithRed:243/255.f green:243/255.f blue:243/255.f alpha:1.0]
#define LightColor [UIColor colorWithRed:163/255. green:163/255. blue:163/255. alpha:1.]
#define LightFont [UIFont systemFontOfSize:18]
#define CountColor [UIColor colorWithRed:255/255. green:100/255. blue:0/255. alpha:1.]
#define CountFont [UIFont systemFontOfSize:30]
#define JinXingZhongColor [UIColor colorWithRed:69/255. green:191/255. blue:89/255. alpha:1.]
#define JuJueColor [UIColor colorWithRed:254/255. green:73/255. blue:63/255. alpha:1.]

@interface T_Detail1Cell ()

@property (nonatomic, weak) UILabel *tasknameLab;

@property (nonatomic, weak) UILabel *typeLab;

@property (nonatomic, weak) UILabel *lineLab;

@property (nonatomic, weak) UILabel *line2Lab;

@property (nonatomic, weak) UILabel *personLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *timeLab;

@property (nonatomic, weak) UILabel *statusTitleLab;

@property (nonatomic, weak) UILabel *statusLab;

@end

@implementation T_Detail1Cell

+ (instancetype)T_Detail1CellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"T_Detail1Cell";
    
    T_Detail1Cell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[T_Detail1Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = LineColor;
        
        [self addSubview:line];
        
        UILabel *person = [[UILabel alloc] init];
        
        self.personLab = person;
        
        person.textColor = LightColor;
        
        person.font = LightFont;
        
        [self addSubview:person];
        
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
        
        UILabel *line2 = [[UILabel alloc] init];
        
        self.line2Lab = line2;
        
        line2.backgroundColor = LineColor;
        
        [self addSubview:line2];
        
        UILabel *statustitle = [[UILabel alloc] init];
        
        self.statusTitleLab = statustitle;
        
        statustitle.textColor = LightColor;
        
        statustitle.font = LightFont;
        
        [self addSubview:statustitle];
        
        UILabel *status = [[UILabel alloc] init];
        
        self.statusLab = status;
        
        status.font = LightFont;
        
        [self addSubview:status];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(T_Detail1Frame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.tasknameLab.frame = self.frameModel.TaskNameF;
    
    self.typeLab.frame = self.frameModel.TaskTypeF;
    
    self.lineLab.frame = self.frameModel.LineF;
    
    self.line2Lab.frame = self.frameModel.Line2F;
    
    self.personLab.frame = self.frameModel.PersonF;
    
    self.statusTitleLab.frame = self.frameModel.StatusTitleF;
    
    self.statusLab.frame = self.frameModel.StatusF;
    
    self.countLab.frame = self.frameModel.CountF;
    
    self.timeLab.frame = self.frameModel.TimeF;
    
}

- (void)setContent {
    
    TH_TaskModel *task = self.frameModel.th_taskmodel;
    
    if ([task.IsFriendsTaskOrMyTask isEqualToString:@"1"]) {
    
        self.typeLab.text = @"（好友任务）";
        
        self.tasknameLab.text = [NSString stringWithFormat:@"%@",task.TaskName];
        
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
        
    }else if ([task.IsFriendsTaskOrMyTask isEqualToString:@"0"]) {
        
        self.tasknameLab.text = [NSString stringWithFormat:@"%@",task.ReMemName];
        
        self.personLab.text = [NSString stringWithFormat:@"发布人：%@",task.ReleaseName];
        
        self.countLab.text = [NSString stringWithFormat:@"%@",task.ReTaskAmount];
        
        self.timeLab.text = [NSString stringWithFormat:@"发布时间：%@",task.ReTime];
        
        if ([task.StatusIs isEqualToString:@"已完成"]) {
            
            self.statusLab.textColor = TypeColor;
            
        }else if ([task.StatusIs isEqualToString:@"进行中"]) {
            
            self.statusLab.textColor = JinXingZhongColor;
            
        }
        
        self.statusLab.text = [NSString stringWithFormat:@"%@",task.StatusIs];
        
    }
    
    self.statusTitleLab.text = @"状态：";

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
