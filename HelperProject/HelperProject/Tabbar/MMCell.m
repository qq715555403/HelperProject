//
//  MMCell.m
//  HelperProject
//
//  Created by hushijun on 15/8/26.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import "MMCell.h"

@implementation MMCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
//    CADisplayLink
}



//重载layoutSubviews：设置系统控件的位置
- (void)layoutSubviews
{
//    UIImage *img = self.imageView.image;
//    self.imageView.image = LoadImageByName(@"placeholder.png");
//    [super layoutSubviews];
//    self.imageView.image = img;
    
    [super layoutSubviews];
    [self.imageView setFrame:CGRectMake(10, 10,29, 29)];
    self.textLabel.xValue=50;
    self.detailTextLabel.xValue=50;
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}


@end
