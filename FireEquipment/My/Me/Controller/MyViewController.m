//
//  MyViewController.m
//  FireEquipment
//
//  Created by mc on 2017/10/19.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "MyViewController.h"
#import "LoginViewController.h"
#import "WRNavigationBar.h"
#import "NomalTableViewCell.h"
#import "OneCellView.h"
#import "OneCellTableViewCell.h"
#import "BoughtInfoBtnTableViewCell.h"
#import "LoginViewController.h"
#import "DataModel.h"
#import "SettingViewController.h"
#import "UINavigationController+StatusBar.h"
@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic,strong) UIImageView *shadowImage;
@property (nonatomic,strong) UILabel  *nameLabel;
@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic, strong) NSArray *icoArr;
@property (nonatomic,strong) NSNumber *roleIDnum;
@property (nonatomic,strong) NSNumber *tokenIDnum;
@property (nonatomic,strong) DataModel *dataModel;
@property (nonatomic,copy) NSString *headiamgeURL;
@property (nonatomic,copy) NSString *nameStr;


@end

@implementation MyViewController

NSArray *allSubviews(UIView *aView) {
    
    NSArray *results = [aView subviews];
    for (UIView *eachView in aView.subviews)
    {
        NSArray *subviews = allSubviews(eachView);
        if (subviews)
            results = [results arrayByAddingObjectsFromArray:subviews];
    }
    return results;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
     [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleLightContent ;
    
     [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"#303030"]];
    NSArray *subViews = allSubviews(self.navigationController.navigationBar);
    for (UIView *view in subViews) {
        if ([view isKindOfClass:[UIImageView class]] && view.bounds.size.height<1){
            //实践后发现系统的横线高度为0.333
            self.shadowImage = (UIImageView *)view;
        }
    }
    self.shadowImage.hidden = YES;
    
    [self setUpHeadUI];
    [self setUpTableView];
    
   
}
- (void)viewWillDisappear:(BOOL)animated{
     [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"#303030"]];
    [super viewWillDisappear:animated];
    self.shadowImage.hidden = NO;
    
      [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}




//-(UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationController.navigationBar.translucent=NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"#303030"]];
   
    self.view.backgroundColor=[UIColor colorWithHexString:@"#303030"];
    //状态栏
//     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self addRightTwoBarButtonsWithFirstImage:[UIImage imageNamed:@"shezhi.png"] firstAction:@selector(setButtonDidPress) secondImage:[UIImage imageNamed:@"tongzhi.png"] secondAction:@selector(xiaoxiButttonDidPress)];
    
    
     [self postDataInfoFromSeverWithURL:@"http://equipmentapp.qianchengwl.cn/api/user/workIndex"];
    
    
   
   
}


-(void)setUpHeadUI{
    
    
    _headView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    _headView.backgroundColor=[UIColor colorWithHexString:@"#303030"];
    [self.view addSubview:_headView];
    _headImageView=[[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 52, 52)];
    _headImageView.backgroundColor=[UIColor redColor];
    [_headImageView.layer setMasksToBounds:YES];
    [_headImageView.layer setCornerRadius:52/2];
    _headImageView.userInteractionEnabled = YES;
     [_headView addSubview:_headImageView];
    //创建手势 使用initWithTarget:action:的方法创建
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
   
    
    _nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame)+10, CGRectGetMidY(_headImageView.frame)-10, 250, 20)];
    _nameLabel.textColor=[UIColor whiteColor];
    _nameLabel.text=@"某年女女女女女";
    _nameLabel.font=[UIFont systemFontOfSize:15];
    [_headView addSubview:_nameLabel];
    
    NSUserDefaults *defauts=[NSUserDefaults standardUserDefaults];
    NSDictionary *userDict= [defauts objectForKey:@"userInfoDic"];
    self.roleIDnum=userDict[@"content"][@"roleID"];
    self.tokenIDnum=userDict[@"content"][@"token"];
    self.headiamgeURL=userDict[@"content"][@"thumb"];
    self.nameStr=userDict[@"content"][@"sellerName"];
    UIImage *img = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"headerImage"]];
    if (img) {
       _headImageView.image = img;
    }
    else{
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:self.headiamgeURL] placeholderImage:[UIImage imageNamed:@"touxiang.png"]];
    }
   
    if (self.roleIDnum==NULL) {
        _nameLabel.text=@"点击头像登录";
         [_headImageView addGestureRecognizer:tap];
    }
    else{
     _nameLabel.text=self.nameStr;
    }
    
    _icoArr=@[@"shezhi.png_56",@"gengxin.png"];//未登录cell图标数组
   
    
    
    
    
}

#pragma mark ========== 点击头像登录按钮==========
-(void)tapView:(UITapGestureRecognizer *)sender{
  
    LoginViewController *loginVC=[[LoginViewController alloc] init];
    [self presentViewController:loginVC animated:nil completion:nil];
   
}


-(void)setUpTableView{
    
    
    [_mainTableView removeFromSuperview];
    _mainTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headView.frame), kScreenWidth, kScreenHeight-_headView.frame.size.height) style:UITableViewStylePlain];
//     _mainTableView.contentInset = UIEdgeInsetsMake(-_headView.frame.size.height, 0, 0, 0);
    [_mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _mainTableView.estimatedSectionHeaderHeight = 0;
    _mainTableView.estimatedSectionFooterHeight = 0;
     _mainTableView.estimatedRowHeight = 0;
    _mainTableView.delegate=self;
    _mainTableView.dataSource=self;
   _mainTableView.backgroundColor=[UIColor colorWithHexString:@"#eeeeee"];
    [self.view addSubview:_mainTableView];
}


#pragma mark ========== 设置按钮点击事件==========
-(void)setButtonDidPress{
    SettingViewController *setVC=[[SettingViewController alloc] init];
    setVC.roleIDnum=self.roleIDnum;
    setVC.headImageURL=self.headiamgeURL;
    setVC.nameStr=self.nameStr;
    if (self.roleIDnum!=NULL) {
       [self.navigationController pushViewController:setVC animated:NO];
    }
    else{
        [MBPHudView showHUDWithText:@"请登录"];
    }
   
    
    
}
#pragma mark ========== 消息点击事件==========

-(void)xiaoxiButttonDidPress{
    
    
}

-(void)postDataInfoFromSeverWithURL:(NSString *)url{
    
    [HTTPRequest POST:url getToken:self.tokenIDnum paramentDict:nil success:^(id responseObj) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
//                         NSLog(@"%@",dict);
        
        _dataModel=[[DataModel alloc] initWithDict:dict[@"content"][@"data"]];
        
        
        [self.mainTableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self.roleIDnum isEqualToNumber:@1]) {//准入商
        return 2;
    }
    else if ([self.roleIDnum isEqualToNumber:@2]){//供应商
        return 4;
    }
    else if ([self.roleIDnum isEqualToNumber:@4]){//支队
        return 3;
    }
    else if ([self.roleIDnum isEqualToNumber:@5]){//总队
        return 5;
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.roleIDnum!=NULL) {
        if ( section==0 ) {
            return 0;
        }
        else if ( [self.roleIDnum isEqualToNumber:@1]&& section==1 ){
        return 2;
        }
        else if ( [self.roleIDnum isEqualToNumber:@1]&& section==2 ){
            return 2;
        }
        else if (([self.roleIDnum isEqualToNumber:@2]||[self.roleIDnum isEqualToNumber:@4]||[self.roleIDnum isEqualToNumber:@5]) && section==1 ){
            return 1;
        }
        else if ( ([self.roleIDnum isEqualToNumber:@2]||[self.roleIDnum isEqualToNumber:@4])&&(section==2||section==3) ){
            return 2;
        }
        else if ( [self.roleIDnum isEqualToNumber:@5]&& section==2 ){
            return 2;
        }
        else if ( [self.roleIDnum isEqualToNumber:@5]&& (section==3||section==4) ){
            return 1;
        }
        
        return 0;
    }
    else{
    return _icoArr.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        
    if (self.roleIDnum==NULL) {
        static NSString *NomalTableID=@"NomalTableID";
        NomalTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:NomalTableID];
        
        if (cell==nil) {
            cell=[[NomalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NomalTableID];
        }
        
        cell.iconImageView.image=[UIImage imageNamed:self.icoArr[indexPath.row]];
        NSArray *titleArr=@[@"我的设置",@"检查更新"];//未登录cell信息数组
        cell.titleLabel.text=titleArr[indexPath.row];
        if (indexPath.row==0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        }
        else{
            cell.vertionLabel.text=@"最新版本";
        }
        return cell;
    }
    else{
        #pragma mark ==========准入商==========
       if ([self.roleIDnum isEqualToNumber:@1]&&indexPath.section==1){
            
            if (indexPath.row==0) {
                static NSString *OneCellID11=@"OneCellID11";
                OneCellTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:OneCellID11];
                
                if (cell==nil) {
                    cell=[[OneCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OneCellID11];
                }
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
                cell.namelabel.text=@"商品管理";
              
                return cell;
            }
            else{
                static NSString *BoughtInfoBtnID11=@"BoughtInfoBtnID11";
                UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:BoughtInfoBtnID11];
                
                if (cell==nil) {
                    cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BoughtInfoBtnID11];
                }
                    NSArray *arr=@[@"hetong.png",@"daifahuo.png",@"daishouhuo.png",@"daipingjia.png"];
                    NSArray *titleArr=@[@"已入库",@"审核中",@"审核通过",@"审核不通过"];
                NSArray *badgeArr=@[@(_dataModel.warehousing),@(_dataModel.uncheckProduct),@(_dataModel.checkSuccessProduct),@(_dataModel.checkFailProduct)];
                BoughtInfoBtnTableViewCell *view=[[BoughtInfoBtnTableViewCell alloc] initWithTitleArr:titleArr andImageArr:arr andBadgeArr:badgeArr];
                view.frame=cell.bounds;
                [cell addSubview:view];
                return cell;
                
            }
        }
        
        
              #pragma mark ==========供应商==========
       else if (([self.roleIDnum isEqualToNumber:@2]||[self.roleIDnum isEqualToNumber:@4]||[self.roleIDnum isEqualToNumber:@5])&&indexPath.section==1){
            static NSString *NornalID=@"NornalID";
            NomalTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:NornalID];
            
            if (cell==nil) {
                cell=[[NomalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NornalID];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
           cell.vertionLabel.textColor=[UIColor colorWithHexString:@"#b6463b"];
           cell.iconImageView.image=[UIImage imageNamed:@"yijia.png"];
           cell.titleLabel.text=@"议价中的商品";
           cell.vertionLabel.text=[NSString stringWithFormat:@"%ld",_dataModel.bargain];
            
            return cell;
    }
       else if (([self.roleIDnum isEqualToNumber:@2]||[self.roleIDnum isEqualToNumber:@4]||[self.roleIDnum isEqualToNumber:@5])&&indexPath.section==2){
            
            if (indexPath.row==0) {
                static NSString *OneCellID22=@"OneCellID22";
                OneCellTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:OneCellID22];
                
                if (cell==nil) {
                    cell=[[OneCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OneCellID22];
                }
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
                cell.namelabel.text=@"已买到的商品";
                cell.lookLabel.text=@"全部订单";
                return cell;
            }
            else{
                static NSString *BoughtInfoBtnID22=@"BoughtInfoBtnID22";
                UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:BoughtInfoBtnID22];
                
                if (cell==nil) {
                    cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BoughtInfoBtnID22];
                }
                    NSArray *arr=@[@"hetong.png",@"daifahuo.png",@"daishouhuo.png",@"daipingjia.png"];
                    NSArray *titleArr=@[@"签订合同",@"待发货",@"待收货",@"待评价"];
                NSArray *badgeArr=@[@(_dataModel.bookOrder),@(_dataModel.unSend),@(_dataModel.unRecieve),@(_dataModel.unEvaluate)];
                BoughtInfoBtnTableViewCell *view=[[BoughtInfoBtnTableViewCell alloc] initWithTitleArr:titleArr andImageArr:arr andBadgeArr:badgeArr];
                view.frame=cell.bounds;
                [cell addSubview:view];
                return cell;
                
            }
        }
       else if ([self.roleIDnum isEqualToNumber:@2]&&indexPath.section==3){
            
            if (indexPath.row==0) {
                static NSString *OneCellID33=@"OneCellID33";
                OneCellTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:OneCellID33];
                
                if (cell==nil) {
                    cell=[[OneCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OneCellID33];
                }
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
                cell.namelabel.text=@"商品管理";
                
                return cell;
            }
            else{
                static NSString *BoughtInfoBtnID33=@"BoughtInfoBtnID33";
                UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:BoughtInfoBtnID33];
                
                if (cell==nil) {
                    cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BoughtInfoBtnID33];
                }
                NSArray *arr=@[@"hetong.png",@"daifahuo.png",@"daishouhuo.png",@"daipingjia.png"];
                NSArray *titleArr=@[@"已入库",@"审核中",@"审核通过",@"审核不通过"];
                NSArray *badgeArr=@[@(_dataModel.warehousing),@(_dataModel.uncheckProduct),@(_dataModel.checkSuccessProduct),@(_dataModel.checkFailProduct)];
                BoughtInfoBtnTableViewCell *view=[[BoughtInfoBtnTableViewCell alloc] initWithTitleArr:titleArr andImageArr:arr andBadgeArr:badgeArr];
                view.frame=cell.bounds;
                [cell addSubview:view];
                return cell;
                
            }
        }
         #pragma mark ==========总队section=3 section=4==========
       else if ([self.roleIDnum isEqualToNumber:@5]){
           if (indexPath.section==3) {
               static NSString *NornalID33=@"NornalID33";
               NomalTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:NornalID33];
               
               if (cell==nil) {
                   cell=[[NomalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NornalID33];
               }
               cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
               cell.iconImageView.image=[UIImage imageNamed:@"zengjiagongyinshang.png"];
               cell.titleLabel.text=@"增加供应商";
               return cell;
           }
           if (indexPath.section==4){
               
               static NSString *NornalID44=@"NornalID44";
               NomalTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:NornalID44];
               
               if (cell==nil) {
                   cell=[[NomalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NornalID44];
               }
               cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
               cell.iconImageView.image=[UIImage imageNamed:@"zengjiashangp.png"];
               cell.titleLabel.text=@"增加商品";
               return cell;
           }
           
           
       }
      
        
        
           }
        return nil;
    }




-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.roleIDnum!=NULL&&section==0) {
        OneCellView *headCellView =[[OneCellView  alloc] initWithRoleID:self.roleIDnum];
       
        headCellView.frame=CGRectMake(0, 0, kScreenWidth, 70);
        __weak typeof(self)WeakSelf=self;
        [headCellView setSendViewController:^(UIViewController *controller) {
            [WeakSelf.navigationController pushViewController:controller animated:NO];
        }];
        
        return  headCellView;
    }
    return nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.roleIDnum!=NULL) {
    
        if ([self.roleIDnum isEqualToNumber:@1] &&indexPath.section==1) {
            if (indexPath.row==0) {
                return 30;
            }
            else{
             return 70;
            }
        }
       else if (([self.roleIDnum isEqualToNumber:@2]||[self.roleIDnum isEqualToNumber:@4]||[self.roleIDnum isEqualToNumber:@5]) &&indexPath.section==1) {
           
            return 50;
            
        }
       else if ([self.roleIDnum isEqualToNumber:@2] &&(indexPath.section==2 ||indexPath.section==3)) {
           
           if (indexPath.row==0) {
               return 30;
           }
           else{
               return 70;
           }
           
       }
       else if (([self.roleIDnum isEqualToNumber:@4]||[self.roleIDnum isEqualToNumber:@5]) &&indexPath.section==2 ) {
           
           if (indexPath.row==0) {
               return 30;
           }
           else{
               return 70;
           }
           
       }
       else if ([self.roleIDnum isEqualToNumber:@5] &&(indexPath.section==3||indexPath.section==4)){
           
           return 50;
       }
        
        return 0;
       
    }
    return 50;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (self.roleIDnum!=NULL&&section==0) {
        return 70;
    }
    return 10;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight =70;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y > 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//         _headView.frame=CGRectMake(0, -scrollView.contentOffset.y, kScreenWidth, 100);
        
    } else {
        if (scrollView.contentOffset.y >= sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
    
 
  
    
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
