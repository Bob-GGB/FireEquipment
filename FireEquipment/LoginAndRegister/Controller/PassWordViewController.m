//
//  PassWordViewController.m
//  FireEquipment
//
//  Created by mc on 2017/10/27.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "PassWordViewController.h"
#import "LoginViewController.h"
@interface PassWordViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *passWordLabel;
@property (nonatomic,strong) UITextField *passWordLabel2;
@property (nonatomic,strong) UIButton *finishButton;
@property (nonatomic,strong) UIView *backgroundView;
@end

@implementation PassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title=self.titleName;
   [self addLeftBarButtonWithImage:@"back.png"];
   
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    [self creatUI];
    [self addNoticeForKeyboard];
}
-(void)creatUI{
    
    self.backgroundView=[[UIView alloc] init];
    [self.backgroundView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.backgroundView];
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(NaviHeight));
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 96));
    }];
    
    //密码
    self.passWordLabel=[[UITextField alloc] init];
    [self.passWordLabel setDelegate:self];
    [self.passWordLabel setTextAlignment:NSTextAlignmentLeft];
    [self.passWordLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [self.passWordLabel setPlaceholder:@"  输入密码"];
    self.passWordLabel.attributedPlaceholder =[[NSAttributedString alloc] initWithString:self.passWordLabel.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#999999"]}];
    [self.passWordLabel setBackgroundColor:[UIColor colorWithHexString:@"#f2f2f2"]];
    [self.passWordLabel.layer setMasksToBounds:YES];
    [self.passWordLabel.layer setCornerRadius:10];
    [self.passWordLabel setKeyboardType:UIKeyboardTypeNumberPad];
    [self.backgroundView addSubview:self.passWordLabel];
    [self.passWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(320, 37));
    }];
    //再次输入密码框
    self.passWordLabel2=[[UITextField alloc] init];
    [self.passWordLabel2 setDelegate:self];
    [self.passWordLabel2 setTextAlignment:NSTextAlignmentLeft];
    [self.passWordLabel2 setFont:[UIFont systemFontOfSize:15.0f]];
    [self.passWordLabel2 setPlaceholder:@"  再次输入密码"];
    self.passWordLabel2.attributedPlaceholder =[[NSAttributedString alloc] initWithString:self.passWordLabel2.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#999999"]}];
    [self.passWordLabel2 setBackgroundColor:[UIColor colorWithHexString:@"#f2f2f2"]];
    [self.passWordLabel2.layer setMasksToBounds:YES];
    [self.passWordLabel2.layer setCornerRadius:10];
    [self.passWordLabel2 setKeyboardType:UIKeyboardTypeAlphabet];
    //    [self.passWordLabel setSecureTextEntry:YES];
    [self.backgroundView addSubview:self.passWordLabel2];
    [self.passWordLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.passWordLabel.mas_bottom).offset(22);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(320, 37));
    }];

    //登录按钮
    self.finishButton =[UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.finishButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.finishButton.layer setMasksToBounds:YES];
    [self.finishButton.layer setCornerRadius:10];
    [self.finishButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    if ([self.title isEqualToString:@"找回密码"]) {
         [self.finishButton setImage:[UIImage imageNamed:@"wanchen.png"] forState:UIControlStateNormal];
    }
    else{
   [self.finishButton setImage:[UIImage imageNamed:@"lijizhuce.png"] forState:UIControlStateNormal];
    }

    [self.finishButton addTarget:self action:@selector(finishButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.finishButton];
    [self.finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundView.mas_bottom).offset(36);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-40, 40));
    }];
    
    
}

#pragma mark ========== 完成按钮点击事件==========
-(void)finishButtonDidPress:(UIButton *)sender{
  
    if (self.passWordLabel.text.length==0) {
       
        [MBPHudView showHUDWithText:@"密码不能为空"];
        return;
    }
    if (self.passWordLabel.text !=self.passWordLabel2.text ) {
        [MBPHudView showHUDWithText:@"你的密码两次输入不同"];
        return;
    }
    [self back];
    
}

#pragma mark ========== 返回到登录页面==========
- (void)back {
    // 获取所有的控制器数组
    NSMutableArray *vcArr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    // 将上级页面从数组中移除
    [vcArr removeObjectAtIndex:vcArr.count-2];
    self.navigationController.viewControllers = vcArr;
    
    [self.navigationController popViewControllerAnimated:NO];
   
}


#pragma mark - 键盘通知
- (void)addNoticeForKeyboard {
    
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}
///键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset = (self.backgroundView.frame.origin.y+self.backgroundView.frame.size.height+100) - (self.view.frame.size.height - kbHeight);
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
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
