//
//  SettingViewController.m
//  FireEquipment
//
//  Created by mc on 2017/12/1.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "SettingViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "OneCellTableViewCell.h"
#import "OneCellView.h"
#import "UILabel+XFLabel.h"
#import "LoginViewController.h"
#import "SelectPhotoManager.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic, strong)SelectPhotoManager *photoManager;
@property (nonatomic,strong) UIImageView *headView;
@end

@implementation SettingViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"个人设置";
    
   [self addLeftBarButtonWithImage:@"back.png"];
    [self setUpTableView];
    
}
-(void)setUpTableView{

    
    [_mainTableView removeFromSuperview];
    _mainTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    [_mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _mainTableView.estimatedSectionHeaderHeight = 0;
    _mainTableView.estimatedSectionFooterHeight = 0;
    _mainTableView.estimatedRowHeight = 0;
    _mainTableView.delegate=self;
    _mainTableView.dataSource=self;
    _mainTableView.backgroundColor=[UIColor colorWithHexString:@"#eeeeee"];
//    _mainTableView.alpha=0.3;
    
    [self.view addSubview:_mainTableView];
}

-(NSNumber *)getToken{
    NSUserDefaults *defauts=[NSUserDefaults standardUserDefaults];
    NSDictionary *userDict= [defauts objectForKey:@"userInfoDic"];
    
    return  userDict[@"content"][@"token"];
    
}


#pragma mark ========== 先上传图片到服务器==========
-(void)uploadImagesToSeverWithURL:(NSString *)URL andImageData:(NSData *)imageData{
    
    NSString *tmpstr=@"\"[]\"";
    
    //获取当前时间
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *DateTime = [formatter stringFromDate:date];
    
    NSMutableDictionary *Alldict=[[NSMutableDictionary alloc] init];
    [Alldict setValue:tmpstr forKey:@"app"];
    
    [Alldict setValue:[self getToken] forKey:@"token"];
    [Alldict setValue:DateTime forKey:@"timestamp"];
    
    
    //md5加密
    //    //字符串拼接
    
    
    NSString *MD5string2=[NSString stringWithFormat:@"%@%@%@",[Alldict objectForKey:@"token"],[Alldict objectForKey:@"timestamp"],[Alldict objectForKey:@"app"]];
    // NSLog(@"hahahah%@",MD5Str);
    //MD5加密
    //NSLog(@"--加密之前：%@",MD5string2);
    NSString *getStrMD5=[self encryptStringWithMD5:MD5string2];
    [Alldict setValue:getStrMD5  forKey:@"checksum"];
    
    
    /****************************************************************************************/
    
    //传入的参数
    
    NSDictionary *parameters =[NSDictionary dictionaryWithObjectsAndKeys:@"[]",@"app",DateTime,@"timestamp",[self getToken],@"token",getStrMD5,@"checksum", nil];
    NSString *urlStr=@"http://louyu.qianchengwl.cn/minapp/upload/upload";
    
   
    NSDateFormatter *dd = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [dd stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
    if (imageData!=nil) {
        [HTTPRequest upload:urlStr parameters:parameters fileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg" progress:^(NSProgress *progress) {
            
        } success:^(id responseObj)
            
            {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
        
                [self changeHeadImageToSeverWithImageUrl:dict[@"content"][@"imgUrl"]];
                
                
    } failure:^(NSError *error) {
        
    }];
        
    }
            
    
}


#pragma mark ========== 上传头像到服务器==========
-(void)changeHeadImageToSeverWithImageUrl:(NSString *)imageUrl{
    
    
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:imageUrl forKey:@"thumb"];
    NSString *url=@"http://equipmentapp.qianchengwl.cn/api/user/uploadThumb";
    [HTTPRequest POST:url getToken:[self getToken] paramentDict:dictionary success:^(id responseObj) {
        
        //请求成功返回数据；需要转化成字典（即json格式数据）
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
        if ([dict[@"code"] isEqualToNumber:@1]) {
            [MBPHudView showHUDWithText:@"更换头像成功"];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}






-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==1) {
        return 2;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section==0) {
        
  
                static NSString *headcellID=@"headcellID";
                UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:headcellID];
                
                if (cell==nil) {
                    cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headcellID];
                }
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        
        UIView *backView=[[UIView alloc] initWithFrame:cell.bounds];
        backView.userInteractionEnabled=YES;
        [cell addSubview:backView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [backView addGestureRecognizer:tap];
   self.headView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 52, 52)];
    self.headView.backgroundColor=[UIColor redColor];
    [self.headView.layer setMasksToBounds:YES];
    [self.headView.layer setCornerRadius:52/2];
    self.headView.userInteractionEnabled = YES;
        UIImage *img = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"headerImage"]];
        if (img) {
            self.headView.image = img;
        }
        else{
    [self.headView sd_setImageWithURL:[NSURL URLWithString:self.headImageURL]];
        }
    [backView addSubview:self.headView];
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-90, 20, 60, 30)];
    label.text=@"更换头像";
    label.textColor=[UIColor colorWithHexString:@"#282828"];
    label.font=[UIFont systemFontOfSize:14];
    [backView addSubview:label];
                
                return cell;
            }
    else if (indexPath.section==1){
        static NSString *onecellID=@"onecellID";
        UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:onecellID];
        
        if (cell==nil) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:onecellID];
        }
        cell.textLabel.font=[UIFont systemFontOfSize:15];
        cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
        if (indexPath.row==0) {
            cell.textLabel.text=@"机构";
            cell.detailTextLabel.text=self.nameStr;
            UIView *uView=[UIView new];
            uView.frame=CGRectMake(0, cell.bounds.size.height-1, kScreenWidth, 1);
            [cell addSubview:uView];
            uView.backgroundColor=[UIColor colorWithHexString:@"#9e9e9e"];
            uView.alpha=0.3;
        }
        else{
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
            cell.textLabel.text=@"查看机构信息";
            
        }
        
        return cell;
    }
    else if (indexPath.section==2){
        static NSString *exitcellID=@"exitcellID";
        UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:exitcellID];
        
        if (cell==nil) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:exitcellID];
        }
        
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        cell.textLabel.text=@"退出登录" ;
        
        return cell;
    }
    
    return nil;
}


#pragma mark ========== 更换头像点击事件==========
-(void)tapClick:(UITapGestureRecognizer *)recognizer{
    
    if (!_photoManager) {
        _photoManager =[[SelectPhotoManager alloc]init];
    }
    [_photoManager startSelectPhotoWithImageName:@"选择头像"];
    __weak typeof(self)mySelf=self;
    _photoManager.canEditPhoto=YES;
    //选取照片成功
    _photoManager.successHandle=^(SelectPhotoManager *manager,UIImage *image){
        
        mySelf.headView.image = image;
        //保存到本地
        NSData *data = UIImagePNGRepresentation(image);
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"headerImage"];
        [mySelf uploadImagesToSeverWithURL:@"http://equipmentapp.qianchengwl.cn/api/upload/upload" andImageData:data];
        
    };
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 70;
    }
       return 40;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==2) {
        return 70;
    }
    
    return 10;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (indexPath.section==2) {
        //删除本地保存的用户信息
        NSUserDefaults *defauts=[NSUserDefaults standardUserDefaults];
        [defauts removeObjectForKey:@"userInfoDic"];
        [defauts removeObjectForKey:@"headerImage"];
        LoginViewController *loginVC=[[LoginViewController alloc] init];
        [self presentViewController:loginVC animated:NO completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight =70;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y > 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else {
        if (scrollView.contentOffset.y >= sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
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



//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
