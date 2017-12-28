//
//  BrandListViewController.m
//  FireEquipment
//
//  Created by mc on 2017/11/22.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "BrandListViewController.h"
#import "UIViewController+CWLateralSlide.h"
#import "BrandListTableViewCell.h"
#import "BrandModel.h"
#import "LZSortTool.h"
#import "CWDrawerTransition.h"
#import "LGUIView.h"
@interface BrandListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong)NSMutableArray *nameArray;
@property (nonatomic,strong) NSNumber  *brandIDNum;
@property (nonatomic,strong) NSMutableArray *suoyinArr;//索引
@property (nonatomic,strong)  LGUIView * lgView; //索引视图
@end

@implementation BrandListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNavHeadView];
    if ([self.HomeOrProtocol isEqualToString:@"首页进入"]) {
        [self postToSeVerGetBrandDataWithURL:@"http://equipmentapp.qianchengwl.cn/api/show/getBrandListByCat"];
    }else{
        
        [self postToSeVerGetBrandDataWithURL:@"http://equipmentapp.qianchengwl.cn/api/supply/getBrandList"];
    }
   
    
    _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, NaviHeight,self.view.frame.size.width*0.75, kScreenHeight-(Is_Iphone_X ? 88 : 64)) style:UITableViewStylePlain];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _mainTableView.rowHeight = 50;
//    _mainTableView.sectionIndexColor=[UIColor colorWithHexString:@"#b6463b"];
//    [_mainTableView setSectionIndexBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_mainTableView];


}

//创建索引视图
-(void)creatLGView
{
    
    _lgView = [[LGUIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.mainTableView.frame) - 40, 100,30, _lgView.ViewHeigth) indexArray:[self.suoyinArr copy]];

    [_lgView.layer setBorderWidth:1];
    [_lgView .layer setBorderColor:[UIColor colorWithHexString:@"#d3d3d3"].CGColor];
    [_lgView.layer setCornerRadius:16];
    [self.view addSubview:_lgView];
    
    [_lgView selectIndexBlock:^(NSInteger section)
     {
         [_mainTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]
                                     animated:NO
                               scrollPosition:UITableViewScrollPositionTop];
         
         NSDictionary *dic = [_dataArr objectAtIndex:section];
         BrandModel *p = [[dic objectForKey:LZSortToolValueKey] objectAtIndex:0];
         self.brandIDNum=p.brandID;
         NSUserDefaults *defautls=[NSUserDefaults standardUserDefaults];
         [defautls removeObjectForKey:@"KbrandID"];
         [defautls setValue:p.brandID forKey:@"KbrandID"];
         [defautls synchronize];
     }];
}
#pragma mark ========== 创建导航栏视图==========
-(void)creatNavHeadView{
    
    UIView *alView=[[UIView alloc] initWithFrame:CGRectMake(0,10, kScreenWidth, NaviHeight- (Is_Iphone_X ?44.f : 20.f))];
    alView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:alView];
    CGFloat Wisth=alView.frame.size.height;
    for (int i=0; i<2; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [alView addSubview:btn];
        btn.frame=CGRectMake((kScreenWidth*0.75-Wisth)*i,0, Wisth, Wisth);//kScreenWidth*0.75是侧滑之后View的宽度
        [btn setTitleColor:[UIColor colorWithHexString:@"#282828"]forState:UIControlStateNormal];
        if (i==0) {
            [btn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        }
        else{
            
            [btn setTitle:@"保存" forState:UIControlStateNormal];
        }
        btn.tag=100+i;
        [btn addTarget:self action:@selector(headButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    UILabel *label=[[UILabel alloc] init];
    label.textColor=[UIColor colorWithHexString:@"#282828"];
    label.text=@"品牌";
    label.font=[UIFont systemFontOfSize:18];
    label.textAlignment=NSTextAlignmentCenter;
    [alView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(alView.mas_top);
        make.left.equalTo(@100);
        make.size.mas_offset(CGSizeMake(80, Wisth));
    }];
    
    
}
-(void)headButtonDidPress:(UIButton *)sender{
//    NSLog(@"%ld",sender.tag);
    if (sender.tag==100) {
        NSUserDefaults *defauts=[NSUserDefaults standardUserDefaults];
        [defauts removeObjectForKey:@"KbrandID"];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        NSLog(@"self.brandIDNum:%@",self.brandIDNum);
        if (self.brandIDNum !=NULL) {
            
            NSUserDefaults *defauts=[NSUserDefaults standardUserDefaults];
            [defauts removeObjectForKey:@"KbrandID"];
            [defauts setObject:self.brandIDNum forKey:@"KbrandID"];
            [defauts synchronize];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else{
        [MBPHudView showHUDWithText:@"请选择品牌"];
        }
    }
}


-(NSNumber *)getToken{
    NSUserDefaults *defauts=[NSUserDefaults standardUserDefaults];
    NSDictionary *userDict= [defauts objectForKey:@"userInfoDic"];
    
    return  userDict[@"content"][@"token"];
    
}
#pragma mark ========== 获取服务器品牌数据==========
-(void)postToSeVerGetBrandDataWithURL:(NSString *)URL{
    
    NSNumber * nums =nil;
    if ([self.HomeOrProtocol isEqualToString:@"首页进入"]) {
        nums = @([@":" integerValue]);
    }else{
        
        nums=[self getToken];
        
    }
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setValue:self.CatID forKey:@"catID"];
//    NSLog(@"self.CatID:%@",self.CatID);
    [HTTPRequest POST:URL getToken:nums paramentDict:dict success:^(id responseObj) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
        
//        NSLog(@"%@",dict);
        NSMutableArray *pArray = [NSMutableArray arrayWithCapacity:0];
        [pArray removeAllObjects];
        [self.dataArr removeAllObjects];
        NSArray *arr=dict[@"content"][@"brandList"];
        for (NSDictionary *dic in arr) {
            BrandModel *model=[[BrandModel alloc] initWithDict:dic];
            //去掉字符串中的空格
            model.brandName = [model.brandName stringByReplacingOccurrencesOfString: @" " withString: @""];
            model.brandName = [model.brandName stringByReplacingOccurrencesOfString: @"\n" withString: @""];
            model.brandName = [model.brandName stringByReplacingOccurrencesOfString: @"\\" withString: @""];
            [pArray addObject:model];
        }
        NSArray *pArr = [LZSortTool sortObjcs:pArray byKey:@"brandName" withSortType:LZSortResultTypeDoubleValues];
          _dataArr = [NSMutableArray arrayWithArray:pArr];
        
        [self.mainTableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
       
    
}

-(NSMutableArray *)dataArr{
    if (_dataArr==nil) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSDictionary *dic = [_dataArr objectAtIndex:section];
    return [[dic objectForKey:LZSortToolValueKey] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *IDEvent=@"IDEvent";
    BrandListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDEvent];
    if (cell == nil) {
        cell = [[BrandListTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:IDEvent];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    NSDictionary *dic = [_dataArr objectAtIndex:indexPath.section];
    BrandModel *p = [[dic objectForKey:LZSortToolValueKey] objectAtIndex:indexPath.row];
    cell.nameLabel.text = p.brandName;
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSDictionary *dic = [_dataArr objectAtIndex:section];
    self.suoyinArr =[NSMutableArray array];
   
    for (NSDictionary *obj in _dataArr) {
       [self.suoyinArr addObject:[obj objectForKey:LZSortToolKey]];
    }
    [self creatLGView];
    return [dic objectForKey:LZSortToolKey];
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
      [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    NSDictionary *dic = [_dataArr objectAtIndex:indexPath.section];
    BrandModel *p = [[dic objectForKey:LZSortToolValueKey] objectAtIndex:indexPath.row];
    self.brandIDNum=p.brandID;
    NSUserDefaults *defautls=[NSUserDefaults standardUserDefaults];
    [defautls removeObjectForKey:@"KbrandID"];
    [defautls setValue:p.brandID forKey:@"KbrandID"];
    [defautls synchronize];
    
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
