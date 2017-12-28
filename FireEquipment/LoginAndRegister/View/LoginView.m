//
//  LoginView.m
//  FireEquipment
//
//  Created by mc on 2017/10/23.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "LoginView.h"

#import "RootTabBarViewController.h"
#import "RegistViewController.h"
#import <CommonCrypto/CommonDigest.h>
@interface LoginView()<UITextFieldDelegate>
@property (nonatomic,strong) UIView *backgroundView;

@end

@implementation LoginView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self creatHeadUI];
        [self creatTextField];
        [self addNoticeForKeyboard];
    }
    return self;
}

-(void)creatHeadUI{
    self.headImageView=[[UIImageView alloc] init];
//    [self.headImageView.layer setMasksToBounds:YES];
//    [self.headImageView.layer setCornerRadius:40];
    [self.headImageView setImage:[UIImage imageNamed:@"logo.png"]];
    [self.headImageView setUserInteractionEnabled:YES];
    [self addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.centerX.equalTo(self);
        make.top.equalTo(@150);
    }];
}
-(void)creatTextField{
    
    
    self.backgroundView=[[UIView alloc] init];
    [self.backgroundView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView.mas_bottom).offset(50);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 160));
    }];
    
    //账户
    self.phoneLabel=[[UITextField alloc] init];
    [self.phoneLabel setDelegate:self];
    [self.phoneLabel setTextAlignment:NSTextAlignmentLeft];
    [self.phoneLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [self.phoneLabel setPlaceholder:@"  输入账号/手机号"];
    self.phoneLabel.attributedPlaceholder =[[NSAttributedString alloc] initWithString:self.phoneLabel.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#999999"]}];
    [self.phoneLabel setBackgroundColor:[UIColor colorWithHexString:@"#f2f2f2"]];
    [self.phoneLabel.layer setMasksToBounds:YES];
    [self.phoneLabel.layer setCornerRadius:10];
    [self.phoneLabel setKeyboardType:UIKeyboardTypeDefault];
    [self.backgroundView addSubview:self.phoneLabel];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(320, 40));
    }];
//    //输入框底部横线
//    UIView *lineView=[[UIView alloc] init];
//    [lineView setBackgroundColor:KRGB(240, 240, 240, 1.0)];
//    [self.backgroundView addSubview:lineView];
//    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.phoneLabel.mas_bottom).offset(-1);
//        make.centerX.equalTo(self);
//        make.size.mas_equalTo(CGSizeMake(kScreenWidth-40, 1));
//    }];


    //密码框
    self.passWordLabel=[[UITextField alloc] init];
    //                            WithFrame:CGRectMake(0, CGRectGetMaxY(self.userNameTextField.frame), self.userNameTextField.frame.size.width, 49)];
    [self.passWordLabel setDelegate:self];
    [self.passWordLabel setTextAlignment:NSTextAlignmentLeft];
    [self.passWordLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [self.passWordLabel setPlaceholder:@"  输入密码"];
    self.passWordLabel.attributedPlaceholder =[[NSAttributedString alloc] initWithString:self.passWordLabel.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#999999"]}];
    
    [self.passWordLabel setBackgroundColor:[UIColor colorWithHexString:@"#f2f2f2"]];
    [self.passWordLabel.layer setMasksToBounds:YES];
    [self.passWordLabel.layer setCornerRadius:10];
    [self.passWordLabel setKeyboardType:UIKeyboardTypeDefault];
    [self.passWordLabel setSecureTextEntry:YES];
    [self.backgroundView addSubview:self.passWordLabel];
    [self.passWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.phoneLabel.mas_bottom).offset(22);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(320, 37));
    }];



    //注册按钮
    self.registerButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.registerButton setBackgroundColor:[UIColor whiteColor]];
    [self.registerButton setTitleColor:[UIColor colorWithHexString:@"#989898"] forState:UIControlStateNormal];
    [self.registerButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.registerButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [self.registerButton setTitle:@"普通用户注册" forState:UIControlStateNormal];
    self.registerButton.tag=101;
    [self.registerButton addTarget:self action:@selector(registerButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundView addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passWordLabel.mas_bottom).offset(21);
        make.left.equalTo(self.phoneLabel.mas_left);
         make.size.mas_equalTo(CGSizeMake(kScreenWidth/4, 30));
    }];

    //忘记密码按钮
    self.forgetButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.forgetButton setBackgroundColor:[UIColor whiteColor]];
     [self.forgetButton setTitleColor:[UIColor colorWithHexString:@"#989898"] forState:UIControlStateNormal];
    [self.forgetButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.forgetButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [self.forgetButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [self.forgetButton addTarget:self action:@selector(forgetButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
    self.forgetButton.tag=102;
    [self.backgroundView addSubview:self.forgetButton];
    [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registerButton.mas_top);
        make.right.equalTo(@-10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/4, 30));
    }];


    //登录按钮
    self.loginButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginButton setBackgroundColor:KRGB(252, 84, 76,1.0)];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.loginButton.layer setMasksToBounds:YES];
    [self.loginButton.layer setCornerRadius:10];
    [self.loginButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [self.loginButton setImage:[UIImage imageNamed:@"denglu.png"] forState:UIControlStateNormal];
    self.loginButton.tag=103;
    [self.loginButton addTarget:self action:@selector(loginButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundView.mas_bottom).offset(22);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(320, 40));
    }];

}




#pragma mark ========== 注册按钮点击事件==========
-(void)registerButtonDidPress:(UIButton *)sender{
   
    
  
    RegistViewController *registerVC=[[RegistViewController alloc] init];

    
    
    if (self.sendController) {
        registerVC.titleName=sender.titleLabel.text;
        self.sendController(registerVC, sender.tag);
    }
    NSLog(@"我要注册了");
}
#pragma mark ========== 忘记密码按钮点击事件==========
-(void)forgetButtonDidPress:(UIButton *)sender{
     RegistViewController *registerVC=[[RegistViewController alloc] init];
    if (self.sendController) {
        registerVC.titleName=@"找回密码";
        self.sendController(registerVC, sender.tag);
    }
    NSLog(@"我忘记密码了");
}

#pragma mark ========== 登录按钮点击事件==========
-(void)loginButtonDidPress:(UIButton *)sender{
   
//    NSLog(@"--%@---%@",self.phoneLabel.text,self.passWordLabel.text);
    if (![self.phoneLabel.text isEqual:@""]&&![self.passWordLabel.text isEqual:@""]) {
       [self PostloginToSeverWithSendTag:sender];
    }
    else{
         [MBPHudView showHUDWithText:@"账号或密码不能为空"];
    }
    
    
}

#pragma mark ========== UITextField协议的方法==========

-(void)textFieldDidEndEditing:(UITextField *)textField{
//    NSLog(@"%@",textField.text);
    
    
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
    CGFloat offset = (self.backgroundView.frame.origin.y+self.backgroundView.frame.size.height+100) - (self.frame.size.height - kbHeight);
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            self.frame = CGRectMake(0.0f, -offset, self.frame.size.width, self.frame.size.height);
        }];
    }
}

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
    
}


-(void)PostloginToSeverWithSendTag:(UIButton *)sender{
    /****************************************************************************************/
    
    //获取当前时间
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *DateTime = [formatter stringFromDate:date];
    
//    NSNumber *userStr = @([self.phoneLabel.text integerValue]);//获取用户输入的账号密码
//    NSNumber *passStr =@([self.passWordLabel.text integerValue]);
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:self.phoneLabel.text forKey:@"username"];
    [dictionary setValue:self.passWordLabel.text forKey:@"password"];
    
    NSMutableDictionary *Alldict=[[NSMutableDictionary alloc] init];
    [Alldict setValue:dictionary forKey:@"app"];
    [Alldict setValue:@"" forKey:@"token"];
    [Alldict setValue:DateTime forKey:@"timestamp"];
    
    
    //md5加密
    //    //字符串拼接
    
    NSString *MD5String1=[self ziDianZhuanJson:dictionary];
    
    NSString *MD5string2=[NSString stringWithFormat:@"%@%@",[Alldict objectForKey:@"token"],[Alldict objectForKey:@"timestamp"]];
    NSString *MD5Str=[ MD5string2 stringByAppendingString: MD5String1];
    // NSLog(@"hahahah%@",MD5Str);
    //MD5加密
    NSString *getStrMD5=[self encryptStringWithMD5:MD5Str];
    [Alldict setValue:getStrMD5  forKey:@"checksum"];
    
    
    /****************************************************************************************/
    
    //传入的参数
    
    NSDictionary *parameters = @{@"app":dictionary,@"timestamp":DateTime,@"token":@"",@"checksum":getStrMD5};
    
    //讲字典类型转换成json格式的数据，然后讲这个json字符串作为字典参数的value传到服务器
    
    
    
    //接口地址
    //NSString *urlString = @"http://louyu.qianchengwl.cn/minapp/user/login";
    NSString *urlString=@"http://equipmentapp.qianchengwl.cn/api/user/login";
    
    [HTTPRequest POST:urlString parameters:parameters success:^(id responseObj) {
        
        //请求成功返回数据；需要转化成字典（即json格式数据）
        //请求成功返回数据；需要转化成字典（即json格式数据）
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"%@",dict);
       
        if ([dict[@"code"] isEqualToNumber:@1]) {
            
        RootTabBarViewController *homeVC=[[RootTabBarViewController alloc] init];
    
            [MBPHudView showHUDWithText:@"登录成功"];
            if (self.sendController) {
                self.sendController(homeVC, sender.tag);
            }
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            
            [defaults setObject:dict forKey:@"userInfoDic"];
            //保存到本地
            [defaults synchronize];
//            NSLog(@"%@",NSHomeDirectory());
            
           
            
            
        }
        else{
             [MBPHudView showHUDWithText:@"账号或密码错误"];
           
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


//转成json字符串
-(NSString *)ziDianZhuanJson:(NSDictionary *)object{
    
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    if (! jsonData) {
        NSLog(@"________Got an error________: %@", error);
    }
    else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    
    //去掉字符串中的空格
    jsonString = [jsonString stringByReplacingOccurrencesOfString: @" " withString: @""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString: @"\n" withString: @""];
    
    return jsonString;
}

//MD5加密
-(NSString *)encryptStringWithMD5:(NSString *)inputStr{
    const char *newStr = [inputStr UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(newStr,(unsigned int)strlen(newStr),result);
    NSMutableString *outStr = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for(int i = 0;i<CC_MD5_DIGEST_LENGTH;i++){
        [outStr appendFormat:@"%02x",result[i]];//注意：这边如果是x则输出32位小写加密字符串，如果是X则输出32位大写字符串
    }
    return outStr;
}


@end
