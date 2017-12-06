//
//  T_NewTaskCell.m
//  HuiHui
//
//  Created by mac on 2017/3/23.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "T_NewTaskCell.h"
#import "T_NewTask.h"
#import "T_NewTaskFrame.h"

#define NameColor [UIColor colorWithRed:23/255. green:44/255. blue:56/255. alpha:1.]
#define NameFont [UIFont systemFontOfSize:22]
#define DescColor [UIColor colorWithRed:163/255. green:163/255. blue:163/255. alpha:1.]
#define DescFont [UIFont systemFontOfSize:15]
#define LineColor [UIColor colorWithRed:243/255.f green:243/255.f blue:243/255.f alpha:1.0]

@interface T_NewTaskCell ()

@property (nonatomic, weak) UIButton *chooseBtn;

@property (nonatomic, weak) UIImageView *chooseImageview;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *descLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation T_NewTaskCell

+ (instancetype)T_NewTaskCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"T_NewTaskCell";
    
    T_NewTaskCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[T_NewTaskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *imageview = [[UIImageView alloc] init];
        
        self.chooseImageview = imageview;
        
        [self addSubview:imageview];
        
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
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = LineColor;
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(T_NewTaskFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.nameLab.frame = self.frameModel.nameF;
    
    self.descLab.frame = self.frameModel.descF;
    
    self.chooseImageview.frame = self.frameModel.chooseBtnF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {
    
    T_NewTask *task = self.frameModel.taskModel;

    self.nameLab.text = [NSString stringWithFormat:@"%@",task.TaskName];
    
    self.descLab.text = [NSString stringWithFormat:@"%@",task.TaskDescription];
    
    if (task.isChoose) {
        
        self.chooseImageview.image = [UIImage imageNamed:@"T_Selected.png"];
        
    }else {
        
        self.chooseImageview.image = [UIImage imageNamed:@"T_NoSelect.png"];
        
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
