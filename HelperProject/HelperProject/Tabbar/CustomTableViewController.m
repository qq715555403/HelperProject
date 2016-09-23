//
//  CustomTableViewController.m
//  HelperProject
//
//  Created by hushijun on 15/8/25.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import "CustomTableViewController.h"

@interface CustomTableViewController ()

@end

@implementation CustomTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //ios7之后可用：cell高度自适应：1、设置下面2个属性；2、自定义cell 使用自动布局
    self.tableView.estimatedRowHeight=80;
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    
    
    _array=[NSMutableArray arrayWithArray:@[
    @{@"img":@"jc_one_cell_gps.png",@"vc":@"TestViewController",@"desc":@"TestViewController 是用于测试自动布局的基本vc"},
    @{@"img":@"jc_one_cell_jiasu.png",@"vc":@"AutoTestTwoViewController",@"desc":@"AutoTestTwoViewController 是用于测试不同的tableviewcell跳转的问题"},
    @{@"img":@"jc_one_cell_lanya.png",@"vc":@"AutoTestThreeViewController",@"desc":@"AutoTestThreeViewController 也是用于测试不同cell跳转不同页面 for thisUncomment the following line to display an Edit button in the navigation bar for thisUncomment the following line to display an Edit button in the navigation bar for this"}
    ]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _array.count;
}

/**/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    
    UIImageView *imgView=(UIImageView *)[cell viewWithTag:100];
    UILabel *lbl1=(UILabel *)[cell viewWithTag:101];
    UILabel *lbl2=(UILabel *)[cell viewWithTag:102];
    
    NSDictionary *dic=_array[indexPath.row];
    
    NSString *strImg=dic[@"img"];
    strImg=[NSString stringWithFormat:@"jiance/one/%@",strImg];
    imgView.image=LoadBundleImageByName(strImg);
    
    lbl1.text=dic[@"vc"];
    lbl2.text=dic[@"desc"];
    // Configure the cell...
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    //    UIStoryboard *board = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    NSDictionary *dic=_array[indexPath.row];
    NSString *strVC=dic[@"vc"];
    NSLog(@"strVC===%@",strVC);
    UIViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:strVC];
    next.title=strVC;
    [self.navigationController pushViewController:next animated:YES];
    
    
    /**
     *  跳转有两种方式：
        1、使用performSegueWithIdentifier:sender:
        2、使用instantiateViewControllerWithIdentifier
        
     ViewController之间的跳转
     1、如果在 Storyboard中当前的 ViewController和要跳转的ViewController之间的segue存在，则可以执行performSegueWithIdentifier:sender:这个方法实现跳转。
     2、如果目标ViewController存在Storyboard中，但是没有segue。你可以通过UIStoryboard的instantiateViewControllerWithIdentifier:这个方法获取到它，然后再用你想要的方式实现跳转，如：压栈。
     3、如果目标ViewController不存在，那就去创建它吧。
     */
//    NSDictionary *dic=_array[indexPath.row];
//    NSString *strVC=dic[@"lbl1"];
//    [self performSegueWithIdentifier:strVC sender:self];
    
    


}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/**/
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.

////    if ([segue.identifier isEqualToString:@"AddPlayer"]) {
////        
////        UINavigationController *navigationController = segue.destinationViewController;
////        PlayerDetailsViewController *playerDetailsViewController = [navigationController viewControllers][0];
////        playerDetailsViewController.delegate = self;
////    }
////    
////    else if ([segue.identifier isEqualToString:@"detail"]){
////        DetailsViewController *detailsViewController = segue.destinationViewController;
////        self.detailsVC=detailsViewController;
////        Player *player = (self.players)[_selectedIndex];
////        detailsViewController.pName=player.name;
////        detailsViewController.pGame=player.game;
////        detailsViewController.pRating=[NSString stringWithFormat:@"%d",player.rating];
////    }
// 
//}

//从子页面返回首页
- (IBAction)unwindSegueToCustomViewController:(UIStoryboardSegue *)segue
{
    //    segue.sourceViewController可以获取到返回的视图控制器对象
    UIViewController *sourceViewController = segue.sourceViewController;
    
    if ([sourceViewController isKindOfClass:[TestViewController class]]) {
        NSLog(@"from TestViewController vc");
    }
    else if ([sourceViewController isKindOfClass:[AutoLayoutViewController class]]) {
        NSLog(@"from AutoLayoutViewController vc");
    }

}
- (IBAction)pushNext:(id)sender {
//    [self performSegueWithIdentifier:@"TestViewController" sender:self];
}

@end
