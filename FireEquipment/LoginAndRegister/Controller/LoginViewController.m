//
//  LoginViewController.m
//  FireEquipment
//
//  Created by mc on 2017/10/23.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import <CommonCrypto/CommonDigest.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
     [self.navigationController.navigationBar setHidden:YES];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
     [self.navigationController.navigationBar setHidden:NO];
};
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:[UIColor cyanColor]];
    //删除本地保存的用户信息
    NSUserDefaults *defauts=[NSUserDefaults standardUserDefaults];
    [defauts removeObjectForKey:@"userInfoDic"];
    
    LoginView *view=[[LoginView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//   __weak LoginView *weakSelf = view;
    [view setSendController:^(UIViewController *controller,NSInteger btnTag) {
        if (btnTag==103) {
        
//             [self.navigationController pushViewController:controller animated:YES];
                    [self presentViewController:controller animated:YES completion:nil];

        }
        else{
            
        
        [self.navigationController pushViewController:controller animated:YES];
        }
    }];
    
    [self.view addSubview:view];

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

@end
