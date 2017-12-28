//
//  RootTabBarViewController.m
//  FireEquipment
//
//  Created by mc on 2017/10/24.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "HomeViewController.h"
#import "MyViewController.h"
#import "BaseNavigationViewController.h"
@interface RootTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation RootTabBarViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.selectedIndex = 0;
    // [self.view addGestureRecognizer:self.panGestureRecognizer];
    
//    [self deleteData];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //创建主页控制器
    HomeViewController *manCV=[[HomeViewController alloc] init];
    BaseNavigationViewController *mainNV=[[BaseNavigationViewController alloc] initWithRootViewController:manCV];
    
    //设置导航栏背景图片
    mainNV.navigationBar.translucent=YES;
    [self addSubViewController:mainNV andTitle:nil andNormalImage:@"shouye.png" andSelectedImage:@"shouye.png拷贝"];
    //创建我的控制器
    BaseNavigationViewController *MyNV=[[BaseNavigationViewController alloc] initWithRootViewController:[[MyViewController alloc] init]];
    //设置导航栏背景图片
    [self addSubViewController:MyNV andTitle:nil andNormalImage:@"wode.png拷贝" andSelectedImage:@"wode.png"];
}

//添加tabbar
-(void)addSubViewController:(UINavigationController *)BarController andTitle:(NSString *)titile andNormalImage:(NSString *)image andSelectedImage:(NSString *)selectImage{
    
    //设置标题
     [BarController.tabBarItem setTitle:titile];
    //设置没有选择是的图片
    [BarController.tabBarItem setImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //设置选择时的图片
    [BarController.tabBarItem setSelectedImage:[[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //更改文字的颜色(被选择时)
    [BarController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:KRGB(254, 65, 181, 1.0)} forState:UIControlStateSelected];
    [BarController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0f]} forState:UIControlStateNormal];
    BarController.tabBarItem.imageInsets=UIEdgeInsetsMake(6, 0, -6, 0);
    
    [self addChildViewController:BarController];
}




//-(void)deleteData{
//
//    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
//    [defaults removeObjectForKey:@"KdetailImageArr"];
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
