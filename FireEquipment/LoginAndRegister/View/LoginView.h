//
//  LoginView.h
//  FireEquipment
//
//  Created by mc on 2017/10/23.
//  Copyright © 2017年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView
@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UITextField *phoneLabel;
@property (nonatomic,strong) UITextField *passWordLabel;
@property (nonatomic,strong) UIButton *loginButton;
@property (nonatomic,strong) UIButton *registerButton;
@property (nonatomic,strong) UIButton *forgetButton;
@property (nonatomic , strong) void(^sendController)(UIViewController * controller,NSInteger btnTag);
@end
