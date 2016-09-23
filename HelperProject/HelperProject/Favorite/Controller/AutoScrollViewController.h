//
//  AutoScrollViewController.h
//  HelperProject
//
//  Created by hushijun on 15/9/18.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoScrollViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *arry;
@property (strong, nonatomic) IBOutlet UITableView *tblView;
@end
