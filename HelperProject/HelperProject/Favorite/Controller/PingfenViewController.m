//
//  PingfenViewController.m
//  HelperProject
//
//  Created by hushijun on 15/9/15.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import "PingfenViewController.h"


@interface PingfenViewController ()

@end

@implementation PingfenViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=[UIColor whiteColor];
    
    _arryPhotos=[NSMutableArray array];
    _arryPhotoPaths=[NSMutableArray array];
    imgIndex=1;
    
    [self createStarView];
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.translucent=NO;
//}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO; //隐藏系统tabbar
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES; //隐藏系统tabbar
}

-(void) createStarView
{
    NSLog(@"");
    HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] init];
    starRatingView.translatesAutoresizingMaskIntoConstraints=NO;
    starRatingView.maximumValue = 5;
    starRatingView.minimumValue = 0;
    starRatingView.value = 4.5f;
    starRatingView.allowsHalfStars = YES;
    starRatingView.spacing = 5;
    starRatingView.tintColor = [UIColor redColor];
    [starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    _starRatingView=starRatingView;
    [starView addSubview:_starRatingView];
    
    [starRatingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(starView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)didChangeValue:(HCSStarRatingView *)sender {
    NSLog(@"Changed rating to %.1f", sender.value);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)goodReputation:(id)sender {
    MHImagePickerMutilSelector* imagePickerMutilSelector=[MHImagePickerMutilSelector standardSelector];//自动释放
    imagePickerMutilSelector.delegate=self;//设置代理
    
    UIImagePickerController* picker=[[UIImagePickerController alloc] init];
    picker.delegate=imagePickerMutilSelector;//将UIImagePicker的代理指向到imagePickerMutilSelector
    [picker setAllowsEditing:NO];
    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    picker.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
    picker.navigationController.delegate=imagePickerMutilSelector;//将UIImagePicker的导航代理指向到imagePickerMutilSelector
    
    imagePickerMutilSelector.imagePicker=picker;//使imagePickerMutilSelector得知其控制的UIImagePicker实例，为释放时需要。
    
//    [self presentModalViewController:picker animated:YES];
    
    [self presentViewController:picker animated:YES completion:nil];
}
- (IBAction)commonReputation:(id)sender {
    
}
- (IBAction)badReputation:(id)sender {
    
}

#pragma mark -
- (IBAction)selectPhoto:(id)sender {
    NSLog(@"selectPhoto...");
    
    //if you want to checkout how to config appearance, just uncomment the following 4 lines code.
////#if 0
//    UzysAppearanceConfig *appearanceConfig = [[UzysAppearanceConfig alloc] init];
//    appearanceConfig.finishSelectionButtonColor = [UIColor blueColor];
//    appearanceConfig.assetsGroupSelectedImageName = @"checker.png";
//    [UzysAssetsPickerController setUpAppearanceConfig:appearanceConfig];
////#endif
    
    UzysAssetsPickerController *picker = [[UzysAssetsPickerController alloc] init];
    picker.delegate = self;
    picker.maximumNumberOfSelectionVideo = 2;
    picker.maximumNumberOfSelectionPhoto = 6;
    
//    picker.maximumNumberOfSelectionVideo = 2;
//    picker.maximumNumberOfSelectionPhoto = 3;
//    picker.maximumNumberOfSelectionMedia = 5;

    [self presentViewController:picker animated:YES completion:^{
        
    }];
}

- (IBAction)tijiao:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:NULL];
}




#pragma mark - UzysAssetsPickerControllerDelegate methods
- (void)uzysAssetsPickerController:(UzysAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
//    self.imageView.backgroundColor = [UIColor clearColor];
    DLog(@"assets %@",assets);

    __weak typeof(self) weakSelf = self;
    if([[assets[0] valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypePhoto"]) //Photo
    {
        if (_arryPhotos && _arryPhotos.count>0) {
            [_arryPhotos removeAllObjects];
        }
        
        [assets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALAsset *representation = obj;
            
            NSLog(@"ALAsset==%@",representation);
            
            UIImage *img = [UIImage imageWithCGImage:representation.defaultRepresentation.fullResolutionImage
                                               scale:representation.defaultRepresentation.scale
                                         orientation:(UIImageOrientation)representation.defaultRepresentation.orientation];
            [_arryPhotos addObject:img];
            
            weakSelf.imgBG.image = img;
            
//            *stop = YES;
        }];
        
        
    }
    else //Video
    {
        ALAsset *alAsset = assets[0];
        
        UIImage *img = [UIImage imageWithCGImage:alAsset.defaultRepresentation.fullResolutionImage
                                           scale:alAsset.defaultRepresentation.scale
                                     orientation:(UIImageOrientation)alAsset.defaultRepresentation.orientation];
        weakSelf.imgBG.image = img;
        
        
        
        ALAssetRepresentation *representation = alAsset.defaultRepresentation;
        NSURL *movieURL = representation.url;
        NSURL *uploadURL = [NSURL fileURLWithPath:[[NSTemporaryDirectory() stringByAppendingPathComponent:@"test"] stringByAppendingString:@".mp4"]];
        AVAsset *asset      = [AVURLAsset URLAssetWithURL:movieURL options:nil];
        AVAssetExportSession *session =
        [AVAssetExportSession exportSessionWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
        
        session.outputFileType  = AVFileTypeQuickTimeMovie;
        session.outputURL       = uploadURL;
        
        [session exportAsynchronouslyWithCompletionHandler:^{
            
            if (session.status == AVAssetExportSessionStatusCompleted)
            {
                DLog(@"output Video URL %@",uploadURL);
            }
            
        }];
        
    }
    
    
    if (_arryPhotoPaths && _arryPhotoPaths.count>0) {
        [_arryPhotoPaths removeAllObjects];
    }
    
    NSInteger countPhoto=1;
    for (UIImage *img in _arryPhotos) {
        NSString *strPhoto = [NSString stringWithFormat:@"upload%d.png",countPhoto];
        BOOL isOver = [self saveImage:img WithName:strPhoto];
        
//        if (_arryPhotoPaths.count == 3 && isOver) {
////            [CPToast hiddenMBProgressHUDForView:picker.view];
//            [StatusBarTipsWindowClass hideTips];
//            
//        }else{
////            [CPToast addMBProgressHUD:@"获取中..." toView:picker.view];
//            [StatusBarTipsWindowClass showTips:@"获取中..."];
//        }
        countPhoto++;
    }
    
    NSLog(@"_arryPhotoPaths==%@",_arryPhotoPaths);
}

- (void)uzysAssetsPickerControllerDidExceedMaximumNumberOfSelection:(UzysAssetsPickerController *)picker
{
    [CPToast alertTitle:nil andMessage:@"亲，最多只能选3张照片" delegate:nil btnTitle:@"我知道了"];
}
//
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0)
//{
//    
//}
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    
//}
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    
//}


//从相册中选取图片或拍照
- (void)btnActionForEditPortrait:(id) sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:NULL];
}


//按比例缩放,size 是你要把图显示到 多大区域 CGSizeMake(300, 140)
-(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
            
        }
        else{
            
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}


//指定宽度按比例缩放
-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}



-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}




- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    
    _avatar = info[UIImagePickerControllerOriginalImage];
//    _avatar = [self OriginImage:_avatar scaleToSize:CGSizeMake(320, 569)];
//    _avatar = [self imageCompressForSize:_avatar targetSize:CGSizeMake(kScreen_Width, kScreen_Height)];
    _avatar = [self imageCompressForWidth:_avatar targetWidth:kScreen_Width*2];
    
    NSData *data = UIImagePNGRepresentation(_avatar);
//    NSData *data = UIImageJPEGRepresentation(_avatar,0.5);
    
    self.imgBG.image = _avatar;
    
    NSString *imgName=[NSString stringWithFormat:@"upload%d.png",(int)imgIndex];
    NSString *strPath = [self saveImageTwo:_avatar WithName:imgName];
    NSLog(@"strPath==%@",strPath);
    
    
    
    //处理完毕，回到个人信息页面
    [picker dismissViewControllerAnimated:YES completion:^{
        NSString *strUrl=@"http://wap.leleda.com/sell/recv/upload_comment_img.php";
        
        //网络请求
//        [RequestHelperClass uploadTaskWithUrl:@"" fromPath:strPath name:@"" fileName:@"" completion:^(NSURLResponse *response, id responseObject, NSError *error) {
//            
//        }];

        
//        [self postUpload2:@"http://wap.leleda.com/sell/recv/upload_comment_img.php" fromPath:strPath name:@"file_name"];
        
        [CPToast addMBProgressHUD:@"上传中..." toView:self.imgBG];
        
        NSLog(@"NSTemporaryDirectory()==%@",NSTemporaryDirectory());
//        NSString *theUpFilePath = [NSString stringWithFormat:@"%@testMusic.mp3",NSTemporaryDirectory()];
        
        
//        [self postUpload:strUrl fromData:data name:nil];
    }];
//    [_tableView reloadData];
    
    imgIndex++;
}

#pragma mark - POST上传
- (void)postUpload:(NSString *) url fromData:(NSData *) data name:(NSString *) name
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // AFHTTPResponseSerializer就是正常的HTTP请求响应结果:NSData
    // 当请求的返回数据不是JSON,XML,PList,UIImage之外,使用AFHTTPResponseSerializer
    // 例如返回一个html,text...
    //
    // 实际上就是AFN没有对响应数据做任何处理的情况
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // formData是遵守了AFMultipartFormData的对象
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        // 将本地的文件上传至服务器
        //        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"头像1.png" withExtension:nil];
        //        NSURL *fileURL=[NSURL URLWithString:fromPath];
        ////        [formData appendPartWithFileURL:fileURL name:name error:NULL];
        //        [formData appendPartWithFileURL:fileURL name:@"file_name" fileName:@"file_name.png" mimeType:@"image/png" error:nil];
        
        /*
         此方法参数
         1. 要上传的[二进制数据]
         2. 对应网站上[upload.php中]处理文件的[字段"file"]
         3. 要保存在服务器上的[文件名]
         4. 上传文件的[mimeType]
         */
        
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        
        [formData appendPartWithFileData:data name:@"file_name" fileName:fileName mimeType:@"image/png"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        [CPToast hiddenMBProgressHUDForView:self.imgBG];
        NSLog(@"完成 %@", result);
        
        NSData *jsonData=[result dataUsingEncoding:NSUTF8StringEncoding];
        //解析json数据，使用系统方法 JSONObjectWithData:  options: error:
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        
        NSString *str=dic[@"errmsg"];
        [CPToast alertTitle:str andMessage:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [CPToast hiddenMBProgressHUDForView:self.imgBG];
        NSLog(@"错误 %@", error.localizedDescription);
    }];
}
- (void)postUpload2:(NSString *) url fromPath:(NSString *) fromPath name:(NSString *) name
{
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    
////    NSURL *URL = [NSURL URLWithString:@"http://example.com/upload"];
//    NSURL *URL = [NSURL URLWithString:url];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    
////    NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
//    NSURL *filePath = [NSURL fileURLWithPath:fromPath];
//    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//        if (error) {
//            NSLog(@"Error: %@", error);
//        } else {
//            NSLog(@"Success: %@ %@", response, responseObject);
//        }
//    }];
//    [uploadTask resume];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // AFHTTPResponseSerializer就是正常的HTTP请求响应结果:NSData
    // 当请求的返回数据不是JSON,XML,PList,UIImage之外,使用AFHTTPResponseSerializer
    // 例如返回一个html,text...
    //
    // 实际上就是AFN没有对响应数据做任何处理的情况
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // formData是遵守了AFMultipartFormData的对象
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        // 将本地的文件上传至服务器
        //        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"头像1.png" withExtension:nil];
        NSURL *fileURL=[NSURL URLWithString:fromPath];
//        [formData appendPartWithFileURL:fileURL name:name error:NULL];
        [formData appendPartWithFileURL:fileURL name:@"file_name" fileName:@"file_name.png" mimeType:@"image/png" error:nil];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"完成 %@", result);
        
        NSData *jsonData=[result dataUsingEncoding:NSUTF8StringEncoding];
        //解析json数据，使用系统方法 JSONObjectWithData:  options: error:
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        
        NSString *str=dic[@"errmsg"];
        [CPToast alertTitle:str andMessage:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误 %@", error.localizedDescription);
    }];
   
}


//保存图片
- (NSString *)saveImageTwo:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* totalPath = [documentPath stringByAppendingPathComponent:imageName];
    [imageData writeToFile:totalPath atomically:NO];
    
    //保存到 document
    BOOL isOk = [imageData writeToFile:totalPath atomically:NO];
    
    if (isOk) {
        [_arryPhotoPaths addObject:totalPath];
    }
    
    return totalPath;
}

//保存图片
- (BOOL)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* totalPath = [documentPath stringByAppendingPathComponent:imageName];
    [imageData writeToFile:totalPath atomically:NO];

    //保存到 document
    BOOL isOk = [imageData writeToFile:totalPath atomically:NO];
    
    if (isOk) {
        [_arryPhotoPaths addObject:totalPath];
        
//        [RequestHelperClass uploadTaskWithUrl:@"" fromPath:@"" completion:^(NSURLResponse *response, id responseObject, NSError *error) {
//            
//        }];
    }
    
    
    
//    //保存到 NSUserDefaults
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setObject:totalPath forKey:@"avatar"];
    
    //上传服务器
//    [[HSLoginClass new] uploadAvatar:totalPath];
    
    return isOk;
}

//从document取得图片
- (UIImage *)getImage:(NSString *)urlStr
{
    return [UIImage imageWithContentsOfFile:urlStr];
}


-(void)imagePickerMutilSelectorDidGetImages:(NSArray *)imageArray
{
    NSLog(@"imageArray==%@",imageArray);
//    importItems=[[NSMutableArrayalloc] initWithArray:imageArray copyItems:YES];
}
@end
