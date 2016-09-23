//
//  PingfenViewController.h
//  HelperProject
//
//  Created by hushijun on 15/9/15.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "UzysAssetsPickerController.h"
#import "MHImagePickerMutilSelector.h"
#import "HCSStarRatingView.h"

@interface PingfenViewController : UIViewController<UzysAssetsPickerControllerDelegate,MHImagePickerMutilSelectorDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIImage *_avatar;
    NSMutableArray *_arryPhotos;//本地选择的图片
    NSMutableArray *_arryPhotoPaths;//本地选择的图片路径
    HCSStarRatingView *_starRatingView;//星星评分
    IBOutlet UIView *starView;
    NSInteger imgIndex;//图片索引
}
@property (strong, nonatomic) IBOutlet UIImageView *imgBG;

@end
