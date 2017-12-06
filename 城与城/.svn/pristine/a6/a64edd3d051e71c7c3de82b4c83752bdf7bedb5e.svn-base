//
//  PimageCell.m
//  baozhifu
//
//  Created by 冯海强 on 14-1-16.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "PimageCell.h"
#import "CommonUtil.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import "UIImageView+AFNetworking.h"

@implementation PimageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)setImageCell {

    NSString *path = self.Cellimagepath;
    UIImage *reSizeImage = [self.imageCache getImage:path];
    if (reSizeImage != nil) {
        self.P_Cellimage.image = reSizeImage;
        return;
    }
    //NSLog(@"AFImage load path: %@", path);
//    __weak PimageCell *imageCell = self;
    [self.P_Cellimage setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]]
                         placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                  success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                      self.P_Cellimage.image = [CommonUtil scaleImage:image toSize:CGSizeMake(450,280)];
//                                      self.P_Cellimage.contentMode = UIViewContentModeScaleToFill;
//                                      [imageCell setNeedsLayout];
                                      [self.imageCache addImage:self.P_Cellimage.image andUrl:path];
                                      
                                      
                                      [self.PimageViewController.Imagearray addObject:self.P_Cellimage.image];
                                      
                                  }
                                  failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                      
                                  }];
}





//NSString *path = self.Cellimagepath;
//UIImage *reSizeImage = [self.imageCache getImage:path];
//if (reSizeImage != nil)
//{
//        self.P_Cellimage.image = reSizeImage;
//        return;
//
//}
//UIImageView*imv=[[UIImageView alloc]init];
//[imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",path]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//    
//    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 450,280)];
//    [self.imageCache addImage:imgV.image andUrl:path];
//    self.P_Cellimage.image =[CommonUtil scaleImage:image toSize:CGSizeMake(450, 280)];
//    [self.PimageViewController.Imagearray addObject:[CommonUtil scaleImage:image toSize:CGSizeMake(450, 280)]];
// 
//    
//} failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//    
//}];

//}


@end
