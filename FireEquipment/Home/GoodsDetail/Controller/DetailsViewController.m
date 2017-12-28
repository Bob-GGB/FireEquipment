//
//  DetailsViewController.m
//  FireEquipment
//
//  Created by mc on 2017/11/24.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "DetailsViewController.h"
#import "GoodsDetailImagesTableViewCell.h"
@interface DetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation DetailsViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
  
  
    self.dataArr =[[NSUserDefaults standardUserDefaults] objectForKey:@"KdetailImageArr"];
    
    [self.mainTableView reloadData];
    
//    NSLog(@"----%@",self.dataArr);
}



- (void)viewDidLoad {
    [super viewDidLoad];
     [self addLeftBarButtonWithImage:@"back.png"];
    self.title=@"产品详情";
    [_mainTableView removeFromSuperview];
    _mainTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
   
    [_mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
     _mainTableView.estimatedRowHeight = 0;
    _mainTableView.estimatedSectionHeaderHeight = 0;
    _mainTableView.estimatedSectionFooterHeight = 0;
    _mainTableView.delegate=self;
    _mainTableView.dataSource=self;
    
    [self.view addSubview:_mainTableView];
    
    
//    [self.dataArr removeAllObjects];
//    NSMutableArray *arr=[NSMutableArray array];
//    [arr removeAllObjects];
//    arr =[[NSUserDefaults standardUserDefaults] objectForKey:@"KdetailImageArr"];
//    for (NSData *data in arr) {
//        NSString *str=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        [self.dataArr addObject:str];
//    }
    [_mainTableView reloadData];
    
}




-(NSMutableArray *)dataArr{
    
    if (_dataArr==nil) {
        _dataArr=[NSMutableArray array];
        
    }
    return _dataArr;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    if (section==0) {
        return 1;
    }
    else{
    return self.dataArr.count;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     if (indexPath.section==0){
        
        static NSString *destailID=@"destailID";
        UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:destailID];
        
        if (cell==nil) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:destailID];
        }
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0,kScreenWidth);
        [cell.textLabel setFrame:CGRectMake(0, 10, kScreenWidth, 30)];
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        cell.textLabel.textColor=[UIColor colorWithHexString:@"#757575"];
        cell.textLabel.text=@"产品详情";
        
        return cell;
    }
    else if (indexPath.section==1){
        
        static NSString *GoodsDetailImagesID=@"GoodsDetailImagesID";
        GoodsDetailImagesTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:GoodsDetailImagesID];
        
        if (cell==nil) {
            cell=[[GoodsDetailImagesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GoodsDetailImagesID];
        }
        
        if (![self.dataArr[indexPath.row]  isKindOfClass:[NSNull class]]&&indexPath.row<self.dataArr.count) {
            [cell.detailImageView sd_setImageWithURL:[NSURL URLWithString:self.dataArr[indexPath.row]]];
        }
        
        
        
        return cell;
    }
    return nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return 30;
    }
    else{
        return 400;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
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
