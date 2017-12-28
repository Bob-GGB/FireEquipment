//
//  HomeViewController.m
//  FireEquipment
//
//  Created by mc on 2017/10/19.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "HomeViewController.h"
//#import "WRNavigationBar.h"
#import "ImagesScrollView.h"
#import "HeaderReusableView.h"
#import "FooterReusableView.h"
#import "ServiceLayout.h"
#import "MenuCollectionViewCell.h"
#import "HotGoodsCollectionViewCell.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "RecommendCollectionViewCell.h"
#import "IndexModel.h"
#import "HotProductListModel.h"
#import "SelectProductListModel.h"
#import "CatlistModel.h"
#import "GoodsDetailViewController.h"
#import "CalssificationGoodsViewController.h"

@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,ServiceLayoutDelegate>
@property (nonatomic, strong) UIButton *searchButton;
@property(nonatomic,strong) UICollectionView *mainCollectionView;
@property (nonatomic,strong) NSMutableArray *titleNameArr;
@property (nonatomic,strong) NSMutableArray *hotGoodsDataArr;
@property (nonatomic,strong) NSMutableArray *selectGoodsDataArr;
@property (nonatomic,strong) NSArray *nameArr;
@property (nonatomic,strong) NSNumber *productIDnum;

@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.barTintColor=[UIColor redColor];
    
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
     self.edgesForExtendedLayout = UIRectEdgeNone;
//    [self wr_setNavBarBackgroundImage:[UIImage imageNamed:@"imageNav"]];
   
    [self setupNavItems];
    [self PostToSeverWithUrl:@"http://equipmentapp.qianchengwl.cn/api/show/index"];
//     self.navigationController.navigationBar.barTintColor=[UIColor redColor];

   
}


#pragma mark ========== 懒加载==========
-(NSMutableArray *)titleNameArr{
    
    if (_titleNameArr==nil) {
        _titleNameArr =[NSMutableArray array];
    }
    return _titleNameArr;
}
-(NSMutableArray *)hotGoodsDataArr{
    
    if (_hotGoodsDataArr==nil) {
        _hotGoodsDataArr =[NSMutableArray array];
    }
    return _hotGoodsDataArr;
}

-(NSMutableArray *)selectGoodsDataArr{
    
    if (_selectGoodsDataArr==nil) {
        _selectGoodsDataArr =[NSMutableArray array];
    }
    return _selectGoodsDataArr;
}

#pragma mark ========== 添加collectionView==========
- (void)loadView {
    [super loadView];
    
    //添加collectionView
    [self.view addSubview:self.mainCollectionView];
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

#pragma mark ========== post商品数据请求==========
-(void)PostToSeverWithUrl:(NSString *)url{
    
    NSNumber * nums = @([@":" integerValue]);
    [HTTPRequest POST:url getToken:nums paramentDict:nil success:^(id responseObj) {
        //请求成功返回数据；需要转化成字典（即json格式数据）
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"%@",dict);
        NSArray *arr=dict[@"content"][@"hotProductList"];
        for (NSDictionary *obj in arr) {
            HotProductListModel *model=[[HotProductListModel alloc] initWithDict:obj];
            [self.hotGoodsDataArr addObject:model];
        }
        NSArray *selectArr=dict[@"content"][@"selectProductList"];
        for (NSDictionary *obj in selectArr) {
            SelectProductListModel *model=[[SelectProductListModel alloc] initWithDict:obj];
            [self.selectGoodsDataArr addObject:model];
        }
        
        [self.mainCollectionView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

-(void)postCalssFromSeverWithURL:(NSString *)url{
    NSNumber * nums = @([@":" integerValue]);
    [HTTPRequest POST:url getToken:nums paramentDict:nil success:^(id responseObj) {
        //请求成功返回数据；需要转化成字典（即json格式数据）
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"%@",dict);
        
        NSArray *arr=dict[@"content"];
        for (NSDictionary *obj in arr) {
            CatlistModel *model=[[CatlistModel alloc] initWithDict:obj];
            [self.titleNameArr addObject:model];
            
        }
//        [self.mainCollectionView reloadData];
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

-(void)onClickLeft{
    
    
}

-(void)onClickRight{
    
    
}
-(void)onClickSearchBtn{
    
    
}
#pragma mark ========== 设置mainCollectionView==========
-(UICollectionView *)mainCollectionView{
    if (_mainCollectionView == nil) {
        ServiceLayout *layout = [[ServiceLayout alloc]init];
        layout.delegate = self;
//        layout.headerReferenceSize =CGSizeMake(kScreenWidth,200);//头视图大小
          CGRect frame =CGRectMake(0, 0, kScreenWidth, kScreenHeight-((NaviHeight)+(TabbarHeight)));
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        _mainCollectionView.backgroundColor = [UIColor whiteColor];
        
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        //注册热销好货cell单元格
        [_mainCollectionView registerClass:[HotGoodsCollectionViewCell class] forCellWithReuseIdentifier:@"HotGoodsCollectionViewCell"];
        //注册为你推荐cell单元格
        [_mainCollectionView registerClass:[RecommendCollectionViewCell class] forCellWithReuseIdentifier:@"RecommendCollectionViewCell"];
        //注册头视图
        [_mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        //热销好货头视图
         [_mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeader"];
        //为您推荐头视图
         [_mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"section1Header"];
        //注册脚视图
        [_mainCollectionView registerClass:[FooterReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"ServiceFooterReusableView"];
        //注册cell
        [_mainCollectionView registerClass:[MenuCollectionViewCell class] forCellWithReuseIdentifier:@"MenuCollectionViewCell"];
        
    }
    return _mainCollectionView;
}

#pragma mark - tableview delegate / dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            
            return 8;
           
            break;
        case 1:
            return self.hotGoodsDataArr.count;
            break;
        case 2:
            return self.selectGoodsDataArr.count;
            break;
        default:
            break;
    }
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        MenuCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"MenuCollectionViewCell" forIndexPath:indexPath];
//        [self postCalssFromSeverWithURL:@"http://equipmentapp.qianchengwl.cn/api/show/getCatList"];
//        if (self.titleNameArr.count!=0) {
//             CatlistModel *model=self.titleNameArr[indexPath.item];
//
//        }
       
     self.nameArr=@[@"灭火器材",@"侦检器材",@"防护器材",@"救生器材",@"警戒器材",@"破拆器材",@"照明器材",@"更多器材"];
         NSArray *imageArr=@[@"miehuoqi.png",@"zhenjian.png",@"fanghufu.png",@"jiusheng.png",@"jinshipai.png",@"图层3",@"zhaominggongju.png",@"qita.png"];
//
        cell.imgView.image=[UIImage imageNamed:imageArr[indexPath.row]];
        cell.label.text=self.nameArr[indexPath.row];
        return cell;
    }
    else if(indexPath.section==1){
      HotGoodsCollectionViewCell  *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"HotGoodsCollectionViewCell" forIndexPath:indexPath];
        HotProductListModel *model=self.hotGoodsDataArr[indexPath.row];
        
        [cell BindDataWithModel:model];
        [cell setSendController:^(UIViewController *controller) {
            
            [self.navigationController pushViewController:controller animated:NO];
        }];
    
        return cell;
    }
   
    else if(indexPath.section==2){
        RecommendCollectionViewCell  *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"RecommendCollectionViewCell" forIndexPath:indexPath];
        SelectProductListModel *model=self.selectGoodsDataArr[indexPath.row];

       
        [cell sendDataWithModel:model];
        return cell;
    }
    return [UICollectionViewCell new];
}

//添加headerView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    
     UICollectionReusableView *sectionHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeader" forIndexPath:indexPath];
    
     UICollectionReusableView *section1HeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"section1Header" forIndexPath:indexPath];
    //热销好货image
    UIImageView *headView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 160, 15)];
    [headView setCenter:CGPointMake(kScreenWidth*0.5, sectionHeaderView.frame.size.height*0.5)];
    if (indexPath.section==1) {
       [headView setImage:[UIImage imageNamed:@"rexiao.png"]];
    }
    else{
        
        [headView setImage:[UIImage imageNamed:@"tuijian.png"]];
    }
   
    
    NSArray *localImages = @[@"QQ2017", @"QQ2017", @"QQ2017", @"QQ2017"];
    ImagesScrollView *scrollView =[[ImagesScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 155) images:localImages];
    switch (indexPath.section) {
        case 0:
             [headerView addSubview:scrollView];
            break;
        case 1:
            [sectionHeaderView addSubview:headView];
            break;
        case 2:
            [section1HeaderView addSubview:headView];
            break;
            
        default:
            break;
    }
    
    
   
    
    //判断上面注册的UICollectionReusableView类型
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section==0) {
            return headerView;
        }
       else if (indexPath.section==1) {
          return  sectionHeaderView;
        }
        return section1HeaderView;
        
    }else {
        FooterReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ServiceFooterReusableView" forIndexPath:indexPath];
        if (indexPath.section==0) {
             footerView.imgView.image=[UIImage imageNamed:@"sectionImage"];
        }
       
        return footerView;
    }
}

#pragma mark ---UICollectionViewDelegate
//设置headerView的宽高
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
////    if (section==0) {
//         return CGSizeMake(self.view.bounds.size.width, 200);
////    }
//
//}

-(CGFloat)heightOfSectionFooterForIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==2) {
        return 0;
    }
    return 10;
}
-(CGFloat)heightOfSectionHeaderForIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 155;
    }

    return 36;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CalssificationGoodsViewController *classVC=[[CalssificationGoodsViewController alloc] init];
     GoodsDetailViewController *goodsDetailVC=[[GoodsDetailViewController alloc] init];
   
    if (indexPath.section==0) {
        NSString *name=self.nameArr[indexPath.item];
        classVC.titleStr=name;
        classVC.catIDNum=@(indexPath.item+1);
        classVC.HomeOrProtocol=@"首页进入";
        [self.navigationController pushViewController:classVC animated:NO];
    }
    else if (indexPath.section==1){
        
        HotProductListModel *hotmodel=self.hotGoodsDataArr[indexPath.item];
        
        goodsDetailVC.productIDNum=@(hotmodel.productID);
        goodsDetailVC.HomeOrProtocol=@"首页进入";
        [self.navigationController pushViewController:goodsDetailVC animated:NO];
    }
    else if (indexPath.section==2){
          SelectProductListModel *selectModel=self.selectGoodsDataArr[indexPath.item];
        goodsDetailVC.productIDNum=@(selectModel.productID);
         goodsDetailVC.HomeOrProtocol=@"首页进入";
        [self.navigationController pushViewController:goodsDetailVC animated:NO];
    }
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat minAlphaOffset = NaviHeight;
////    CGFloat maxAlphaOffset =155;
//    CGFloat offset = scrollView.contentOffset.y;
//    CGFloat alpha = (offset - minAlphaOffset) / minAlphaOffset;
    
    if (scrollView.contentOffset.y<=0) {
        
        self.navigationController.navigationBar.barTintColor=[UIColor redColor];
    }
    else{

        self.navigationController.navigationBar.barTintColor=[UIColor greenColor];
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
