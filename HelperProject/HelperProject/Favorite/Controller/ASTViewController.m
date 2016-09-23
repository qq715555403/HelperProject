//
//  ASTViewController.m
//  HelperProject
//
//  Created by hushijun on 15/10/9.
//  Copyright © 2015年 hushijun. All rights reserved.
//

#import "ASTViewController.h"

@interface ASTViewController ()

@end

@implementation ASTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
//    self.lblTest.text=@"全是Scrollview的问题，而且意思基本上就是说IB无法确定ScrollView的宽度与高度，我们知道UIScrollView最重要的就是其contentSize的宽高了，如果这个无法确定，那scrollview就无法知晓可以滚动查看的区域。其实这仅仅是表象，IB不会因为contentSize的可见区域不确定而抱怨，因为它会有一个默认的可见区域就是其bounds,其实IB真正抱怨的是其内部的subViews的布局对于它的依赖，比如我们看最上面的橙色View相对于上、左、右的约束都相对于scrollview的。scrollview内部的subViews的约束全依赖于scrollview,这样子的话，问题就来了，Scrollview和UILabel、UIButton等这些控件一样都会根据内容调整其contentSize(autolayout布局模式中，UILabel这种控件都会根据内容对自身宽高进行调整),如果Scrollview要根据其subviews来调整自身的contentsize,而其subviews又要根据scrollview的contentsize调整自身的布局，是不是就矛盾了，就成了相互依赖了。所以IB要求UIScrollview(当然包括继承于它的UITableview、UIWebview这些控件)的contentSize必须在布局时能够确定。 由于Scrollview的contentSize由其subviews确定，其subviews的布局依赖于其父视图Scrollview的边界。这个矛盾，要不解决前者问题，要不解决后者，即要么不让UIScrollView的contentSize由其subviews确定，要么就让ScrollView的subviews不依赖其contentSize（即Scrollview的边界）。很显然，我们只能选择后者，因为前者你无法改变，其实从宏观上来看，改变了一个就相当于改变了两个，其实二者并没有什么特别区别，都是同一个问题导致的。既然我们想好了策略，就来试一下，如何才能让Scrollview的subviews不依赖于其边界呢？ 我们首先不考虑subviews的复杂布局情况，我们先把subviews嵌入到一个我们自己添加的ContainerView中，从而把我们的布局任务简化成Scrollview与ContainerView二者的约束关系，所有之前的subviews我们都放在ContainerView中，则subviews的约束就会仅仅依赖于ContainerView了，这些subviews不再与scrollview有直接关系。我们虽然简化了布局任务，但是还是无法绕过Scrollview的ContentSize的边界确定问题，我们前面已经知道了Scrollview的子视图不能依赖于ScrollView的边界，那我们就让其子视图不依赖于其边界即可。 国外有一个网友在遇到上面的问题的时候就咨询了Apple的工程师，结果他们画了40分钟才给出了解决方案，这说明Scrollview在autolayout中的使用真的不是那么简单。Apple的工程师给出的解决方案就是让我们的ContainerView建立一个与UIScrollview的父视图即我们的main view建立一个Equal Width,Equal Height约束，这样子ContainerView的宽高就不再依赖于ScrollView的边界了，但是ContainerView还是Scrollview的子视图，Scrollview的边界还是没有确定，我们还要为ContainerView添加与ScrollView的边界约束，用以帮忙ScrollView确定边界。---------我们建立了ContainerView与mainview的equal width与 equal height后，效果果然就是我们想要的。 关于Autolayout与Scrollview相遇的故事，我们就先讲到这里，关于布局的场景总是像国际象棋一样，有数不尽的步骤与结果，连Machine都可以为之苦恼，所以这里只是通过这么一个示例，让大家对autolayout的布局理念有一个更深入的认识，不要过多的去抓鱼，而要学会如何抓鱼，抓鱼的诀窍是什么，学习一门技术，大家都会有各自的体会与理解，从根本上去掌握技术的原理，以此来应对千变万化的场景才能事半功倍";
    
    self.lblTest.text=@"----我们建立了ContainerView与mainview的equal width与 equal height后，效果果然就是我们想要的。 关于Autolayout与Scrollview相遇的故事，我们就先讲到这里，关于布局的场景总是像国际象棋一样，有数不尽的步骤与结果，连Machine都可以为之苦恼，所以这里只是通过这么一个示例，让大家对autolayout的布局理念有一个更深入的认识，不要过多的去抓鱼，而要学会如何抓鱼，抓鱼的诀窍是什么，学习一门技术，大家都会有各自的体会与理解，从根本上去掌握技术的原理，以此来应对千变万化的场景才能事半功倍";
    
    
    _arry=[NSMutableArray array];
    for (NSInteger i=0; i<30; i++) {
        NSString *str=[NSString stringWithFormat:@"cell测试数据%d",(int)i];
        [_arry addObject:str];
    }
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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identy=@"cell";
    UITableViewCell *cell=nil;
    cell=[tableView dequeueReusableCellWithIdentifier:identy];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
    }
    
    
    cell.textLabel.text=_arry[indexPath.row];
    
    
    //以下这段代码是设置表格有多少行显示多少行，并让tableview显示全所有表格数据，在scrollview中撑开
    if(_tblView.frame.size.height != _tblView.contentSize.height)
    {
        CGRect newFrame = _tblView.frame;
        newFrame.size = _tblView.contentSize;
        _tblView.frame = newFrame;
        _myScroll.contentSize = CGSizeMake(self.view.bounds.size.width, _tblView.frame.origin.y + newFrame.size.height);
        
    }
    
    
    return cell;
}



@end
