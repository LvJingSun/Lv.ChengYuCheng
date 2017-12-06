//
//  LocationCell.m
//  HuiHui
//
//  Created by mac on 13-10-14.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "LocationCell.h"

#import "CommonUtil.h"

#import "UIImageView+AFNetworking.h"


@implementation LocationCell

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

- (void)setImageView:(NSString *)imagePath{
    
    UIImage *reSizeImage = [self.imageCache getImage:imagePath];
    if (reSizeImage != nil) {
        self.m_imagV.image = reSizeImage;
        return;
    }
    //NSLog(@"AFImage load path: %@", path);
    __weak LocationCell *weakCell = self;
    [self.m_imagV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                        placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
//                                     self.m_imagV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(105, 65)];
                                     self.m_imagV.image = image;
                                     [weakCell setNeedsLayout];
                                     [self.imageCache addImage:self.m_imagV.image andUrl:imagePath];
                                 }
                                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                     
                                 }];
    
}



- (void)setValue:(NSString *)aString{
    
    if ( [aString isEqualToString:@"0"] ) {
                        
        self.m_img1V.image = [UIImage imageNamed:@"bd_09.png"];
        self.m_img2V.image = [UIImage imageNamed:@"bd_09.png"];
        self.m_img3V.image = [UIImage imageNamed:@"bd_09.png"];
        self.m_img4V.image = [UIImage imageNamed:@"bd_09.png"];
        self.m_img5V.image = [UIImage imageNamed:@"bd_09.png"];
        
    }else{
                        
        if ( [aString isEqualToString:@"1"] ) {
            
            self.m_img1V.image = [UIImage imageNamed:@"bd_08.png"];
            self.m_img2V.image = [UIImage imageNamed:@"bd_09.png"];
            self.m_img3V.image = [UIImage imageNamed:@"bd_09.png"];
            self.m_img4V.image = [UIImage imageNamed:@"bd_09.png"];
            self.m_img5V.image = [UIImage imageNamed:@"bd_09.png"];
            
            
        }else if ( [aString isEqualToString:@"2"] ){
            
            self.m_img1V.image = [UIImage imageNamed:@"bd_08.png"];
            self.m_img2V.image = [UIImage imageNamed:@"bd_08.png"];
            self.m_img3V.image = [UIImage imageNamed:@"bd_09.png"];
            self.m_img4V.image = [UIImage imageNamed:@"bd_09.png"];
            self.m_img5V.image = [UIImage imageNamed:@"bd_09.png"];
            
        }else if ( [aString isEqualToString:@"3"] ){
            
            self.m_img1V.image = [UIImage imageNamed:@"bd_08.png"];
            self.m_img2V.image = [UIImage imageNamed:@"bd_08.png"];
            self.m_img3V.image = [UIImage imageNamed:@"star1.png"];
            self.m_img4V.image = [UIImage imageNamed:@"bd_09.png"];
            self.m_img5V.image = [UIImage imageNamed:@"bd_09.png"];
            
            
        }else if ( [aString isEqualToString:@"4"] ){
            
            self.m_img1V.image = [UIImage imageNamed:@"bd_08.png"];
            self.m_img2V.image = [UIImage imageNamed:@"bd_08.png"];
            self.m_img3V.image = [UIImage imageNamed:@"bd_08.png"];
            self.m_img4V.image = [UIImage imageNamed:@"bd_08.png"];
            self.m_img5V.image = [UIImage imageNamed:@"bd_09.png"];
            
            
        }else if ( [aString isEqualToString:@"5"] ){
            
            self.m_img1V.image = [UIImage imageNamed:@"bd_08.png"];
            self.m_img2V.image = [UIImage imageNamed:@"bd_08.png"];
            self.m_img3V.image = [UIImage imageNamed:@"bd_08.png"];
            self.m_img4V.image = [UIImage imageNamed:@"bd_08.png"];
            self.m_img5V.image = [UIImage imageNamed:@"bd_08.png"];
            
        }
        
    }
    
}


//
//-(NSString *)distanceBetweenOrderBy:(float)lat1 :(float)lat2 :(float)lng1 :(float)lng2{
//    
//    double dd = M_PI/180;
//    double x1=lat1*dd,x2=lat2*dd;
//    double y1=lng1*dd,y2=lng2*dd;
//    double R = 6371004;
//    int distance = (2*R*asin(sqrt(2-2*cos(x1)*cos(x2)*cos(y1-y2) - 2*sin(x1)*sin(x2))/2));
//    //km  返回
//    //return  distance*1000;
//    //返回 m
//    if (distance>=1000) {
//        return [NSString stringWithFormat:@"<%dkm",distance/1000];
//    }
//    //返回 m
//    return   [NSString stringWithFormat:@"<%d米",distance];
//}


@end

@implementation MoreProductCell

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
@end
