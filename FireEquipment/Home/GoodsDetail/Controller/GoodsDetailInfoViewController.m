//
//  GoodsDetailInfoViewController.m
//  FireEquipment
//
//  Created by mc on 2017/11/24.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "GoodsDetailInfoViewController.h"
#import "ImagesScrollView.h"
#import "GoodsBaseInfoTableViewCell.h"
#import "CompanyInfoTableViewCell.h"
#import "ContentModel.h"
#import "CompanyInfoModel.h"
#import "SimilarTableViewCell.h"
#import "SimModel.h"
#import "CommentsTableViewCell.h"
#import "GoodsDetailImagesTableViewCell.h"
#import "CommentsViewController.h"
#import "SellerInfoModel.h"
#import "XFAlertView.h"
#import "BottomButtonView.h"
#import "NoSimilarTableViewCell.h"
#import "GoodsParameterView.h"
@interface GoodsDetailInfoViewController ()<UITableViewDelegate,UITableViewDataSource,delegateColl>
@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) NSMutableArray *goodsImageArr;
@property (nonatomic,strong) NSMutableArray *DetailIamgeArr;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NSMutableArray *comMSGArr;

@property (nonatomic,strong) ContentModel *model;
@property (nonatomic,strong) CompanyInfoModel *companyInfoModel;
@property (nonatomic,strong) CommentsModel *commentsModel;
@property (nonatomic,strong) SellerInfoModel *sellweModel ;
@property (nonatomic,assign) CGFloat  bottomHeight;//tabBar高度


@end

@implementation GoodsDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    if (Is_Iphone_X) {
        self.bottomHeight=34;
    }
    else{
        self.bottomHeight=0;
    }
    if ([self.HomeOrProtocol isEqualToString:@"首页进入"]) {
        _mainTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-self.bottomHeight) style:UITableViewStylePlain];
    }
    else{
           _mainTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-120-self.bottomHeight) style:UITableViewStylePlain];
            BottomButtonView *bottomView=[[BottomButtonView alloc] initWithFrame:CGRectMake(0,kScreenHeight-120-self.bottomHeight, kScreenWidth, 120)];
            
            [self.view addSubview:bottomView];
            
            [bottomView setSendController:^{
                NSArray *myArray = [_comMSGArr copy];
                XFAlertView *alert = [[XFAlertView alloc]initWithArr:myArray CancelBtnimage:@"del.png"];
                [alert show];
            }];
        
        
       
    }
    _mainTableView.estimatedRowHeight = 0;
    _mainTableView.estimatedSectionHeaderHeight = 0;
    _mainTableView.estimatedSectionFooterHeight = 0;
    _mainTableView.delegate=self;
    _mainTableView.dataSource=self;
     [_mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_mainTableView];

    [self postToSeVerGetBrandDataWithURL:@"http://equipmentapp.qianchengwl.cn/api/show/productDetail" andProductID:self.productIDNum];

}
-(NSNumber *)getRoleID{
    NSUserDefaults *defauts=[NSUserDefaults standardUserDefaults];
    NSDictionary *userDict= [defauts objectForKey:@"userInfoDic"];
    
    return  userDict[@"content"][@"roleID"];
    
}

#pragma mark ========== 获取服务器商品详情数据==========
-(void)postToSeVerGetBrandDataWithURL:(NSString *)URL andProductID:(NSNumber *)productID{
    
    NSNumber * nums = @([@":" integerValue]);
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setValue:productID forKey:@"productID"];
    [HTTPRequest POST:URL getToken:nums paramentDict:dict success:^(id responseObj) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
        
//         NSLog(@"%@",dict);
      
        [self.goodsImageArr removeAllObjects];
        [self.DetailIamgeArr removeAllObjects];
        [self.dataArr removeAllObjects];
        [self.comMSGArr removeAllObjects];
        _model=[[ContentModel alloc] initWithDict:dict[@"content"]];
        _companyInfoModel=[[CompanyInfoModel alloc] initWithDict:dict[@"content"][@"company"]];
        _commentsModel=[[CommentsModel alloc] initWithDict:dict[@"content"][@"comments"]];
       
//        [self.DetailIamgeArr addObjectsFromArray:_model.details];
        [self.comMSGArr addObjectsFromArray:_model.comMsg];
        NSArray *arr=dict[@"content"][@"sim"];
        
        NSMutableArray *tmpArr=[NSMutableArray array];
        [tmpArr removeAllObjects];
        for (NSDictionary *dic in arr) {
            SimModel *model=[[SimModel alloc] initWithDict:dic];
            
            [self.dataArr addObject:model];
        }
        
        for (NSString *str in dict[@"content"][@"details"]) {
            [tmpArr addObject:str];
         
        }
        
        
        NSMutableArray *imagesArr=[NSMutableArray array];
        [imagesArr removeAllObjects];
        for (NSString *sss in tmpArr) {
            if (![sss isKindOfClass:[NSNull class]]) {
                NSData *data =[sss dataUsingEncoding:NSUTF8StringEncoding];
                NSString *strs=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
                //url地址中含有汉字，需要进行url转码
                NSString *encodedString=[self URLEncodedString:strs];
//                NSString *encodedStringss = [strs stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [self.DetailIamgeArr addObject:encodedString];
                [imagesArr addObject:encodedString];
            }
           
        }
//        NSLog(@"+++++%@",self.DetailIamgeArr);
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"KdetailImageArr"];
        [[NSUserDefaults standardUserDefaults] setObject:imagesArr forKey:@"KdetailImageArr"];
        [[NSUserDefaults standardUserDefaults] synchronize];
          
        [self.mainTableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}
 //url地址中含有汉字，需要进行url转码
-(NSString *)URLEncodedString:(NSString *)str{
    
    NSString *charactersToEscape = @"?!@#$^&%*+,;='\"`<>()[]{}\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodedUrl = [str stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return encodedUrl;
}


-(NSMutableArray *)dataArr{
    if (_dataArr==nil) {
        _dataArr =[NSMutableArray array];
        
    }
    return _dataArr;
}

-(NSMutableArray *)goodsImageArr{
    if (_goodsImageArr==nil) {
        _goodsImageArr =[NSMutableArray array];
        
    }
    return _goodsImageArr;
}
-(NSMutableArray *)DetailIamgeArr{
    if (_DetailIamgeArr==nil) {
        _DetailIamgeArr =[NSMutableArray array];
        
    }
    return _DetailIamgeArr;
}
-(NSMutableArray *)comMSGArr{
    if (_comMSGArr==nil) {
        _comMSGArr =[NSMutableArray array];
        
    }
    return _comMSGArr;
}


#pragma mark ========== delegate==========
#pragma mark - 数据源方法
//设置组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
}
//设置每一组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==7) {
        return self.DetailIamgeArr.count;
    }
    else{
        return 1 ;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section==0) {
        
         static NSString *goodsDetalID=@"goodsDetalID";
        GoodsBaseInfoTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:goodsDetalID];
        
        if (cell==nil) {
            cell=[[GoodsBaseInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodsDetalID];
        }
        
        cell.titleNameLabel.text=_model.productName;
        cell.priceLabel.text=[NSString stringWithFormat:@"¥%@",_model.price];
        return cell;
    }
    else if (indexPath.section==1){
        
        static NSString *ID=@"goodsID";
        UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell==nil) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor=[UIColor colorWithHexString:@"#282828"];
        cell.textLabel.font=[UIFont systemFontOfSize:16];
        cell.textLabel.text=@"产品参数";
        return cell;
    }
    
    else if (indexPath.section==2){
        
        static NSString *CompanyInfoID=@"CompanyInfoID";
        CompanyInfoTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:CompanyInfoID];
        
        if (cell==nil) {
            cell=[[CompanyInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CompanyInfoID];
        };
        [cell bindDataWithModel:_companyInfoModel];

        //查看单位信息
        [cell setSendController:^{
           NSArray *myArray = [_comMSGArr copy];
            XFAlertView *alert = [[XFAlertView alloc]initWithArr:myArray CancelBtnimage:@"del.png"];
            [alert show];
            
        
    }];
        //进入店铺
        __weak typeof(self)WeakSelf=self;
        [cell setSendControllerView:^(UIViewController *Controller) {
            [WeakSelf.navigationController pushViewController:Controller animated:NO];
        }];
        
        
        return cell;
    }
    else if (indexPath.section==3){
        if (self.dataArr.count>0) {
            static NSString *SimilarID=@"SimilarID";
            SimilarTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:SimilarID];
            
            if (cell==nil) {
                cell=[[SimilarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimilarID];
            }
            //获取到数据后刷新
            cell.HomeArray = self.dataArr;
            [cell.collectionView reloadData];
            cell.collectionView.backgroundColor = [UIColor whiteColor];
            //防止出现collerview滚动
            cell.collectionView.scrollEnabled = NO;
            //实现代理
            cell.delegateColl = self;
            return cell;
        }
        else{
            static NSString *NoSimilarID=@"NoSimilarID";
            NoSimilarTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:NoSimilarID];
            
            if (cell==nil) {
                cell=[[NoSimilarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NoSimilarID];
            }
            return cell;
        }
       
    }
    else if (indexPath.section==4){
        
        static NSString *TableID=@"TableID";
        UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:TableID];
        
        if (cell==nil) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableID];
        }
        cell.textLabel.text=[NSString stringWithFormat:@"评论%@%ld%@",@"(",_model.total,@")"];
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(kScreenWidth-80, 5, 70, 30)];
        [btn setTitleColor:[UIColor colorWithHexString:@"#c8996b"] forState:UIControlStateNormal];
        [btn setTitle:@"查看全部" forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btn addTarget:self action:@selector(LookALLdidPress) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn];
        
        UIView *linView=[UIView new];
        linView.frame=CGRectMake(0, CGRectGetMaxY(cell.frame)-1, kScreenWidth, 1);
        [linView setBackgroundColor:[UIColor colorWithHexString:@"#f2f2f2"]];
        [cell addSubview:linView];
        return cell;
    }
    else if (indexPath.section==5){
        
        static NSString *CommentsID=@"CommentsID";
        CommentsTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:CommentsID];
        
        if (cell==nil) {
            cell=[[CommentsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommentsID];
        }
        
        [cell bindDataWithModel:_commentsModel];
        return cell;
    }
    else if (indexPath.section==6){
        
        static NSString *detailID=@"detailID";
        UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:detailID];
        
        if (cell==nil) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailID];
        }
        [cell.textLabel setFrame:CGRectMake(0, 10, kScreenWidth, 30)];
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        cell.textLabel.textColor=[UIColor colorWithHexString:@"#757575"];
        cell.textLabel.text=@"产品详情";

        return cell;
    }
    else if (indexPath.section==7){
        
        static NSString *GoodsDetailImagesID=@"GoodsDetailImagesID";
        GoodsDetailImagesTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:GoodsDetailImagesID];
        
        if (cell==nil) {
            cell=[[GoodsDetailImagesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GoodsDetailImagesID];
        }
        
        if (![self.DetailIamgeArr[indexPath.row]  isKindOfClass:[NSNull class]]) {
        [cell.detailImageView sd_setImageWithURL:[NSURL URLWithString:self.DetailIamgeArr[indexPath.row]]];
        }
        
    
        
        return cell;
    }
    
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section==0) {
        return 130;
    }
    else if (indexPath.section==1){
        
        return 40;
    }
    else if (indexPath.section==2){
        
        return 140;
    }
    else if (indexPath.section==3){
        
        return 180;
    }
    else if (indexPath.section==4){
        
        return 40;
    }
    else if (indexPath.section==5){
        if (_model.total==0) {
            return 0;
        }
        return 110;
    }
    else if (indexPath.section==6){
        
        return 40;
    }
    else if (indexPath.section==7){
        
        return 400;
    }
    
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return 400;
    }
   else if (section==5||section==7) {
        return 0.1;
    }
    return 10;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        NSArray *localImages =_model.titleImage;
        ImagesScrollView *scrollView =[[ImagesScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 400) images:localImages];
        [scrollView.currentPageLabel removeFromSuperview];
        scrollView.pageControl.frame=CGRectMake(100 , scrollView.frame.size.height - 30, kScreenWidth-200, 30);
        //    [tableView addSubview:scrollView];
        return scrollView;
    }
    else{
    UIView *uView=[UIView new];
    uView.frame=CGRectMake(0, 0, kScreenWidth, 10);
    uView.backgroundColor=[UIColor colorWithHexString:@"#f2f2f2"];
    return uView;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (indexPath.section==1) {
        
        [GoodsParameterView showWithTitle:@"产品参数" ProductID:self.productIDNum selectIndex:^(NSInteger selectIndex) {
            
        } selectValue:^(NSString *selectValue) {
            
        } showCloseButton:YES];
    }
    
}
#pragma mark - 代理用来接收点击的是第几个
-(void)ClickCooRow :(NSInteger)CellRow
{
  
}
#pragma mark - 代理用来接收点击的是第几个
-(void)ClickCooRow:(NSInteger)CellRow andProductNum:(NSInteger)productnum{

    [self postToSeVerGetBrandDataWithURL:@"http://equipmentapp.qianchengwl.cn/api/show/productDetail" andProductID:@(productnum)];
    
}

#pragma mark ========== 查看全部评价按钮==========
-(void)LookALLdidPress{
    
    CommentsViewController *commentVC=[[CommentsViewController alloc] init];
    commentVC.productIDnum=self.productIDNum;
    commentVC.titleCountArr=self.titleCountArr;
    [self.navigationController pushViewController:commentVC animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight =400;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y > 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
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
