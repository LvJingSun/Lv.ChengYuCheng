//
//  T_S_FriendCell.m
//  HuiHui
//
//  Created by mac on 2017/5/10.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "T_S_FriendCell.h"
#import "T_S_FriendModel.h"
#import "T_S_FriendFrame.h"
#import "UIImageView+AFNetworking.h"

#define LineColor [UIColor colorWithRed:243/255.f green:243/255.f blue:243/255.f alpha:1.0]
#define NickFont [UIFont systemFontOfSize:18]
#define NickColor [UIColor colorWithRed:20/255. green:172/255. blue:226/255. alpha:1.]
#define NameFont [UIFont systemFontOfSize:17]
#define NameColor [UIColor colorWithRed:119/255. green:119/255. blue:119/255. alpha:1.]
#define AccountFont [UIFont systemFontOfSize:16]
#define AccountColor [UIColor colorWithRed:145/255. green:145/255. blue:145/255. alpha:1.]
#define AddCOLOR [UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.0]

@interface T_S_FriendCell ()

@property (nonatomic, weak) UIImageView *iconImageview;

@property (nonatomic, weak) UILabel *nickLab;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *accountLab;

@property (nonatomic, weak) UIButton *addBtn;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation T_S_FriendCell

+ (instancetype)T_S_FriendCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"T_S_FriendCell";
    
    T_S_FriendCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[T_S_FriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *imageview = [[UIImageView alloc] init];
        
        self.iconImageview = imageview;
        
        [self addSubview:imageview];
        
        UILabel *nick = [[UILabel alloc] init];
        
        self.nickLab = nick;
        
        nick.textColor = NickColor;
        
        nick.font = NickFont;
        
        nick.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:nick];
        
        UILabel *name = [[UILabel alloc] init];
        
        self.nameLab = name;
        
        name.textColor = NameColor;
        
        name.font = NameFont;
        
        name.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:name];
        
        UILabel *account = [[UILabel alloc] init];
        
        self.accountLab = account;
        
        account.textColor = AccountColor;
        
        account.font = AccountFont;
        
        account.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:account];
        
        UIButton *add = [[UIButton alloc] init];
        
        self.addBtn = add;
        
        [self addSubview:add];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = LineColor;
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(T_S_FriendFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.iconImageview.frame = self.frameModel.iconF;
    
    self.iconImageview.layer.masksToBounds = YES;
    
    self.iconImageview.layer.cornerRadius = self.frameModel.iconF.size.width * 0.5;
    
    self.nickLab.frame = self.frameModel.nickF;
    
    self.nameLab.frame = self.frameModel.nameF;
    
    self.accountLab.frame = self.frameModel.accountF;
    
    self.addBtn.frame = self.frameModel.addF;
    
    self.addBtn.layer.masksToBounds = YES;
    
    self.addBtn.layer.cornerRadius = 5;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {
    
    T_S_FriendModel *model = self.frameModel.friendModel;

    [self.iconImageview setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.MemPhoto]] placeholderImage:[UIImage imageNamed:@"timg.jpeg"]];
    
    self.nickLab.text = [NSString stringWithFormat:@"%@",model.NickName];
    
    if (model.RealName.length != 0) {
        
        self.nameLab.text = [NSString stringWithFormat:@"(%@)",model.RealName];
        
    }

    self.accountLab.text = [NSString stringWithFormat:@"%@",model.Account];
    
    [self.addBtn setTitle:@"添加" forState:0];
    
    if ([model.StateStr isEqualToString:@"0"]) {
        
        self.addBtn.hidden = YES;
        
    }else if ([model.StateStr isEqualToString:@"1"]) {
    
        [self.addBtn setTitleColor:AccountColor forState:0];
        
        self.addBtn.layer.borderWidth = 1;
        
        self.addBtn.layer.borderColor = AccountColor.CGColor;
        
        self.addBtn.userInteractionEnabled = NO;
        
    }else if ([model.StateStr isEqualToString:@"2"]) {
    
        [self.addBtn setTitleColor:AddCOLOR forState:0];
        
        self.addBtn.layer.borderWidth = 1;
        
        self.addBtn.layer.borderColor = AddCOLOR.CGColor;
        
        self.addBtn.userInteractionEnabled = YES;
        
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
