//
//  ProtocolAvailabilityViewController.m
//  FireEquipment
//
//  Created by mc on 2017/12/4.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "ProtocolAvailabilityViewController.h"
#import "LeftTableViewCell.h"
#import "CatlistModel.h"
#import "CalssificationGoodsViewController.h"
#import "LLSearchViewController.h"
@interface ProtocolAvailabilityViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UIButton *searchButton;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;

@property (nonatomic, strong) NSMutableArray *leftDataArr;
@property (nonatomic, strong) NSMutableArray *rightDataArr;
@property (nonatomic,strong) CatlistModel *catlistModel;
@property (nonatomic,strong) NSMutableArray *secendDefaultArr;
@property (nonatomic, strong) NSNumber * secendCatID;

@end
NSInteger row = 0;

@implementation ProtocolAvailabilityViewController
- (NSMutableArray *)leftDataArr{
    if (!_leftDataArr) {
        _leftDataArr = [NSMutableArray array];
    }
    return _leftDataArr;
}
- (NSMutableArray *)rightDataArr{
    if (!_rightDataArr) {
        _rightDataArr = [NSMutableArray array];
    }
    return _rightDataArr;
}
- (NSMutableArray *)secendDefaultArr{
    if (!_secendDefaultArr) {
        _secendDefaultArr = [NSMutableArray array];
    }
    return _secendDefaultArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
        self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
       [self addLeftBarButtonWithImage:@"back.png"];
        [self setupNavItems];
    UITableView *leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 150, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    leftTableView.bounces = NO;
    leftTableView.rowHeight = 45;
    leftTableView.estimatedSectionHeaderHeight = 0;
    leftTableView.estimatedSectionFooterHeight = 0;
    leftTableView.estimatedRowHeight = 0;
    leftTableView.showsVerticalScrollIndicator=NO;
    [leftTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:leftTableView];
    self.leftTableView = leftTableView;
    leftTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
   
    
    UITableView *rightTabeView = [[UITableView alloc] initWithFrame:CGRectMake(150, 0, self.view.frame.size.width - 150, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    rightTabeView.bounces = NO;
    rightTabeView.delegate = self;
    rightTabeView.dataSource = self;
    rightTabeView.rowHeight = 45;
    rightTabeView.estimatedSectionHeaderHeight = 0;
    rightTabeView.estimatedSectionFooterHeight = 0;
    rightTabeView.estimatedRowHeight = 0;
    [rightTabeView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:rightTabeView];
    self.rightTableView = rightTabeView;
    rightTabeView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self postCalssFromSeverWithURL:@"http://equipmentapp.qianchengwl.cn/api/supply/getCatList"];
    
   
}

#pragma mark ========== 设置搜索框按钮==========
- (void)setupNavItems
{
    self.searchButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,230, 20)];

    [self.searchButton setImage:[UIImage imageNamed:@"sousuo.png"] forState:UIControlStateNormal];
    [self.searchButton.layer setMasksToBounds:YES];
    [self.searchButton.layer setCornerRadius:5];
    self.searchButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //    [self.searchButton setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [self.searchButton setBackgroundColor:[UIColor whiteColor]];
    [self.searchButton addTarget:self action:@selector(onClickSearchBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = self.searchButton;

    //    self.navigationItem.searchController;
}

#pragma mark ========== 搜索按钮点击事件==========
-(void)onClickSearchBtn{
    LLSearchViewController *searchVc=[[LLSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVc animated:YES];

}
-(NSNumber *)getToken{
    NSUserDefaults *defauts=[NSUserDefaults standardUserDefaults];
    NSDictionary *userDict= [defauts objectForKey:@"userInfoDic"];
   
   return  userDict[@"content"][@"token"];
    
}
#pragma mark ========== 得到一级分类列表数据==========

-(void)postCalssFromSeverWithURL:(NSString *)url{
   
    [HTTPRequest POST:url getToken:[self getToken] paramentDict:nil success:^(id responseObj) {
        //请求成功返回数据；需要转化成字典（即json格式数据）
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
//                NSLog(@"%@",dict);
        
        NSArray *arr=dict[@"content"][@"first"];
         [self.leftDataArr removeAllObjects];
        for (NSDictionary *obj in arr) {
            CatlistModel *model=[[CatlistModel alloc] initWithDict:obj];
            [self.leftDataArr addObject:model];
            
        }
        NSArray *secendArr=dict[@"content"][@"second"];
         [self.secendDefaultArr removeAllObjects];
        for (NSDictionary *obj in secendArr) {
            _catlistModel=[[CatlistModel alloc] initWithDict:obj];
            [self.secendDefaultArr addObject:_catlistModel];
            
        }
        
                [self.leftTableView reloadData];
                [self.rightTableView reloadData];
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

#pragma mark ==========根据一级分类得到二级分类==========

-(void)getSecendClassFromSeverWithURL:(NSString *)URL andCatID:(NSNumber *)catID{
    
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:catID forKey:@"catID"];
    [HTTPRequest POST:URL getToken:[self getToken] paramentDict:dic success:^(id responseObj) {
        //请求成功返回数据；需要转化成字典（即json格式数据）
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
        NSArray *arr=dict[@"content"][@"second"];
        [self.rightDataArr removeAllObjects];
        for (NSDictionary *obj in arr) {
            CatlistModel *model=[[CatlistModel alloc] initWithDict:obj];
            [self.rightDataArr addObject:model];
            
        }
        [self.rightTableView reloadData];
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return self.leftDataArr.count;
    }else{
        if (self.secendDefaultArr.count!=0) {
            return self.secendDefaultArr.count;
        }
        else{
        return self.rightDataArr.count;
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        static NSString *leftCellID=@"leftCellID";
         LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:leftCellID];
        if (cell==nil) {
            cell = [[LeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftCellID];
        }
        CatlistModel *model=self.leftDataArr[indexPath.row];
        cell.nameLabel.text =model.catName;
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
    
        return cell;
    }else{
        
         static NSString *rightCellID=@"rightCellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rightCellID];
        if (cell==nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rightCellID];
        }
        cell.textLabel.font=[UIFont systemFontOfSize:15];
        cell.textLabel.textColor=[UIColor colorWithHexString:@"#282828"];
        if (self.secendDefaultArr.count!=0) {
            _catlistModel=self.secendDefaultArr[indexPath.row];
            cell.textLabel.text =_catlistModel.catName;
//            self.secendCatID=_catlistModel.catID;
        }
        else{
            CatlistModel *model=self.rightDataArr[indexPath.row];
            cell.textLabel.text =model.catName;
            
        }
      
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (tableView == self.leftTableView) {
       
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
      
        [self.secendDefaultArr removeAllObjects];
        CatlistModel *model=self.leftDataArr[indexPath.row];
       
        [self getSecendClassFromSeverWithURL:@"http://equipmentapp.qianchengwl.cn/api/supply/getCatList" andCatID:model.catID];

    }else{

      
        if (self.secendDefaultArr.count!=0) {
             _catlistModel=self.secendDefaultArr[indexPath.row];
            self.secendCatID=_catlistModel.catID;
        }
        else{
            CatlistModel *model=self.rightDataArr[indexPath.row];
             self.secendCatID=model.catID;
        }
        CalssificationGoodsViewController *classVC=[[CalssificationGoodsViewController alloc] init];
        classVC.catIDNum=self.secendCatID;
        classVC.HomeOrProtocol=@"协议供货";
        classVC.indexPathRow=indexPath.row;
        [self.navigationController pushViewController:classVC animated:NO];
    }
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
