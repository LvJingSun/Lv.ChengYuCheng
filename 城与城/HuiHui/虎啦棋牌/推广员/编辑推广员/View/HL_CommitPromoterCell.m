//
//  HL_CommitPromoterCell.m
//  HuiHui
//
//  Created by mac on 2017/12/19.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_CommitPromoterCell.h"
#import "HL_CommitPromoterModel.h"
#import "HL_CommitPromoterFrame.h"
#import "LJConst.h"

@interface HL_CommitPromoterCell ()

@property (nonatomic, weak) UITextField *phoneField;

@property (nonatomic, weak) UILabel *phoneNoticeLab;

@property (nonatomic, weak) UITextField *countField;

@property (nonatomic, weak) UILabel *lineLab;

@property (nonatomic, weak) UIButton *sureBtn;

@end

@implementation HL_CommitPromoterCell

+ (instancetype)HL_CommitPromoterCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"HL_CommitPromoterCell";
    
    HL_CommitPromoterCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[HL_CommitPromoterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = FSB_ViewBGCOLOR;
        
        UITextField *phone = [[UITextField alloc] init];
        
        self.phoneField = phone;
        
        phone.backgroundColor = [UIColor whiteColor];
        
        phone.textColor = [UIColor darkGrayColor];
        
        phone.font = [UIFont systemFontOfSize:17];
        
        phone.keyboardType = UIKeyboardTypeDecimalPad;
        
        [self addSubview:phone];
        
        UITextField *count = [[UITextField alloc] init];
        
        self.countField = count;
        
        count.backgroundColor = [UIColor whiteColor];
        
        count.keyboardType = UIKeyboardTypeDecimalPad;
        
        count.textColor = [UIColor darkGrayColor];
        
        count.textAlignment = NSTextAlignmentRight;
        
        count.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:count];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:line];
        
        UIButton *sure = [[UIButton alloc] init];
        
        self.sureBtn = sure;
        
        [sure setTitleColor:[UIColor whiteColor] forState:0];
        
        [sure setBackgroundColor:FSB_StyleCOLOR];
        
        sure.titleLabel.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:sure];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(HL_CommitPromoterFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.phoneField.frame = self.frameModel.phoneF;
    
    CGSize phoneTitleSize = [self sizeWithText:@"会员手机号" font:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(0, self.frameModel.phoneF.size.height)];
    
    UILabel *phonetitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, phoneTitleSize.width + _WindowViewWidth * 0.1, self.frameModel.phoneF.size.height)];
    
    phonetitle.textAlignment = NSTextAlignmentCenter;
    
    phonetitle.font = [UIFont systemFontOfSize:16];
    
    phonetitle.textColor = [UIColor darkTextColor];
    
    phonetitle.text = @"会员手机号";
    
    self.phoneField.leftViewMode = UITextFieldViewModeAlways;
    
    self.phoneField.leftView = phonetitle;
    
    CGSize noticeSize = [self sizeWithText:[NSString stringWithFormat:@"(%@)",self.frameModel.model.notice] font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(0, self.frameModel.phoneF.size.height)];
    
    UILabel *notice = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, noticeSize.width + _WindowViewWidth * 0.05, self.frameModel.phoneF.size.height)];
    
    self.phoneNoticeLab = notice;
    
    notice.textAlignment = NSTextAlignmentLeft;
    
    notice.font = [UIFont systemFontOfSize:15];
    
    notice.textColor = [UIColor redColor];
    
//    notice.text = self.frameModel.model.notice;
    
    self.phoneField.rightViewMode = UITextFieldViewModeAlways;
    
    self.phoneField.rightView = notice;
    
    self.lineLab.frame = self.frameModel.lineF;
    
    self.countField.frame = self.frameModel.countF;
    
    UILabel *counttitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, phoneTitleSize.width + _WindowViewWidth * 0.1, self.frameModel.countF.size.height)];
    
    counttitle.textAlignment = NSTextAlignmentCenter;
    
    counttitle.font = [UIFont systemFontOfSize:16];
    
    counttitle.textColor = [UIColor darkTextColor];
    
    counttitle.text = @"设置分成:";
    
    self.countField.leftViewMode = UITextFieldViewModeAlways;
    
    self.countField.leftView = counttitle;
    
    CGSize countNoticeSize = [self sizeWithText:@"%(分成为1-100的百分比)" font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(0, self.frameModel.countF.size.height)];
    
    UILabel *countnotice = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, countNoticeSize.width + _WindowViewWidth * 0.1, self.frameModel.countF.size.height)];
    
    countnotice.textAlignment = NSTextAlignmentCenter;
    
    countnotice.font = [UIFont systemFontOfSize:15];
    
    countnotice.textColor = [UIColor darkGrayColor];
    
    countnotice.text = @"%(分成为1-100的百分比)";
    
    self.countField.rightViewMode = UITextFieldViewModeAlways;
    
    self.countField.rightView = countnotice;
    
    self.sureBtn.frame = self.frameModel.sureF;
    
}

- (void)setContent {
    
    HL_CommitPromoterModel *model = self.frameModel.model;
    
    if ([self isBlankString:model.phone]) {
        
        self.phoneField.text = @"";
        
    }else {
        
        self.phoneField.text = model.phone;
        
    }
    
    if ([self isBlankString:model.count]) {
        
        self.countField.text = @"";
        
    }else {
        
        self.countField.text = model.count;
        
    }
    
    if ([model.type isEqualToString:@"0"]) {
        
        [self.sureBtn setTitle:@"添加推广员" forState:0];
        
    }else if ([model.type isEqualToString:@"1"]) {
        
        [self.sureBtn setTitle:@"保存修改" forState:0];
        
    }
    
    if ([self isBlankString:model.notice]) {
        
        self.phoneNoticeLab.text = @"";
        
    }else {
        
        self.phoneNoticeLab.text = [NSString stringWithFormat:@"(%@)",model.notice];
        
    }
    
}

- (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
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
