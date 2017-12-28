//
//  ShopViewController.m
//  FireEquipment
//
//  Created by mc on 2017/12/7.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "ShopViewController.h"
#import "NormalCell.h"
#import "LongCell.h"
#import "ProductListModel.h"
#import "AdmittanceBrandViewController.h"
#import "UIViewController+CWLateralSlide.h"
#import <MJRefresh/MJRefresh.h>
#import "ShopGoodsClassViewController.h"
#import "GoodsDetailViewController.h"
@interface ShopViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MJRefreshEXDelegate>{
    
    NSInteger statusNum;//价格升降状态
    NSNumber *BrandIDNum;//选择的品牌ID
}


typedef NS_ENUM(NSInteger,CollectionMode){
    CollectionModeNormal,
    CollectionModeLong
};


@property (nonatomic,strong) UIButton *btn;
@property (nonatomic,strong) NSMutableArray  *btnArr;
@property(nonatomic,strong) UICollectionViewFlowLayout * flowLayout;
@property(nonatomic,strong) UICollectionView * allProductCollection;
@property(nonatomic,assign) CollectionMode  mode;
@property (nonatomic,strong) NSMutableArray *dataArr;
//@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,strong) NSNumber *catIDNum;


@end

@implementation ShopViewController


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    BrandIDNum=[defaults valueForKey:@"KbrandID"];
//    if ([defaults valueForKey:@"KbrandID"]!=NULL) {
        [self getProductDataFromSeverWithUrl:@"http://equipmentapp.qianchengwl.cn/api/show/prepShop" andSellerID:self.sellerIDNum];
        //下拉加载更多
        [self setUpRefreshAndLoadMore];
//    }
    
    [defaults removeObjectForKey:@"KbrandID"];
}

//-(void)viewDidDisappear :(BOOL)animated{
//
//    NSLog(@"---%@",self.dataArr);
//
//    if (self.dataArr.count>=10) {
//        //下拉加载更多
//        [self setUpRefreshAndLoadMore];
//    }
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.sellerNameStr;
    [self addLeftBarButtonWithImage:@"back.png"];
    [self addRightBarButtonWithFirstImage:[UIImage imageNamed:@"fenglei.png"] action:@selector(classButton)] ;
    [self setUpBtnUI];
    
   
      _mode = CollectionModeNormal;
    
//    [self getProductDataFromSeverWithUrl:@"http://equipmentapp.qianchengwl.cn/api/show/prepShop" andSellerID:self.sellerIDNum];
    
    //下拉加载更多
    [self setUpRefreshAndLoadMore];
    
}

-(void)setUpBtnUI{
    
    
    self.btnArr=[NSMutableArray array];
    CGFloat w = (kScreenWidth-100)/4;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    NSArray *nomalArr=@[@"datuNomal.png",@"liebiao.png",@"jiages",@"jiagexia",@"shaixuan.png-1"];
    NSArray *selectArr=@[@"datu.png",@"liebiaose.png",@"jiage",@"jiage1",@"shaixuan.png-1"];
    for (int i = 0; i <5; i++) {
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn.tag = 100 + i;
        //        self.btn.backgroundColor = [UIColor greenColor];
        [self.btn addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        //设置边框颜色
        self.btn.layer.borderColor = [[UIColor colorWithHexString:@"#eeeeee"] CGColor];
        //设置边框宽度
        self.btn.layer.borderWidth = 1.0f;
        [self.btn setImage:[UIImage imageNamed:nomalArr[i]] forState:UIControlStateNormal];
        [self.btn setImage:[UIImage imageNamed:selectArr[i]] forState:UIControlStateSelected];
        self.btn.frame = CGRectMake(w*i, 0, w , 40);
       
        if (i==4) {
            self.btn.frame = CGRectMake(w*i, 0,100, 40);
        }
        [self.view addSubview:self.btn];
        [self.btnArr addObject:self.btn];
    }
    ((UIButton *)[self.btnArr objectAtIndex:0]).selected=YES;  // 关键是这里，设置 数组的第一个button为选中状态
     [self addCollectionView];
}

-(NSNumber *)getToken{
    NSUserDefaults *defauts=[NSUserDefaults standardUserDefaults];
    NSDictionary *userDict= [defauts objectForKey:@"userInfoDic"];
    
    return  userDict[@"content"][@"token"];
    
}

#pragma -下拉刷新和上拉加载更多
-(void)setUpRefreshAndLoadMore{
    [self.allProductCollection addFooterWithFooterClass:nil automaticallyRefresh:YES delegate:self];
}
#pragma mark - MJRefreshEXDelegate


- (void)onLoadingMoreData:(id)control pageNum:(NSNumber *)pageNum {
    pageNum=@(2);
    [self loadMoreDataWithPage:[pageNum integerValue]];
    NSInteger page=[pageNum integerValue];
    page++;
    pageNum=@(page);
}

-(void)loadMoreDataWithPage:(NSInteger)page{
    
//    self.pageIndex=2;
    NSNumber * nums =nil;
    if ([self.HomeOrProtocol isEqualToString:@"首页进入"]) {
        nums = @([@":" integerValue]);
    }else{
        
        nums=[self getToken];
        
        //        NSLog(@"协议供货");
    }
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setValue:@(_sellerIDNum) forKey:@"sellerID"];
    [dict setValue:@(page) forKey:@"page"];
    [dict setObject:@(statusNum) forKey:@"status"];
    [dict setValue:BrandIDNum forKey:@"brandID"];
    if (self.catIDNum==nil) {
        self.catIDNum=@0;
    }
    else{
        [dict setObject:self.catIDNum forKey:@"catID"];
    }
    
    NSString *urlStr=@"http://equipmentapp.qianchengwl.cn/api/show/prepShop";
    [HTTPRequest POST:urlStr getToken:nums paramentDict:dict success:^(id responseObj) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
        NSArray *goodsArr=dict[@"content"][@"list"];
        for (NSDictionary *obj in goodsArr) {
            ProductListModel *model=[[ProductListModel alloc] initWithDict:obj];
            [self.dataArr addObject:model];
        }
        //        [self addCollectionView];
       
         [_allProductCollection endFooterRefreshWithChangePageIndex:YES];
        //停止刷新
        if (self.dataArr.count < 60){// 没有数据啦.不能上啦了

             [self.allProductCollection noMoreData];
        }
        else{
            // 5. 结束刷新
           [self.allProductCollection endFooterRefreshWithChangePageIndex:NO];
            
        }
        
         [_allProductCollection reloadData];
        
    } failure:^(NSError *error) {
         [self.allProductCollection endFooterRefreshWithChangePageIndex:NO];
    }];
    
}
#pragma mark ========== 分类按钮==========
-(void)classButton{
    
    ShopGoodsClassViewController *shopVc=[[ShopGoodsClassViewController alloc] init];
    shopVc.sellerIDNum=self.sellerIDNum;
    shopVc.HomeOrProtocol=self.HomeOrProtocol;
    __weak typeof(self)weakSelf=self;
    [shopVc setCatIDBlock:^(NSNumber *catIDnum) {
        weakSelf.catIDNum=catIDnum;
        
    }];
    [self.navigationController pushViewController:shopVc animated:NO];
    
}
//点击事件
- (void)handleClick:(UIButton *)btn{
//    if (!btn.isSelected) {
//        btn.selected = !btn.selected;
//        self.btn.selected = !self.btn.selected;
//        self.btn = btn;
//    }
    
    if (btn!= self.btn) {
        ((UIButton *)[self.btnArr objectAtIndex:0]).selected=NO;
        self.btn.selected = NO;
        btn.selected = YES;
        self.btn = btn;
    }else{
        self.btn.selected = YES;
    }
    
    
    
    if (btn.tag==100) {
        _mode = CollectionModeNormal;
        
    }
    else if (btn.tag==101) {
        
        _mode = CollectionModeLong;
        
    }
    else if (btn.tag==102) {
       statusNum=1;//升序排列
         [self getProductDataFromSeverWithUrl:@"http://equipmentapp.qianchengwl.cn/api/show/prepShop" andSellerID:self.sellerIDNum];
        
    }
    else if (btn.tag==103) {
        statusNum=2;//降序排列
        [self getProductDataFromSeverWithUrl:@"http://equipmentapp.qianchengwl.cn/api/show/prepShop" andSellerID:self.sellerIDNum];
        
    } else{
        [self drawerMaskAnimationRight];
    }
    
    
    
     [self collectionViewMode:_mode];
}


- (void)drawerMaskAnimationRight{
    
    AdmittanceBrandViewController *vc = [[AdmittanceBrandViewController alloc] init];
    vc.sellerIDNum=self.sellerIDNum;
    vc.HomeOrProtocol=self.HomeOrProtocol;
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration configurationWithDistance:0 maskAlpha:0.4 scaleY:0 direction:CWDrawerTransitionDirectionRight backImage:nil];
    
    [self cw_showDrawerViewController:vc animationType:CWDrawerAnimationTypeMask configuration:conf];
    
}

-(NSMutableArray *)dataArr{
    if (_dataArr==nil) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
    
}
#pragma mark ========== 得到店铺列表==========
-(void)getProductDataFromSeverWithUrl:(NSString *)URL andSellerID:(NSUInteger)sellerIDnum{
    
    NSNumber * nums =nil;
    if ([self.HomeOrProtocol isEqualToString:@"首页进入"]) {
        nums = @([@":" integerValue]);
    }else{
        
        nums=[self getToken];
        
        //        NSLog(@"协议供货");
    }
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setValue:@(sellerIDnum) forKey:@"sellerID"];
    [dict setValue:@1 forKey:@"page"];
    [dict setObject:@(statusNum) forKey:@"status"];
    [dict setValue:BrandIDNum forKey:@"brandID"];
    if (self.catIDNum==nil) {
        self.catIDNum=@0;
    }
    else{
    [dict setObject:self.catIDNum forKey:@"catID"];
    }
    
    [HTTPRequest POST:URL getToken:nums paramentDict:dict success:^(id responseObj) {
       
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
//                NSLog(@"----%@",dict);
        [self.dataArr removeAllObjects];
        NSArray *goodsArr=dict[@"content"][@"list"];
        for (NSDictionary *obj in goodsArr) {
            ProductListModel *model=[[ProductListModel alloc] initWithDict:obj];
            [self.dataArr addObject:model];
        }
//        [self addCollectionView];
        [_allProductCollection reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
    
}


- (void)addCollectionView{
    _flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _allProductCollection = [[UICollectionView alloc]initWithFrame:CGRectMake( 0, CGRectGetMaxY(self.btn.frame), kScreenWidth , kScreenHeight-(Is_Iphone_X ? 88 : 64)-self.btn.frame.size.height) collectionViewLayout:_flowLayout];
    _allProductCollection.delegate = self;
    _allProductCollection.dataSource = self;
    _allProductCollection.backgroundColor  = [UIColor  colorWithHexString:@"#eeeeee"];
    _allProductCollection.showsVerticalScrollIndicator = NO;
    [self.allProductCollection removeFromSuperview];
    [self.view addSubview:_allProductCollection];
    [self collectionViewMode:_mode];
}

-(void)collectionViewMode:(CollectionMode)mode{
    if(mode == CollectionModeNormal){
        
        _flowLayout.itemSize = CGSizeMake((kScreenWidth-30)/2,227);
        //        _flowLayout.minimumLineSpacing=10;
        //        _flowLayout.minimumInteritemSpacing=10;
        [_flowLayout setSectionInset:UIEdgeInsetsMake(10, 20, 10, 15)];
        [_allProductCollection registerClass:[NormalCell class] forCellWithReuseIdentifier:@"NormalCell"];
    }
    else{
        _flowLayout.itemSize = CGSizeMake(kScreenWidth,130);
        [_flowLayout setSectionInset:UIEdgeInsetsMake(10, 0, 0, 0)];
        [_allProductCollection registerClass:[LongCell class] forCellWithReuseIdentifier:@"LongCell"];
    }
    [_allProductCollection reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    //    NSLog(@"-----%ld",self.dataArr.count);
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<self.dataArr.count) {
        ProductListModel *model=self.dataArr[indexPath.row];
        NormalCell * cell;
        
        if(_mode == CollectionModeNormal){
            cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"NormalCell" forIndexPath:indexPath];
            [cell bindDataWithModel:model];
        }
        else{
            cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"LongCell" forIndexPath:indexPath];
            [cell bindDataWithModel:model];
        }
        return cell;
    }
    return nil;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(_mode == CollectionModeNormal){
        _flowLayout.itemSize = CGSizeMake((kScreenWidth-20-30)/2,(kScreenWidth-20-30)/2+50);
        
    }
    else{
        
        _flowLayout.itemSize = CGSizeMake(kScreenWidth-20,(kScreenWidth-20-30)/2+10);
        
    }
    return _flowLayout.itemSize;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row<self.dataArr.count) {
        GoodsDetailViewController *goodsDetailVC=[[GoodsDetailViewController alloc] init];
        ProductListModel *model=self.dataArr[indexPath.row];

        goodsDetailVC.productIDNum=model.productID;
        goodsDetailVC.HomeOrProtocol=self.HomeOrProtocol;
        [self.navigationController pushViewController:goodsDetailVC animated:NO];
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
