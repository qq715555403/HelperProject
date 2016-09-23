//
//  CirculationViewController.m
//  HelperProject
//
//  Created by hushijun on 15/9/2.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import "CirculationViewController.h"

@interface CirculationViewController ()

@end

@implementation CirculationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self testJiheBianli];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"集合遍历"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"集合遍历"];
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




/**
 *
 ios中常用的遍历运算方法
 
 遍历的目的是获取集合中的某个对象或执行某个操作，所以能满足这个条件的方法都可以作为备选：
 
 1、经典for循环
 2、for in (NSFastEnumeration)，若不熟悉可以参考《nshipster介绍NSFastEnumeration的文章》
 3、makeObjectsPerformSelector
 4、kvc集合运算符
 5、enumerateObjectsUsingBlock
 6、enumerateObjectsWithOptions(NSEnumerationConcurrent)
 7、dispatch_apply
 
 值得注意的
 对于集合中对象数很多的情况下，for in (NSFastEnumeration)的遍历速度非常之快，但小规模的遍历并不明显（还没普通for循环快）
 使用kvc集合运算符运算很大规模的集合时，效率明显下降（100万的数组离谱的21秒多），同时占用了大量内存和cpu
 enumerateObjectsWithOptions(NSEnumerationConcurrent)和dispatch_apply(Concurrent)的遍历执行可以利用到多核cpu的优势（实验中在双核cpu上效率基本上x2）
 
 倒序遍历
 NSArray和NSOrderedSet都支持使用reverseObjectEnumerator倒序遍历，如：

 NSArray *strings = @[@"1", @"2", @"3"];
 for (NSString *string in [strings reverseObjectEnumerator]) {
    NSLog(@"%@", string);
 }
 这个方法只在循环第一次被调用，所以也不必担心循环每次计算的问题。
 
 同时，使用enumerateObjectsWithOptions:NSEnumerationReverse也可以实现倒序遍历：
 [array enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(Sark *sark, NSUInteger idx, BOOL *stop) {
    [sark doSomething];
 }];
 
 
 使用block同时遍历字典key，value
 block版本的字典遍历可以同时取key和value（forin只能取key再手动取value），如：
 NSDictionary *dict = @{@"a": @"1", @"b": @"2"};
 [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    NSLog(@"key: %@, value: %@", key, obj);
 }];
 
 对于耗时且顺序无关的遍历，使用并发版本
 [array enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(Sark *sark, NSUInteger idx, BOOL *stop) {
    [sark doSomethingSlow];
 }];
 
 
 *
 *
 */
//集合遍历常用方法及效率
-(void)testJiheBianli
{
    
}



@end
