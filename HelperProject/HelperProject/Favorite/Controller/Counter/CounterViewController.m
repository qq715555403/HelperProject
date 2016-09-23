//
//  CounterViewController.m
//  HelperProject
//
//  Created by hushijun on 15/8/31.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import "CounterViewController.h"

@interface CounterViewController ()

@end

@implementation CounterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self exp4];
    
    _reference=[[PlantReference alloc]init];
    _reference.waterIndex=3;
    _reference.sumIndex=5;
    _reference.temperatureIndex=2;
    _reference.electrolyteIndex=4;
    _reference.name=@"海棠01";
    _reference.brief=@"乔木，高可达8米；小枝粗壮，圆柱形，幼时具短柔毛，逐渐脱落，老时红褐色或紫褐色，无毛；冬芽卵形，先端渐尖，微被柔毛，紫褐色，有数枚外露鳞片。叶片椭圆形至长椭圆形，长5-8厘米，宽2-3厘米，先端短渐尖或圆钝，基部宽楔形或近圆形，边缘有紧贴细锯齿，有时部分近于全缘，幼嫩时上下两面具稀疏短柔毛，以后脱落，老叶无毛；叶柄长1.5-2厘米，具短柔毛；托叶膜质，窄披针形，先端渐尖，全缘，内面具长柔毛。花序近伞形，有花4-6朵，花梗长2-3厘米，具柔毛；苞片膜质，披针形，早落；花直径4-5厘米；萼筒外面无毛或有白色绒毛；萼片三角卵形，先端急尖，全缘，外面无毛或偶有稀疏绒毛，内面密被白色绒毛，萼片比萼筒稍短；花瓣卵形，长2-2.5厘米，宽1.5-2厘米，基部有短爪，白色，在芽中呈粉红色；雄蕊20-25，花丝长短不等，长约花瓣之半；花柱5，稀4，基部有白色绒色，比雄蕊稍长。果实近球形，直径2厘米，黄色，萼片宿存，基部不下陷，梗洼隆起；果梗细长，先端肥厚，长3-4厘米。花期4-5月，果期8-9月。";
    
    
    [self createUI];
    
    //运行时练习：运行时创建方法：resolveAdd:
    [self performSelector:@selector(resolveAdd:) withObject:@"test"];
    
    [self runtimeTest];
    
    NSString *strTest=@"我是测试runtime的";
//    [strTest count];
    
//    [strTest objectAtIndex:0]
    
//    [strTest makeObjectsPerformSelector:@selector(test) withObject:nil];
    
}

-(void) test
{
    NSLog(@"test~~");
}

//测试方法交换
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    [MobClick beginLogPageView:@"自动布局"];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"自动布局"];
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


// exp1: 中心点与self.view相同，宽度为400*400
-(void)exp1{
    UIView *view = [UIView new];
    [view setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(400,400));
    }];
}
//exp2: 上下左右边距都为10
-(void)exp2{
    UIView *view = [UIView new];
    [view setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
        //  make.left.equalTo(self.view).with.offset(10);
        //  make.right.equalTo(self.view).with.offset(-10);
        //  make.top.equalTo(self.view).with.offset(10);
        //  make.bottom.equalTo(self.view).with.offset(-10);
    }];
}
//exp3 让两个高度为150的view垂直居中且等宽且等间隔排列 间隔为10
-(void)exp3{
    UIView *view1 = [UIView new];
    [view1 setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:view1];
    UIView *view2 = [UIView new];
    [view2 setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:view2];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.height.mas_equalTo(150);
        make.width.mas_equalTo(view2.mas_width);
        make.left.mas_equalTo(self.view.mas_left).with.offset(10);
        make.right.mas_equalTo(view2.mas_left).offset(-10);
    }];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.height.mas_equalTo(150);
        make.width.mas_equalTo(view1.mas_width);
        make.left.mas_equalTo(view1.mas_right).with.offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
    }];
}


-(void)keyViewTaped:(UITapGestureRecognizer *) gest
{
    UIButton *btn=(UIButton *)gest.view;
    NSString *keyStr=btn.titleLabel.text;
    NSLog(@"btn.title==%@",keyStr);
    
    NSString *haveStr=_displayNum.text;
    if ([keyStr isEqualToString:@"AC"]) {
        if (haveStr.length==1) {
            _displayNum.text=@"0";
        }else{
            _displayNum.text=[haveStr substringToIndex:haveStr.length-1];
        }
        
    }else{
        if (haveStr.length==1 && [haveStr isEqualToString:@"0"]) {
            _displayNum.text=keyStr;
        }else{
            NSString *str=[NSString stringWithFormat:@"%@%@",_displayNum.text,keyStr];
            _displayNum.text=str;
        }
    }
    
    
}
//高级布局练习 ios自带计算器布局
-(void)exp4{
    //申明区域，displayView是显示区域，keyboardView是键盘区域
    UIView *displayView = [UIView new];
    [displayView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:displayView];
    UIView *keyboardView = [UIView new];
    keyboardView.userInteractionEnabled=YES;
    [self.view addSubview:keyboardView];
    //先按1：3分割 displView（显示结果区域）和 keyboardView（键盘区域）
    [displayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.and.right.equalTo(self.view);
        make.height.equalTo(keyboardView).multipliedBy(0.3f);
    }];
    [keyboardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(displayView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.and.right.equalTo(self.view);
    }];
    //设置显示位置的数字为0
    UILabel *displayNum = [[UILabel alloc]init];
    _displayNum=displayNum;
    [displayView addSubview:_displayNum];
    displayNum.text = @"0";
    displayNum.font = [UIFont fontWithName:@"HeiTi SC" size:70];
    displayNum.textColor = [UIColor whiteColor];
    displayNum.textAlignment = NSTextAlignmentRight;
    [displayNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(displayView).with.offset(-10);
        make.bottom.equalTo(displayView).with.offset(-10);
    }];
    //定义键盘键名称，？号代表合并的单元格
    NSArray *keys = @[@"AC",@"+/-",@"%",@"÷"
                      ,@"7",@"8",@"9",@"x"
                      ,@"4",@"5",@"6",@"-"
                      ,@"1",@"2",@"3",@"+"
                      ,@"0",@"?",@".",@"="];
    int indexOfKeys = 0;
    for (NSString *key in keys){
        //循环所有键
        indexOfKeys++;
        int rowNum = indexOfKeys %4 ==0? indexOfKeys/4:indexOfKeys/4 +1;
        int colNum = indexOfKeys %4 ==0? 4 :indexOfKeys %4;
        NSLog(@"index is:%d and row:%d,col:%d",indexOfKeys,rowNum,colNum);
        //键样式
        UIButton *keyView = [UIButton buttonWithType:UIButtonTypeCustom];
        [keyboardView addSubview:keyView];
        [keyView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [keyView setTitle:key forState:UIControlStateNormal];
        [keyView.layer setBorderWidth:1];
        [keyView.layer setBorderColor:[[UIColor blackColor]CGColor]];
        [keyView.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:30]];
        
        //添加点击手势
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyViewTaped:)];
        tap.numberOfTapsRequired=1;
        [keyView addGestureRecognizer:tap];
        
        
        
        //键约束
        [keyView mas_makeConstraints:^(MASConstraintMaker *make) {
            //处理 0 合并单元格
            if([key isEqualToString:@"0"] || [key isEqualToString:@"?"] ){
                if([key isEqualToString:@"0"]){
                    [keyView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.height.equalTo(keyboardView.mas_height).with.multipliedBy(.2f);
                        make.width.equalTo(keyboardView.mas_width).multipliedBy(.5);
                        make.left.equalTo(keyboardView.mas_left);
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.9f);
                    }];
                }if([key isEqualToString:@"?"]){
                    [keyView removeFromSuperview];
                }
            }
            //正常的单元格
            else{
                make.width.equalTo(keyboardView.mas_width).with.multipliedBy(.25f);
                make.height.equalTo(keyboardView.mas_height).with.multipliedBy(.2f);
                //按照行和列添加约束，这里添加行约束
                switch (rowNum) {
                    case 1:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.1f);
                        keyView.backgroundColor = [UIColor colorWithRed:205 green:205 blue:205 alpha:1];
                    }
                        break;
                    case 2:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.3f);
                    }
                        break;
                    case 3:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.5f);
                    }
                        break;
                    case 4:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.7f);
                    }
                        break;
                    case 5:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.9f);
                    }
                        break;
                    default:
                        break;
                }
                //按照行和列添加约束，这里添加列约束
                switch (colNum) {
                    case 1:
                    {
                        make.left.equalTo(keyboardView.mas_left);
                    }
                        break;
                    case 2:
                    {
                        make.right.equalTo(keyboardView.mas_centerX);
                    }
                        break;
                    case 3:
                    {
                        make.left.equalTo(keyboardView.mas_centerX);
                    }
                        break;
                    case 4:
                    {
                        make.right.equalTo(keyboardView.mas_right);
                        [keyView setBackgroundColor:[UIColor colorWithRed:243 green:127 blue:38 alpha:1]];
                    }
                        break;
                    default:
                        break;
                }
            }
        }];
    }
}


//
//把块拆分为四行
-(void)createIndexUIWithView:(UIView *)view{
    //拆分四行
    UIView *row1 = [UIView new];
    UIView *row2 = [UIView new];
    UIView *row3 = [UIView new];
    UIView *row4 = [UIView new];
    [view addSubview:row1];
    [view addSubview:row2];
    [view addSubview:row3];
    [view addSubview:row4];
    [row1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.left.equalTo(view);
        make.height.equalTo(view.mas_height).multipliedBy(0.25);
        make.top.equalTo(view.mas_top);
    }];
    [row2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.left.equalTo(view);
        make.top.equalTo(row1.mas_bottom);
        make.height.equalTo(view.mas_height).multipliedBy(0.25);
    }];
    [row3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right);
        make.top.equalTo(row2.mas_bottom);
        make.height.equalTo(view.mas_height).multipliedBy(0.25);
        make.left.equalTo(view.mas_left);
    }];
    [row4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.left.equalTo(view);
        make.top.equalTo(row3.mas_bottom);
        make.height.equalTo(view.mas_height).multipliedBy(0.25);
    }];
    
    
    
    [self createIndexRowUI:PlantReferenceWaterIndex withUIView:row1];
    [self createIndexRowUI:PlantReferenceSumIndex withUIView:row2];
    [self createIndexRowUI:PlantReferenceTemperatureIndex withUIView:row3];
    [self createIndexRowUI:PlantReferenceElectrolyteIndex withUIView:row4];
}
//构造每行的UI
-(void)createIndexRowUI:(PlantReferenceIndex) index withUIView:(UIView *)view{
    //index标题
    UILabel *indexTitle = [UILabel new];
    indexTitle.font = [UIFont fontWithName:@"HeiTi SC" size:14];
    indexTitle.textColor = [UIColor colorWithWhite:0.326 alpha:1.000];
    [view addSubview:indexTitle];
    [indexTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).with.offset(20);
        make.centerY.equalTo(view.mas_centerY);
    }];
    switch (index) {
        case PlantReferenceWaterIndex:
        {
            indexTitle.text = @"水分";
            UIImageView * current;
            for(int i=1;i<=5;i++){
                if(i<_reference.waterIndex){
                    current = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_water_light"]];
                }else{
                    current = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_water_dark"]];
                }
                [view addSubview:current];
                //间距12%，左边留空30%
                [current mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(view.mas_right).with.multipliedBy(0.12*(i-1) +0.3);
                    make.centerY.equalTo(view.mas_centerY);
                }];
            }
        }
            break;
        case PlantReferenceSumIndex:
        {
            indexTitle.text = @"光照";
            UIImageView * current;
            for(int i=1;i<=5;i++){
                if(i<_reference.sumIndex){
                    current = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_summer_light"]];
                }else{
                    current = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_summer_dark"]];
                }
                [view addSubview:current];
                //间距12%，左边留空30%
                [current mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(view.mas_right).with.multipliedBy(0.12*(i-1) +0.3);
                    make.centerY.equalTo(view.mas_centerY);
                }];
            }
        }
            break;
        case PlantReferenceTemperatureIndex:
        {
            indexTitle.text = @"温度";
            UIImageView * current;
            for(int i=1;i<=5;i++){
                if(i<_reference.temperatureIndex){
                    current = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_temperature_light"]];
                }else{
                    current = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_temperature_dark"]];
                }
                [view addSubview:current];
                //间距12%，左边留空30%
                [current mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(view.mas_right).with.multipliedBy(0.12*(i-1) +0.3);
                    make.centerY.equalTo(view.mas_centerY);
                }];
            }
        }
            break;
        case PlantReferenceElectrolyteIndex:
        {
            indexTitle.text = @"肥料";
            UIImageView * current;
            for(int i=1;i<=5;i++){
                if(i<_reference.electrolyteIndex){
                    current = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_electolyte_light"]];
                }else{
                    current = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_electolyte_dark"]];
                }
                [view addSubview:current];
                //间距12%，左边留空30%
                [current mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(view.mas_right).with.multipliedBy(0.12*(i-1) +0.3);
                    make.centerY.equalTo(view.mas_centerY);
                }];
            }
        }
            break;
        default:
            break;
    }
}


//-(void)createUI{
//    UIView *titleView = [UIView new];
//    titleView.backgroundColor = [UIColor redColor];
//    UIView *caredView = [UIView new];
//    [self.view addSubview:caredView];
//    UIView *brifeView = [UIView new];
//    [self.view addSubview:brifeView];
//    //self.view
//    self.view.backgroundColor = [UIColor colorWithWhite:0.965 alpha:1.000];
//    //thrm
//    UIImageView *plantThrm = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"defalutPlantReferenceIcon"]];
//    plantThrm.backgroundColor=[UIColor greenColor];
//    [self.view addSubview:plantThrm];
//    [plantThrm mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.top.equalTo(self.view).with.offset(10);
//        make.width.and.height.equalTo(@100);
//        
//    }];
//    //title
//    [self.view addSubview:titleView];
//    UIImageView *bgTitleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg-plant-reference-title"]];
//    [titleView addSubview:bgTitleView];
//    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.view.mas_right);
//        make.left.equalTo(plantThrm.mas_right).with.offset(20);
//        make.centerY.equalTo(plantThrm.mas_centerY);
//    }];
//    [bgTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(titleView);
//    }];
//    UILabel *title = [[UILabel alloc]init];
//    title.textColor =  [UIColor whiteColor];
//    title.font = [UIFont fontWithName:@"Heiti SC" size:26];
//    //    title.text = _reference.name;
//    title.text = @"海棠03";
//    [titleView addSubview:title];
//    [title mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(titleView.mas_left).offset(10);
//        make.width.equalTo(titleView.mas_width);
//        make.centerY.equalTo(titleView.mas_centerY);
//    }];
//    //植物养护
//    UILabel *caredTitle = [[UILabel alloc]init];
//    caredTitle.textColor =  [UIColor colorWithRed:0.172 green:0.171 blue:0.219 alpha:1.000];
//    caredTitle.font = [UIFont fontWithName:@"Heiti SC" size:10];
//    caredTitle.text = @"植物养护";
//    [self.view addSubview:caredTitle];
//    [caredTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(plantThrm.mas_bottom).with.offset(20);
//        make.left.and.right.equalTo(self.view).with.offset(10);
//        make.height.mas_equalTo(10);
//    }];
//    //将图层的边框设置为圆脚
//    caredView.layer.cornerRadius = 5;
//    caredView.layer.masksToBounds = YES;
//    //给图层添加一个有色边框
//    caredView.layer.borderWidth = 1;
//    caredView.layer.borderColor = [[UIColor colorWithWhite:0.521 alpha:1.000] CGColor];
//    caredView.backgroundColor = [UIColor whiteColor];
//    [caredView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(caredTitle.mas_bottom).with.offset(5);
//        make.left.equalTo(self.view.mas_left).with.offset(10);
//        make.right.equalTo(self.view.mas_right).with.offset(-10);
//        make.height.equalTo(brifeView);
//    }];
//    
//    [self createIndexUIWithView:caredView];
//    
//    
//    
//    //植物简介
//    UILabel *brifeTitle = [[UILabel alloc]init];
//    brifeTitle.textColor =  [UIColor colorWithRed:0.172 green:0.171 blue:0.219 alpha:1.000];
//    brifeTitle.font = [UIFont fontWithName:@"Heiti SC" size:10];
//    brifeTitle.text = @"植物简介";
//    [self.view addSubview:brifeTitle];
//    [brifeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(caredView.mas_bottom).with.offset(20);
//        make.left.and.right.equalTo(self.view).with.offset(10);
//        make.height.mas_equalTo(10);
//    }];
//    //将图层的边框设置为圆脚
//    brifeView.layer.cornerRadius = 5;
//    brifeView.layer.masksToBounds = YES;
//    //给图层添加一个有色边框
//    brifeView.layer.borderWidth = 1;
//    brifeView.layer.borderColor = [[UIColor colorWithWhite:0.521 alpha:1.000] CGColor];
//    brifeView.backgroundColor = [UIColor whiteColor];
//    [brifeView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(brifeTitle.mas_bottom).with.offset(5);
//        make.left.equalTo(self.view.mas_left).with.offset(10);
//        make.right.equalTo(self.view.mas_right).with.offset(-10);
//        make.bottom.equalTo(self.view.mas_bottom).with.offset(-10);
//        make.height.equalTo(caredView);
//    }];
//}


//在步骤1createui的基础上，做了一些微调。
-(void)createUI{
    self.title = _reference.name;
    
    UIView *caredView = [UIView new];
    [self.view addSubview:caredView];
    
    UITextView *brifeView = [UITextView new];
    [self.view addSubview:brifeView];
    //self.view
    self.view.backgroundColor = [UIColor colorWithWhite:0.965 alpha:1.000];
    
    //thrm
    UIImageView *plantThrm = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"defalutPlantReferenceIcon"]];
    [self.view addSubview:plantThrm];
    [plantThrm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(self.view).with.offset(10);
        make.width.and.height.equalTo(self.view.mas_height).multipliedBy(0.15);
    }];
    
    //title
    UIView *titleView = [UIView new];
    [self.view addSubview:titleView];
//    UIImageView *bgTitleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg-plant-reference-title"]];
    UIImageView *bgTitleView = [[UIImageView alloc]init];
    bgTitleView.backgroundColor=[UIColor greenColor];
    [titleView addSubview:bgTitleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(plantThrm.mas_right).with.offset(20);
        make.centerY.equalTo(plantThrm.mas_centerY);
        make.height.equalTo(@40);
    }];
    [bgTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(titleView);
    }];
    UILabel *title = [[UILabel alloc]init];
    title.textColor =  [UIColor whiteColor];
    title.font = [UIFont fontWithName:@"Heiti SC" size:26];
    title.text = _reference.name;
    [titleView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleView.mas_left).offset(10);
        make.width.equalTo(titleView.mas_width);
        make.centerY.equalTo(titleView.mas_centerY);
        make.height.equalTo(@30);
    }];
    //植物养护
    UILabel *caredTitle = [[UILabel alloc]init];
    caredTitle.textColor =  [UIColor colorWithRed:0.172 green:0.171 blue:0.219 alpha:1.000];
    caredTitle.font = [UIFont fontWithName:@"Heiti SC" size:10];
    caredTitle.text = @"植物养护";
    [self.view addSubview:caredTitle];
    [caredTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(plantThrm.mas_bottom).with.offset(20);
        make.left.and.right.equalTo(self.view).with.offset(10);
        make.height.mas_equalTo(10);
    }];
    //植物养护 数据
    [self createIndexUIWithView:caredView];
    //将图层的边框设置为圆脚
    caredView.layer.cornerRadius = 5;
    caredView.layer.masksToBounds = YES;
    //给图层添加一个有色边框
    caredView.layer.borderWidth = 1;
    caredView.layer.borderColor = [[UIColor colorWithWhite:0.521 alpha:1.000] CGColor];
    caredView.backgroundColor = [UIColor whiteColor];
    [caredView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(caredTitle.mas_bottom).with.offset(5);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.height.equalTo(brifeView);
    }];
    //植物简介
    UILabel *brifeTitle = [[UILabel alloc]init];
    brifeTitle.textColor =  [UIColor colorWithRed:0.172 green:0.171 blue:0.219 alpha:1.000];
    brifeTitle.font = [UIFont fontWithName:@"Heiti SC" size:10];
    brifeTitle.text = @"植物简介";
    [self.view addSubview:brifeTitle];
    [brifeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(caredView.mas_bottom).with.offset(20);
        make.left.and.right.equalTo(self.view).with.offset(10);
        make.height.mas_equalTo(10);
    }];
    //将图层的边框设置为圆脚
    brifeView.layer.cornerRadius = 5;
    brifeView.layer.masksToBounds = YES;
    //给图层添加一个有色边框
    brifeView.layer.borderWidth = 1;
    brifeView.layer.borderColor = [[UIColor colorWithWhite:0.447 alpha:1.000] CGColor];
    brifeView.backgroundColor = [UIColor whiteColor];
    //文字样式
    //    brifeView.textColor = [UIColor colorWithWhite:0.352 alpha:1.000];
    //    brifeView.font = [UIFont fontWithName:@"HeiTi SC" size:12];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = 20.f;
    paragraphStyle.maximumLineHeight = 25.f;
    paragraphStyle.minimumLineHeight = 15.f;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:12], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor colorWithWhite:0.447 alpha:1.000]};
    //植物简介数据
    //brifeView.text = _reference.brief;
    brifeView.attributedText = [[NSAttributedString alloc] initWithString: _reference.brief attributes:attributes];
    [brifeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(brifeTitle.mas_bottom).with.offset(5);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-10);
        make.height.equalTo(caredView);
    }];
}


- (void) runtimeTest
{
//    unsigned int count;
//    //获取属性列表
//    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
//    for (unsigned int i=0; i%@", [NSString stringWithUTF8String:propertyName]);
//         
//    }
//     //获取方法列表
//     Method *methodList = class_copyMethodList([self class], &count);
//     for (unsigned int i; i%@", NSStringFromSelector(method_getName(method)));
//     
//     }
//    //获取成员变量列表
//    Ivar *ivarList = class_copyIvarList([self class], &count);
//    for (unsigned int i; i%@", [NSString stringWithUTF8String:ivarName]);
//    
//    }
//    //获取协议列表
//    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
//    for (unsigned int i; i%@", [NSString stringWithUTF8String:protocolName]);
//         
//    }
    
    NSLog(@"runtime时，获取当前类的实例变量列表、属性列表、方法列表和协议里诶包");
    
    u_int count;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (int i = 0; i<count; i++) {
        const char *ivarName = ivar_getName(ivarList[i]);
        NSString *strName = [NSString stringWithCString:ivarName encoding:NSUTF8StringEncoding];
        NSLog(@"ivar %@",strName);
    }
    
    //    u_int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i<count; i++) {
        const char *propertyName = property_getName(properties[i]);
        NSString *strName = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        NSLog(@"Property %@",strName);
    }
    
    //    u_int count;
    Method *methods = class_copyMethodList([self class], &count);
    for (int i = 0; i<count; i++) {
        SEL name = method_getName(methods[i]);
        NSString *strName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        NSLog(@"method %@",strName);
    }
    
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([UIView class], &count);
    for (int i = 0; i<count; i++) {
        const char * protocolName = protocol_getName(protocolList[i]);
        NSString *strName = [NSString stringWithCString:protocolName encoding:NSUTF8StringEncoding];
        NSLog(@"Protocol %@",strName);
    }
}


//runtime练习
////隐式调用方法
//[target performSelector:@selector(resolveAdd:) withObject:@"test"];
//然后，在target对象内部重写拦截调用的方法，动态添加方法。

void runAddMethod(id self, SEL _cmd, NSString *string){
    NSLog(@"运行时添加方法：add C IMP %@", string);
}

//NSObject 类的拦截异常的方法：默认返回no，自己处理之后返回yes
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    //给本类动态添加一个方法
    if ([NSStringFromSelector(sel) isEqualToString:@"resolveAdd:"]) {
        class_addMethod(self, sel, (IMP)runAddMethod, "v@:*");
    }
    return YES;
}

@end
