//
//  CommentsViewController.m
//  FireEquipment
//
//  Created by mc on 2017/11/24.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "CommentsViewController.h"
#import "CommentsTableViewCell.h"
#import "ZFJSegmentedControl.h"
#import "CommentsModel.h"
@interface CommentsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) ZFJSegmentedControl *segementControl;
@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) NSMutableArray *goodArr;
@property (nonatomic,strong) NSMutableArray *midArr;
@property (nonatomic,strong) NSMutableArray *badArr;

@end

@implementation CommentsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self addLeftBarButtonWithImage:@"back.png"];
    self.title=@"全部评论";
   
    _mainTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, NaviHeight, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    _mainTableView.estimatedRowHeight = 0;
    _mainTableView.estimatedSectionHeaderHeight = 0;
    _mainTableView.estimatedSectionFooterHeight = 0;
    _mainTableView.delegate=self;
    _mainTableView.dataSource=self;
     [self.view addSubview:_mainTableView];

    
    [self setHeadButtonView];
    [self postDataFromSeverWithURL:@"http://equipmentapp.qianchengwl.cn/api/show/getAllCom"];
    UIView *uView=[UIView new];
    uView.frame=CGRectMake(0, 0, kScreenWidth, 10);
    uView.backgroundColor=[UIColor colorWithHexString:@"#f2f2f2"];
    self.mainTableView.tableHeaderView=uView;
    self.mainTableView.sectionHeaderHeight=10;
    
//    NSLog(@"self.titleCountArr:%@",self.titleCountArr);
}

-(void)setHeadButtonView{
   
    NSArray *arr=@[@"全部评价",@"好评",@"中评",@"差评"];
    if (self.titleCountArr.count==0) {
      self.segementControl = [[ZFJSegmentedControl alloc]initwithTitleArr:arr iconArr:nil SCType:SCType_None];
    }else
    {
    self.segementControl = [[ZFJSegmentedControl alloc]initwithTitleArr:self.titleCountArr iconArr:nil SCType:SCType_None];
    }
   self.segementControl.frame = CGRectMake(20, 0, kScreenWidth-40, NaviHeight);
   self.segementControl.backgroundColor = [UIColor whiteColor];
   self.segementControl.selectBtnSpace = 5;//设置按钮间的间距
//    self.segementControl.selectBtnWID = 70;//设置按钮的宽度 不设就是均分
//        self.segementControl.frame = CGRectMake(10, 0,kScreenWidth-20, NaviHeight);
        self.segementControl.backgroundColor=[UIColor clearColor];
        self.segementControl.selectTitleColor =[UIColor redColor];
        self.segementControl.titleFont = [UIFont systemFontOfSize:15.0f];
        self.segementControl.titleColor=[UIColor blackColor];
    [self.view addSubview:self.segementControl];
    self.segementControl.selectIndex=0;
    __weak typeof(self) Weaksef=self;
     self.segementControl.selectType = ^(NSInteger selectIndex,NSString *selectIndexTitle){
       
         if (selectIndex==0) {
             [Weaksef.mainTableView reloadData];
         }
        else if (selectIndex==1) {
            [Weaksef.mainTableView reloadData];
         }
        else if (selectIndex==2) {
            [Weaksef.mainTableView reloadData];
         }
           [Weaksef.mainTableView reloadData];
         
    };
    
    }




-(void)postDataFromSeverWithURL:(NSString*)URL{
    
    NSNumber * nums = @([@":" integerValue]);
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setValue:self.productIDnum forKey:@"productID"];
    [HTTPRequest POST:URL getToken:nums paramentDict:dict success:^(id responseObj) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
//                 NSLog(@"%@",dict);
        [self.dataArr removeAllObjects];
        [self.goodArr removeAllObjects];
        [self.midArr removeAllObjects];
        [self.badArr removeAllObjects];
        NSArray *Garr=dict[@"content"][@"good"];
        NSArray *Marr=dict[@"content"][@"mid"];
         NSArray *Barr=dict[@"content"][@"bad"];
        for (NSDictionary *obj in Garr) {
            CommentsModel *model=[[CommentsModel alloc] initWithDict:obj];
            [self.goodArr addObject:model];
            [self.dataArr addObject:model];
            
        }
        for (NSDictionary *obj in Marr) {
            CommentsModel *model=[[CommentsModel alloc] initWithDict:obj];
            [self.midArr addObject:model];
            [self.dataArr addObject:model];
        }
        for (NSDictionary *obj in Barr) {
            CommentsModel *model=[[CommentsModel alloc] initWithDict:obj];
            [self.badArr addObject:model];
            [self.dataArr addObject:model];
        }
//        NSLog(@"%@",self.dataArr);
       
//        self.titleCountArr=[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@/n%ld",@"全部评价",self.dataArr.count],[NSString stringWithFormat:@"%@/n%ld",@"好评",self.goodArr.count],[NSString stringWithFormat:@"%@/n%ld",@"中评",self.midArr.count],[NSString stringWithFormat:@"%@/n%ld",@"差评",self.badArr.count],nil];
  
//  @[@"全部评价\n110",@"好评",@"中评",@"差评"]
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
-(NSMutableArray *)goodArr{
    
    if (_goodArr==nil) {
        _goodArr=[NSMutableArray array];
        
    }
    return _goodArr;
}
-(NSMutableArray *)midArr{
    
    if (_midArr==nil) {
        _midArr=[NSMutableArray array];
        
    }
    return _midArr;
}
-(NSMutableArray *)badArr{
    
    if (_badArr==nil) {
        _badArr=[NSMutableArray array];
        
    }
    return _badArr;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.segementControl.selectIndex==0) {
        return self.dataArr.count;
    }
    else if (self.segementControl.selectIndex==1){
        return self.goodArr.count;
    }
    else if (self.segementControl.selectIndex==2){
        return self.midArr.count;
    }
    else if (self.segementControl.selectIndex==3){
        return self.badArr.count;
    }
    
    return self.dataArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CommentssID=@"CommentssID";
    CommentsTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:CommentssID];
    
    if (cell==nil) {
        cell=[[CommentsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommentssID];
    }
    if (self.segementControl.selectIndex==0) {
         CommentsModel *model=self.dataArr[indexPath.row];
         [cell bindDataWithModel:model];
    }
    else if (self.segementControl.selectIndex==1){
        CommentsModel *model=self.goodArr[indexPath.row];
         [cell bindDataWithModel:model];
    }
    else if (self.segementControl.selectIndex==2){
         CommentsModel *model=self.midArr[indexPath.row];
         [cell bindDataWithModel:model];
    }
    else if (self.segementControl.selectIndex==3){
         CommentsModel *model=self.badArr[indexPath.row];
         [cell bindDataWithModel:model];
    }
    else{
        CommentsModel *model=self.dataArr[indexPath.row];
        [cell bindDataWithModel:model];
    }
   
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.dataArr.count==0) {
        return 0;
    }
    else{
    return 110;
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
