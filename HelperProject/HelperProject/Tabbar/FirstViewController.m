//
//  FirstViewController.m
//  HelperProject
//
//  Created by hushijun on 15/8/8.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title=@"常用功能";

    _arryData=@[
                @{@"title":@"省市区地址选择器",@"vc":@"AddressViewController"},
                @{@"title":@"评分详情",@"vc":@"PingfenViewController"},
                @{@"title":@"自动布局简单练习",@"vc":@"AutoViewController"},
                @{@"title":@"自动布局Scrollview",@"vc":@"AutoScrollViewController"},
                @{@"title":@"自动布局Scrollview2",@"vc":@"AutoScrollTwoViewController"},
                @{@"title":@"自动布局Scrollview3",@"vc":@"ASTViewController"},
                @{@"title":@"自动布局Scroll4-代码实现",@"vc":@"CodeScrollViewController"},
                
                
                @{@"title":@"可复制的标签",@"vc":@"CopyLabelViewController"},
                @{@"title":@"webview加载进度条",@"vc":@"WebviewProgressViewController"},
                @{@"title":@"我的订单",@"vc":@"MyOrderListUIViewController"},
                @{@"title":@"自定义数字键盘",@"vc":@"CustomKeyboardViewController"},
                @{@"title":@"仿微信摇一摇",@"vc":@"ShakeViewController"},
                @{@"title":@"Window测试",@"vc":@"WindowTestViewController"},
                @{@"title":@"仿QQ搜索",@"vc":@"BTViewController"},
                @{@"title":@"自动布局-Runtime",@"vc":@"CounterViewController"},
                @{@"title":@"常用集合视图控制器",@"vc":@"CirculationViewController"},
                @{@"title":@"FDCalendar日历控件",@"vc":@"CalendarViewController"},
                
                @{@"title":@"设备硬件信息",@"vc":@"DeviceViewController"}
                
                
                ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arryData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *identify=@"mycell";
//    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
//    if (!cell) {
//        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
//    }
//    
//    cell.textLabel.text=_arryData[indexPath.row];
//
//    return cell;
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMCell" forIndexPath:indexPath];
    
    NSDictionary *dicTemp=_arryData[indexPath.row];
    cell.textLabel.text=dicTemp[@"title"];
    cell.detailTextLabel.text=@"test";
    
//    cell.imageView.image=LoadBundleImageByName(@"jiance/one/jc_one_cell_gps.png");
//
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://wx.leleda.com/wapios/companyimg/220bc3925b77ad9f21a1eb5b82c87fde.png"]];
    
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://wx.leleda.com/wapios/companyimg/220bc3925b77ad9f21a1eb5b82c87fde.png"] placeholderImage:[UIImage imageNamed:@"placeholder"] options:SDWebImageRefreshCached];
    
//    这里设置frame没什么效果
//    cell.imageView.frame=CGRectMake(10, 10,15, 15);
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=860146141,1633656976&fm=116&gp=0.jpg"] placeholderImage:[UIImage imageNamed:@"placeholder"] options:SDWebImageRefreshCached];
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dicTemp=_arryData[indexPath.row];
    NSString *strVC=dicTemp[@"vc"];
    
    if (indexPath.row==0) {
        AddressViewController *avc=[[AddressViewController alloc]init];
        [self.navigationController pushViewController:avc animated:YES];
        
//        id obj=[[NSClassFromString(@"AddressViewController") alloc] init];
//        UINavigationController *navc=[[UINavigationController alloc]initWithRootViewController:obj];
//        [self.navigationController presentViewController:navc animated:YES completion:nil];
    }
//    else if(indexPath.row==1){
//        PingfenViewController *pvc=[[PingfenViewController alloc]initWithNibName:@"PingfenViewController" bundle:nil];
//        pvc.title=dicTemp[@"title"];
//        [self.navigationController pushViewController:pvc animated:YES];
//    }
    else if(indexPath.row==5){ //加载sb中的vc
//        ASTViewController *avc=[[ASTViewController alloc]init];
//        self.navigationController.navigationBar.translucent=NO;
//        [self.navigationController pushViewController:avc animated:YES];
        
        NSLog(@"strVC===%@",strVC);
        
        UIViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:strVC];
        next.title=strVC;
        [self.navigationController pushViewController:next animated:YES];
        
    }else{
        
//
        id obj=[[NSClassFromString(strVC) alloc] init];
        UIViewController *vc=(UIViewController *)obj;
        vc.title=dicTemp[@"title"];
        self.navigationController.navigationBar.translucent=NO;
        [self.navigationController pushViewController:obj animated:YES];

    
//        [self performSegueWithIdentifier:@"CopyLabelViewController" sender:nil];


////        DeviceViewController *cvc=[[DeviceViewController alloc]initWithNibName:@"DeviceViewController.xib" bundle:nil];
//        DeviceViewController *cvc=[[DeviceViewController alloc]init];
//        [self.navigationController pushViewController:cvc animated:YES];
        
    }
}

@end
