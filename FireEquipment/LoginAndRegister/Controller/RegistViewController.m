//
//  RegistViewController.m
//  FireEquipment
//
//  Created by mc on 2017/10/26.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "RegistViewController.h"
#import "PassWordViewController.h"


#define CountTime 60  //验证码获取的时间
@interface RegistViewController ()<UITextFieldDelegate>
{
    
     NSInteger _count;
}
@property (nonatomic,strong) UITextField *phoneLabel;
@property (nonatomic,strong) UITextField *codeLabel;
@property (nonatomic,strong) UIButton *nextButton;
@property (nonatomic,strong) UIButton *codeButton;
@property (nonatomic,strong) UIView *backgroundView;
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title=self.titleName;
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    [self addLeftBarButtonWithImage:@"back.png"];
 
    [self creatUI];
    [self addNoticeForKeyboard];
}


-(void)creatUI{
    
    self.backgroundView=[[UIView alloc] init];
    [self.backgroundView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.backgroundView];
   
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(NaviHeight)).offset(67*2.5);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 96));
    }];
    
    //手机号
    self.phoneLabel=[[UITextField alloc] init];
    [self.phoneLabel setDelegate:self];
    [self.phoneLabel setTextAlignment:NSTextAlignmentLeft];
    [self.phoneLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [self.phoneLabel setPlaceholder:@"  输入手机号"];
     self.phoneLabel.attributedPlaceholder =[[NSAttributedString alloc] initWithString:self.phoneLabel.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#999999"]}];
    [self.phoneLabel setBackgroundColor:[UIColor colorWithHexString:@"#f2f2f2"]];
    [self.phoneLabel.layer setMasksToBounds:YES];
    [self.phoneLabel.layer setCornerRadius:10];
    [self.phoneLabel setKeyboardType:UIKeyboardTypeNumberPad];
    [self.backgroundView addSubview:self.phoneLabel];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.centerX.equalTo(self.view);
//        make.left.equalTo(@28);
        make.size.mas_equalTo(CGSizeMake(320, 37));
    }];
    
    //倒计时按钮
    self.codeButton =[UIButton buttonWithType:UIButtonTypeCustom];
//    [self.codeButton setBackgroundColor:[UIColor greenColor]];
    [self.codeButton setTitleColor:[UIColor colorWithHexString:@"#c8996b"] forState:UIControlStateNormal];
    [self.codeButton setBackgroundColor:[UIColor colorWithHexString:@"#f2f2f2"]];
    [self.codeButton.layer setMasksToBounds:YES];
    [self.codeButton.layer setCornerRadius:10];
    [self.codeButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.codeButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [self.codeButton setTitle:@"|获取验证码" forState:UIControlStateNormal];
   
    [self.codeButton addTarget:self action:@selector(codeButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.phoneLabel addSubview:self.codeButton];
    [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneLabel.mas_top);
        make.width.equalTo(@100);
        make.right.equalTo(@0);
        make.height.equalTo(self.phoneLabel.mas_height);
    }];
    


    //验证码框
    self.codeLabel=[[UITextField alloc] init];
    [self.codeLabel setDelegate:self];
    [self.codeLabel setTextAlignment:NSTextAlignmentLeft];
    [self.codeLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [self.codeLabel setPlaceholder:@"  输入短信验证码"];
     self.codeLabel.attributedPlaceholder =[[NSAttributedString alloc] initWithString:self.codeLabel.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#999999"]}];
    [self.codeLabel setBackgroundColor:[UIColor colorWithHexString:@"#f2f2f2"]];
    [self.codeLabel.layer setMasksToBounds:YES];
    [self.codeLabel.layer setCornerRadius:10];
    [self.codeLabel setKeyboardType:UIKeyboardTypeAlphabet];
//    [self.passWordLabel setSecureTextEntry:YES];
    [self.backgroundView addSubview:self.codeLabel];
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.phoneLabel.mas_bottom).offset(22);
         make.centerX.equalTo(self.view);
         make.size.mas_equalTo(CGSizeMake(320, 37));
    }];


    
    //登录按钮
    self.nextButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.nextButton.layer setMasksToBounds:YES];
    [self.nextButton.layer setCornerRadius:10];
    [self.nextButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [self.nextButton setImage:[UIImage imageNamed:@"xiayibu.png"] forState:UIControlStateNormal];
    self.nextButton.tag=103;
    [self.nextButton addTarget:self action:@selector(nextButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextButton];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundView.mas_bottom).offset(36);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(320, 40));
    }];

    
}

#pragma mark ========== 获取验证码按钮点击事件==========

-(void)codeButtonDidPress:(UIButton *)sender{
    if ([self.phoneLabel.text isEqualToString:@""]||(self.phoneLabel.text==NULL)) {
        [MBPHudView showHUDWithText:@"手机号不能为空"];
        
        
    }
    else if (self.phoneLabel.text.length!=11){
        
        [MBPHudView showHUDWithText:@"请输入正确的手机号"];
    }
    else{
     [self performSelector:@selector(countClick) withObject:nil];
    }
}


#pragma mark ========== 倒计时==========
-(void)countClick{
    self.codeButton.enabled =NO;
    _count =CountTime;
    [self.codeButton setTitle:[NSString stringWithFormat:@"%ld秒后重新获取",(long)_count] forState:UIControlStateDisabled];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
}
#pragma mark ========== timerFired==========
-(void)timerFired:(NSTimer *)timer{
    
    if (_count !=1) {
        _count -=1;
        [self.codeButton setTitle:[NSString stringWithFormat:@"%ld秒后重新获取",_count] forState:UIControlStateDisabled];
        if (_count==50) {
            NSLog(@"在这里，网络请求服务器");
        }
    }
    else
    {
        [timer invalidate];
        self.codeButton.enabled = YES;
        [self.codeButton setTitle:@"重新获取验证码" forState:UIControlStateNormal];
    }
    
}

#pragma mark ========== 下一步按钮点击事件==========
-(void)nextButtonDidPress:(UIButton *)sender{
    PassWordViewController *passWordVC=[[PassWordViewController alloc] init];
    passWordVC.titleName=self.title;
    [self.navigationController pushViewController:passWordVC animated:YES];
    
    
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


//-(void)leftBarButtonDidPress:(UIButton *)sender{
//    [self.navigationController popoverPresentationController];
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
