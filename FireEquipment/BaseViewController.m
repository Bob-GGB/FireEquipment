//
//  BaseViewController.m
//  FireEquipment
//
//  Created by mc on 2017/10/19.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "BaseViewController.h"
//#import "WRNavigationBar.h"
@interface BaseViewController ()

@end

@implementation BaseViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    //导航栏没有透明度的时候,Y值的原点就跑到导航栏下面了,加这一句代码即可调整到原点
    [self setExtendedLayoutIncludesOpaqueBars:YES];
}


//-(void)setLeftBarButtonItemWithImageName:(NSString *)name andTitle:(NSString *)title{
//    
////    self.navigationItem.leftBarButtonItem = nil;
//    self.navigationItem.hidesBackButton = YES;
//    UIButton *leftBarButton=[UIButton buttonWithType:UIButtonTypeCustom];
//    [leftBarButton setFrame:CGRectMake(0, 0, 44, 44)];
//    [leftBarButton setTitle:title forState:UIControlStateNormal];
//    leftBarButton.titleLabel.font=[UIFont systemFontOfSize:13.0f];
//    //    [leftBarButton setBackgroundColor:[UIColor redColor]];
//    leftBarButton.imageEdgeInsets=UIEdgeInsetsMake(5,-30,0,0);
//    [leftBarButton
//     setTitleEdgeInsets:UIEdgeInsetsMake(5,-50,0,0)];
//    [leftBarButton setImage:[UIImage imageNamed:name]forState:UIControlStateNormal];
//    [leftBarButton addTarget:self action:@selector(leftBarButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
//    
//    //将右侧按钮右移修改方法
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0.0, 60, 44)];
//    
//    [view addSubview:leftBarButton];
//    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:view]];
////    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
////    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
////    
//    
//}
//
//-(void)leftBarButtonDidPress:(UIButton *)sender{
//    
//    [self.navigationController popViewControllerAnimated:YES];
//    
//    
//}
//
//
//
//-(void)setrightBarButtonItemWithImageName:(NSString *)name andTitle:(NSString *)title{
//    
//    UIButton *rightBarButton=[UIButton buttonWithType:UIButtonTypeSystem];
//    [rightBarButton setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
//    [rightBarButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
//    [rightBarButton setTitle:title forState:UIControlStateNormal];
//    [rightBarButton.titleLabel setTextColor:[UIColor whiteColor]];
//    //    [rightBarButton setBackgroundColor:[UIColor redColor]];
//    [rightBarButton addTarget:self action:@selector(rightBarButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
//    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:rightBarButton]];
////    if (name==nil) {
////        [rightBarButton setFrame:CGRectMake(20, 0, 100, 44)];
////        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 44.0)];
////
////        _rightBarButtons=rightBarButton;
////        [view addSubview:_rightBarButtons];
////
////        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:view]];
////    }
////    else{
////        [rightBarButton setFrame:CGRectMake(0, 0, 44 ,44)];
////        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 44, 44.0)];
////
////        _rightBarButtons=rightBarButton;
////        [view addSubview:_rightBarButtons];
////
////        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:view]];
////
////    }
//    
//}
//-(void)rightBarButtonDidPress:(UIButton *)sender{
//    
//    
//}

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

@end
