//
//  ShopGoodsClassViewController.m
//  FireEquipment
//
//  Created by mc on 2017/12/8.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "ShopGoodsClassViewController.h"
#import "FirstClassModel.h"
#import "SecendClassModel.h"
#import "ZHCustomBtn.h"
#import "ZHBtnSelectView.h"
@interface ShopGoodsClassViewController ()<UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,ZHBtnSelectViewDelegate>

@property(nonatomic,strong)UITableView    *mainTableView;
@property (nonatomic,strong) NSMutableArray *fristArr;
@property (nonatomic,strong) NSMutableArray *secendArr;
@property (nonatomic,weak)ZHCustomBtn *currentBtn;
@property (nonatomic,weak)ZHBtnSelectView *btnView;
@property (nonatomic,strong) NSNumber *sectionCatIDNum;

@end

@implementation ShopGoodsClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"商品分类";
    [self addLeftBarButtonWithImage:@"back.png"];
    [self getProductDataFromSeverWithUrl:@"http://equipmentapp.qianchengwl.cn/api/show/getPrepCat" andSellerID:self.sellerIDNum];
    
    _mainTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    _mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _mainTableView.estimatedRowHeight = 0;
    _mainTableView.estimatedSectionHeaderHeight = 0;
    _mainTableView.estimatedSectionFooterHeight = 0;
    _mainTableView.delegate=self;
    _mainTableView.dataSource=self;
    _mainTableView.sectionHeaderHeight=40;
    [self.view addSubview:_mainTableView];
    
}


-(NSNumber *)getToken{
    NSUserDefaults *defauts=[NSUserDefaults standardUserDefaults];
    NSDictionary *userDict= [defauts objectForKey:@"userInfoDic"];
    
    return  userDict[@"content"][@"token"];
    
}



-(NSMutableArray *)fristArr{
    
    if (_fristArr==nil) {
        _fristArr=[NSMutableArray array];
    }
    return _fristArr;
}

-(NSMutableArray *)secendArr{
    
    if (_secendArr==nil) {
        _secendArr=[NSMutableArray array];
    }
    return _secendArr;
}





-(void)getProductDataFromSeverWithUrl:(NSString *)URL andSellerID:(NSUInteger)sellerIDnum{
    
    NSNumber * nums =nil;
//    if ([self.HomeOrProtocol isEqualToString:@"首页进入"]) {
        nums = @([@":" integerValue]);
//    }else{
    
        nums=[self getToken];
        
        //        NSLog(@"协议供货");
//    }
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setValue:@(sellerIDnum) forKey:@"sellerID"];
   
    
    [HTTPRequest POST:URL getToken:nums paramentDict:dict success:^(id responseObj) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
//         NSLog(@"%@",dict);
        [self.fristArr removeAllObjects];
        [self.secendArr removeAllObjects];
//    NSString *str=[[NSString alloc] initWithData:responseObj encoding:NSUTF8StringEncoding];
//         NSLog(@"----%@",str);
        NSArray *firstArrary=dict[@"content"][@"catList"];

        for (NSDictionary *obj in firstArrary) {
            FirstClassModel *model=[[FirstClassModel alloc] initWithDict:obj];
            [self.fristArr addObject:model];
            
            for (int i=0;i< ((NSArray *)obj[@"list"]).count ;i++) {
                SecendClassModel *modelss=[[SecendClassModel alloc] init];
                if (modelss.catName!=NULL) {
                    [model.list addObject:modelss];
                }
               
            }
            

        }
    
        [self.mainTableView reloadData];
        
       
     
    } failure:^(NSError *error) {
        
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.fristArr.count+1;
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
   
    if (section==0) {
        return 0;
    }else{
//         FirstClassModel *model=self.fristArr[section-1];
//         return model.list.count;
        return 1;
    }
    
  
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellheadID=@"cellheadID";
    
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellheadID];
    }
    if (indexPath.section!=0) {
        FirstClassModel *model=self.fristArr[indexPath.section-1];
        NSMutableArray  *catnameArr=[NSMutableArray array];
        NSMutableArray  *catIDNumArr=[NSMutableArray array];
        for (int i=0; i<model.list.count; i++) {
             SecendClassModel *modelsss=model.list[i];
              [catnameArr addObject:modelsss.catName];
            [catIDNumArr addObject:modelsss.catID];
        }
        
      
        
        
        // 自动计算view的高度
        ZHBtnSelectView *btnView = [[ZHBtnSelectView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,  0)
                                                                   titles:[catnameArr copy] catIDnum:[catIDNumArr copy] column:2];
        [cell addSubview:btnView];
        btnView.backgroundColor = [UIColor whiteColor];
        
        btnView.verticalMargin = 10;
        btnView.delegate = self;
        self.btnView = btnView;
        
        self.btnView.selectType = BtnSelectTypeSingleChoose;

    }
   

    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return self.btnView.frame.size.height;
}




-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    UIButton *sendButton=[UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame=CGRectMake( kScreenWidth-50, 0, 40, 40);
    [sendButton setImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    sendButton.tag=100+section;
    [sendButton addTarget:self action:@selector(senderButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:sendButton];
    backView.backgroundColor =[UIColor whiteColor];
    UILabel *nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 40)];
    nameLabel.textColor=[UIColor colorWithHexString:@"#333333"];
    nameLabel.font=[UIFont systemFontOfSize:15];
    [backView addSubview:nameLabel];
    if (section==0) {
        nameLabel.text=@"全部商品";
    }
    else{
        FirstClassModel *model=self.fristArr[section-1];
        [sendButton setTitle:[NSString stringWithFormat:@"%@",model.catID] forState:UIControlStateNormal];
       nameLabel.text=[NSString stringWithFormat:@"%@", model.catName];

    }
    return backView;
}

#pragma mark ==========右侧点击事件==========
-(void)senderButtonDidPress:(UIButton *)sender{
//    NSLog(@"%ld",sender.tag);
    if (sender.tag==100) {
        [self.navigationController popViewControllerAnimated:NO];
    }
    else{
        if (self.catIDBlock) {
            self.catIDBlock(@([sender.titleLabel.text integerValue]));
//            NSLog(@"self.sectionCatIDNum:%@",sender.titleLabel.text);
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *backView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, kScreenWidth)];
    backView.backgroundColor=[UIColor colorWithHexString:@"#eeeeee"];
    
    return backView;
}



- (void)btnSelectView:(ZHBtnSelectView *)btnSelectView selectedBtn:(ZHCustomBtn *)btn {
    //
    //    if (self.btnView.selectType) { // 多选
    //        btn.btnSelected = !btn.btnSelected;
    //        if (btn.btnSelected) {
    //            [self.titleArr addObject:btn.titleLabel.text];
    //        } else {
    //            [self.titleArr removeObject:btn.titleLabel.text];
    //        }
    //
    //        NSLog(@"--%@--",self.titleArr);
    //
    //    } else { // 单选
    if (btn.btnSelected) return;
    
    self.currentBtn.btnSelected = NO;
    self.currentBtn = btn;
    btn.btnSelected = YES;
    
//    NSLog(@"---%@--%@",self.currentBtn.titleLabel.text,self.currentBtn.selectCatIDNum);
    
    if (self.catIDBlock) {
        self.catIDBlock(self.currentBtn.selectCatIDNum);
        [self.navigationController popViewControllerAnimated:NO];
    }
    //    }
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
