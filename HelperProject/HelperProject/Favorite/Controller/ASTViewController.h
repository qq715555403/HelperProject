//
//  ASTViewController.h
//  HelperProject
//
//  Created by hushijun on 15/10/9.
//  Copyright © 2015年 hushijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASTViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *arry;
@property (strong, nonatomic) IBOutlet UILabel *lblTest;
@property (strong, nonatomic) IBOutlet UIScrollView *myScroll;
@property (strong, nonatomic) IBOutlet UITableView *tblView;
@end
