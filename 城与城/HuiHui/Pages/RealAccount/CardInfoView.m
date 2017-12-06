//
//  CardInfoView.m
//  baozhifu
//
//  Created by mac on 13-7-23.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "CardInfoView.h"

@interface CardInfoView ()

@property (weak, nonatomic) IBOutlet UIImageView *bankImage;

@property (weak, nonatomic) IBOutlet UILabel *bandCardNo;

@property (weak, nonatomic) IBOutlet UILabel *idcardNo;

@end

@implementation CardInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setData:(NSDictionary *)bankInfo {
    self.bandCardNo.text = [bankInfo objectForKey:@"CardNumber"];
    self.idcardNo.text = [NSString stringWithFormat:@"身份证号：%@", [bankInfo objectForKey:@"IDCard"]];
    self.bankImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"bank_logo_%@.png", [bankInfo objectForKey:@"OrgCode"]]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
