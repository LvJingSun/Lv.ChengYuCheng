//
//  CardInfoListView.m
//  baozhifu
//
//  Created by mac on 13-7-23.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "CardInfoListView.h"
#import "BankCardListViewController.h"

@interface CardInfoListView ()

@property (weak, nonatomic) IBOutlet UIImageView *backImage;

@property (weak, nonatomic) IBOutlet UIImageView *bankImage;

@property (weak, nonatomic) IBOutlet UILabel *bandCardNo;

@property (weak, nonatomic) IBOutlet UILabel *idcardNo;

@property (weak, nonatomic) IBOutlet UIImageView *validImage;

@property (weak, nonatomic) IBOutlet UIButton *validButton;

- (IBAction)selectCard:(id)sender;

- (IBAction)deleteCard:(id)sender;

- (IBAction)verifyCard:(id)sender;

@end

@implementation CardInfoListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
    }
    
    return self;
    
}

- (void)setData:(NSDictionary *)bankData {
    self.bankInfo = bankData;
    self.bandCardNo.text = [bankData objectForKey:@"CardNumber"];
    self.idcardNo.text = [NSString stringWithFormat:@"身份证号：%@", [bankData objectForKey:@"IDCard"]];
    self.bankImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"bank_logo_%@.png", [bankData objectForKey:@"OrgCode"]]];
    NSString *isDefault = [bankData objectForKey:@"IsDefault"];
    if (isDefault.intValue == 1) {
        self.backImage.image = [UIImage imageNamed:@"panel_bank_card_selected"];
    } else {
        self.backImage.image = [UIImage imageNamed:@"panel_bank_card"];
    }
    NSString *status = [bankData objectForKey:@"Status"];
    
    if ([status isEqualToString:@"PaySucc"]) {
        
        // 支付成功，图片显示为验
        self.validImage.image = [UIImage imageNamed:@"icon_back_card_paysuc"];
        
        [self.validButton setImage:[UIImage imageNamed:@"icon_bank_vld"] forState:UIControlStateNormal];
        
        self.validButton.enabled = YES;
        
        self.validButton.hidden = NO;
        
        self.m_successOK.hidden = YES;
        
        self.m_statusLabel.text = [NSString stringWithFormat:@"状态：待验卡"];
        
    } else if ([status isEqualToString:@"VerificationSucc"]) {
        
        // 验证成功，btn的图片显示为ok ==============
        self.validImage.image = [UIImage imageNamed:@"icon_back_card_verification"];
        [self.validButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];

        self.validButton.titleLabel.textColor = [UIColor redColor];
        self.validButton.enabled = NO;
        self.validButton.hidden = YES;
      
        self.m_successOK.hidden = NO;
        
        self.m_statusLabel.text = [NSString stringWithFormat:@"状态：验证成功"];

        
    } else if ([status isEqualToString:@"Fail"]) {
       
        self.validImage.image = [UIImage imageNamed:@"icon_back_card_locked"];
        [self.validButton setImage:[UIImage imageNamed:@"icon_bank_issue"] forState:UIControlStateNormal];
        self.validButton.enabled = YES;
        self.validButton.hidden = NO;
        
        self.m_successOK.hidden = YES;
        
        self.m_statusLabel.text = [NSString stringWithFormat:@"状态：失败"];

    
    } else if ([status isEqualToString:@"Locked"]) {
        
        self.validImage.image = [UIImage imageNamed:@"icon_back_card_locked"];
        [self.validButton setImage:[UIImage imageNamed:@"icon_back_card_locked"] forState:UIControlStateNormal];
        self.validButton.enabled = YES;
        self.validButton.hidden = NO;
        
        self.m_successOK.hidden = YES;
        
        self.m_statusLabel.text = [NSString stringWithFormat:@"状态：卡已锁定"];


  
    }else if ([status isEqualToString:@"Verification"]){
        
        self.validImage.image = [UIImage imageNamed:@"icon_back_card_paysuc"];
        [self.validButton setImage:[UIImage imageNamed:@"icon_bank_vld"] forState:UIControlStateNormal];
        self.validButton.enabled = YES;
        self.validButton.hidden = NO;
       
        self.m_successOK.hidden = YES;
        
        self.m_statusLabel.text = [NSString stringWithFormat:@"状态：验证中"];


    }
    
    
//    if ([status isEqualToString:@"VerificationSucc"]) {
//        self.validImage.image = [UIImage imageNamed:@"icon_back_card_verification"];
//        [self.validButton setImage:nil forState:UIControlStateNormal];
//        self.validButton.enabled = NO;
//    } else {
//        if ([status isEqualToString:@"PaySucc"]) {
//            
//        } else if ([status isEqualToString:@"Fail"]) {
//            self.validImage.image = [UIImage imageNamed:@"icon_back_card_verification"];
//        } else if ([status isEqualToString:@"Locked"]) {
//            self.validImage.image = [UIImage imageNamed:@"icon_back_card_locked"];
//        } else {
//            self.validImage.image = nil;
//        }
//        [self.validButton setImage:[UIImage imageNamed:@"icon_bank_vld"] forState:UIControlStateNormal];
//        self.validButton.enabled = YES;
//    }
}

- (IBAction)selectCard:(id)sender {
    
    BankCardListViewController *viewController = (BankCardListViewController *)self.rootViewController;
    [viewController selectCard:[self.bankInfo objectForKey:@"MemberBankCardId"] index:self.index status:[self.bankInfo objectForKey:@"Status"]];
}

- (IBAction)deleteCard:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"确定删除银行卡？"
                                                       delegate:self
                                              cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alertView show];

}

- (IBAction)verifyCard:(id)sender {
    NSString *status = [self.bankInfo objectForKey:@"Status"];
      
    if ([status isEqualToString:@"Verification"]) {
        
//        NSString *message = [self.bankInfo objectForKey:@"RejectReason"];
//        
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"验卡提示"
//                                                            message:message
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"确定"
//                                                  otherButtonTitles:nil, nil];
//        [alertView show];
        
        BankCardListViewController *viewController = (BankCardListViewController *)self.rootViewController;
        [viewController verifyCard:self.bankInfo];
        
    }else if ( [status isEqualToString:@"PaySucc"] ){
        
        BankCardListViewController *viewController = (BankCardListViewController *)self.rootViewController;
        [viewController verifyCard:self.bankInfo];
      
        
    }else if ([status isEqualToString:@"VerificationSucc"]) {
        
//        NSString *message = [self.bankInfo objectForKey:@"RejectReason"];
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"验证成功" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alertView show];
        
    } else if ([status isEqualToString:@"Fail"]) {
        
        NSString *message = [self.bankInfo objectForKey:@"RejectReason"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"失败说明"
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        
    } else if ([status isEqualToString:@"Locked"]) {
        
        NSString *message = [self.bankInfo objectForKey:@"RejectReason"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"锁定原因"
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        BankCardListViewController *viewController = (BankCardListViewController *)self.rootViewController;
        [viewController deleteCard:[self.bankInfo objectForKey:@"MemberBankCardId"] index:self.index];
    }
}

@end
