//
//  CalssificationGoodsViewController.m
//  FireEquipment
//
//  Created by mc on 2017/12/14.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "CalssificationGoodsViewController.h"
#import "NormalCell.h"
#import "LongCell.h"
#import "ProductListModel.h"
#import "UIViewController+CWLateralSlide.h"
#import <MJRefresh/MJRefresh.h>
#import "GoodsDetailViewController.h"
#import "SecendCatListModel.h"
#import "LXSegmentTitleView.h"
#import "LXScrollContentView.h"
#import "ClassGoodsViewController.h"
#import "BrandListViewController.h"
@interface CalssificationGoodsViewController ()<LXSegmentTitleViewDelegate,LXScrollContentViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MJRefreshEXDelegate>{
    
    NSInteger statusNum;//价格升降状态
    NSNumber *BrandIDNum;//选择的品牌ID
    NSNumber *selectIndexCatID;//选中商品分类的下标
}


typedef NS_ENUM(NSInteger,CollectionMode){
    CollectionModeNormal,
    CollectionModeLong
};

@property (nonatomic, strong) LXSegmentTitleView *titleView;

@property (nonatomic, strong) LXScrollContentView *contentView;
@property (nonatomic,strong) UIButton *btn;
@property (nonatomic,strong) NSMutableArray  *btnArr;
@property(nonatomic,strong) UICollectionViewFlowLayout * flowLayout;
@property(nonatomic,strong) UICollectionView * allProductCollection;
@property(nonatomic,assign) CollectionMode  mode;
@property (nonatomic,strong) NSMutableArray *dataArr;
//@property (nonatomic, strong) NSMutableArray *contentArray;
@property (nonatomic, strong) NSMutableArray *titleArray;//二级分类的名称
@property (nonatomic, strong) NSMutableArray *catIDArray;//二级分类的ID

@property (nonatomic,strong) NSNumber *defaultCatID;
//@property (nonatomic,strong) NSNumber *catIDNum;

@end

@implementation CalssificationGoodsViewController

-(void)viewWillAppear:(BOOL)animated{
    
//    NSLog(@"catIDnum%@",self.catIDNum);
    [super viewWillAppear:animated];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    BrandIDNum=[defaults valueForKey:@"KbrandID"];
    if ([defaults valueForKey:@"KbrandID"]!=NULL) {
        if ([self.HomeOrProtocol isEqualToString:@"首页进入"]) {
            [self postDataWithURL:@"http://equipmentapp.qianchengwl.cn/api/show/screeningPrice"];
        }else{
            
            [self postDataWithURL:@"http://equipmentapp.qianchengwl.cn/api/supply/screeningAgreement"];
            
        }
        
    }
    //下拉加载更多
    [self setUpRefreshAndLoadMore];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.titleStr;
    [self addLeftBarButtonWithImage:@"back.png"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"]}];
    [self setupUI];
   
    
    
    _mode = CollectionModeNormal;
    if ([self.HomeOrProtocol isEqualToString:@"首页进入"]) {
        [self PostDataFromSeverWithSever:@"http://equipmentapp.qianchengwl.cn/api/show/screeningProductByID" AndCatID:self.catIDNum];
    }
    else{
        
        [self PostDataFromSeverWithSever:@"http://equipmentapp.qianchengwl.cn/api/supply/screeningProductByID" AndCatID:self.catIDNum];
        //          [self postSelectCatNameSeverWithSever:@"http://equipmentapp.qianchengwl.cn/api/supply/screeningProductByID" AndCatID:self.catIDNum];
        
        NSLog(@"协议供货");
    }
   
    
    //下拉加载更多
    [self setUpRefreshAndLoadMore];
    
}
- (void)setupUI{
    
    self.titleView = [[LXSegmentTitleView alloc] init];
    self.titleView.frame = CGRectMake(0, 0, self.view.frame.size.width, 35);
    
   
    self.titleView.itemMinMargin = 15.f;
    self.titleView.delegate = self;
    self.titleView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    [self.view addSubview:self.titleView];
    self.contentView = [[LXScrollContentView alloc] init];
     self.contentView.frame = CGRectMake(0, CGRectGetMaxY(self.titleView.frame)+self.btn.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - 35);
    self.contentView.delegate = self;
    [self.view addSubview:self.contentView];
    selectIndexCatID=@0;
    statusNum=0;
     [self setUpBtnUI];
    
}
-(void)setUpBtnUI{
    
    
    self.btnArr=[NSMutableArray array];
    CGFloat h =self.titleView.frame.origin.y+self.titleView.frame.size.height;//用来控制button距离父视图的高
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
        self.btn.frame = CGRectMake(w*i, h, w , 40);
        
        if (i==4) {
            self.btn.frame = CGRectMake(w*i, h,100, 40);
        }
        [self.view addSubview:self.btn];
        [self.btnArr addObject:self.btn];
    }
    ((UIButton *)[self.btnArr objectAtIndex:0]).selected=YES;  // 关键是这里，设置 数组的第一个button为选中状态
    [self addCollectionView];
}

- (void)reloadData{
    
    self.titleView.segmentTitles =self.titleArray;
    NSMutableArray *vcs = [[NSMutableArray alloc] init];
    for (int i=0;i<self.titleArray.count;i++) {
        ClassGoodsViewController *vc = [[ClassGoodsViewController alloc] init];
        
        [vcs addObject:vc];
    }
    [self.contentView reloadViewWithChildVcs:vcs parentVC:self];
    
    if ([self.HomeOrProtocol isEqualToString:@"首页进入"]) {
        self.titleView.selectedIndex = 0;
        self.contentView.currentIndex = 0;
    }
    else{
        
        self.titleView.selectedIndex = self.indexPathRow;
        self.contentView.currentIndex = self.indexPathRow;
    }
    [self.contentView reloadInputViews];
    
}
-(NSNumber *)getToken{
    NSUserDefaults *defauts=[NSUserDefaults standardUserDefaults];
    NSDictionary *userDict= [defauts objectForKey:@"userInfoDic"];
    
    return  userDict[@"content"][@"token"];
    
}

#pragma -上拉加载更多
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
#pragma mark ========== 上拉加载更多==========
-(void)loadMoreDataWithPage:(NSInteger)page{
    
        NSNumber * nums = @([@":" integerValue]);
    if ([selectIndexCatID isEqualToNumber:@0]) {
        selectIndexCatID=self.catIDNum;
    }
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        [dict setValue:selectIndexCatID forKey:@"catID"];
    
        [dict setValue:@(page) forKey:@"page"];
        [dict setValue:BrandIDNum forKey:@"brandID"];
    
        NSString *urlString=nil;
    
        if ([self.HomeOrProtocol isEqualToString:@"首页进入"]) {
            urlString= @"http://equipmentapp.qianchengwl.cn/api/show/screeningProductByID";
        }else{
    
             urlString= @"http://equipmentapp.qianchengwl.cn/api/supply/screeningProductByID";
            NSLog(@"协议供货");
        }
    [HTTPRequest POST:urlString getToken:nums paramentDict:dict success:^(id responseObj) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
        NSArray *goodsArr=dict[@"content"][@"list"];
        for (NSDictionary *obj in goodsArr) {
            ProductListModel *model=[[ProductListModel alloc] initWithDict:obj];
            [self.dataArr addObject:model];
        }
       
        
          [self.allProductCollection endFooterRefreshWithChangePageIndex:YES];
        //停止刷新
        if (self.dataArr.count < 60){// 没有数据啦.不能上啦了
            [self.allProductCollection noMoreData];
        }
        else{
            // 5. 结束刷新
             [self.allProductCollection endHeaderRefreshWithChangePageIndex:NO];
            
        }
        
         [_allProductCollection reloadData];
        
    } failure:^(NSError *error) {
         [self.allProductCollection endHeaderRefreshWithChangePageIndex:NO];
    }];
    
}

//点击事件
- (void)handleClick:(UIButton *)btn{
   
    
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
        
        if ([self.HomeOrProtocol isEqualToString:@"首页进入"]) {
            [self postDataWithURL:@"http://equipmentapp.qianchengwl.cn/api/show/screeningPrice"];
        }else{
            
            [self postDataWithURL:@"http://equipmentapp.qianchengwl.cn/api/supply/screeningAgreement"];
            NSLog(@"协议供货");
        }
        
    }
    else if (btn.tag==103){
        
        statusNum=2;//降序排列
        if ([self.HomeOrProtocol isEqualToString:@"首页进入"]) {
            [self postDataWithURL:@"http://equipmentapp.qianchengwl.cn/api/show/screeningPrice"];
        }else{
            
            [self postDataWithURL:@"http://equipmentapp.qianchengwl.cn/api/supply/screeningAgreement"];
            NSLog(@"协议供货");
        }
    }
    else{
        [self drawerMaskAnimationRight];
    }
    
    
    
    [self collectionViewMode:_mode];
}


- (void)drawerMaskAnimationRight{
    
    BrandListViewController *vc = [[BrandListViewController alloc] init];
    
    
    if ([self.HomeOrProtocol isEqualToString:@"首页进入"]){
        if ([selectIndexCatID intValue]<14) {
            vc.CatID=self.defaultCatID;
        }
        else{
            //            selectIndexCatID=self.catIDNum;
            vc.CatID=selectIndexCatID;
        }
        
    }
    else{
        if ([selectIndexCatID isEqualToNumber:@0]) {
            selectIndexCatID=self.catIDNum;
            vc.CatID=selectIndexCatID;
        }else{
            vc.CatID=selectIndexCatID;
        }
        
    }
    
    
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
-(NSMutableArray *)titleArray{
    if (_titleArray==nil) {
        _titleArray=[NSMutableArray array];
    }
    return _titleArray;
    
}
-(NSMutableArray *)catIDArray{
    if (_catIDArray==nil) {
        _catIDArray=[NSMutableArray array];
    }
    return _catIDArray;
    
}
#pragma mark ========== 根据一级分类得到子分类及商品列表==========
-(void)PostDataFromSeverWithSever:(NSString *)URL AndCatID:(NSNumber *)catID{
    NSNumber * nums =nil;
    if ([self.HomeOrProtocol isEqualToString:@"首页进入"]) {
        nums = @([@":" integerValue]);
    }else{
        
        nums=[self getToken];
        
    }
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setValue:catID forKey:@"catID"];
    [dict setValue:@1 forKey:@"page"];
    [HTTPRequest POST:URL getToken:nums paramentDict:dict success:^(id responseObj) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
//                NSLog(@"%@",dict);
        NSArray *arr=dict[@"content"][@"catList"];
        [self.titleArray removeAllObjects];
        [self.catIDArray removeAllObjects];
        for (NSDictionary *obj in arr) {
            SecendCatListModel *model=[[SecendCatListModel alloc] initWithDict:obj];
            [self.titleArray addObject:model.catName];
            [self.catIDArray addObject:model.catID];
            
        }
        self.defaultCatID=self.catIDArray.firstObject;//进入当前页默认选择的二级分类CatID
        //        NSLog(@"self.defaultCatID:%@",self.defaultCatID);
        
        
        [self.dataArr removeAllObjects];
        NSArray *goodsArr=dict[@"content"][@"productList"];
        for (NSDictionary *obj in goodsArr) {
            ProductListModel *model=[[ProductListModel alloc] initWithDict:obj];
            [self.dataArr addObject:model];
        }
        
        [self reloadData];
        [_allProductCollection reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}
#pragma mark ========== 点击子分类得到商品列表==========
-(void)postSelectCatNameSeverWithSever:(NSString *)URL AndCatID:(NSNumber *)catID{
    NSNumber * nums =nil;
    if ([self.HomeOrProtocol isEqualToString:@"首页进入"]) {
        nums = @([@":" integerValue]);
    }else{
        
        nums=[self getToken];
        
        //        NSLog(@"协议供货");
    }
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setValue:catID forKey:@"catID"];
    [dict setValue:@1 forKey:@"page"];
    [HTTPRequest POST:URL getToken:nums paramentDict:dict success:^(id responseObj) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
        //        NSLog(@"-------%@",catID);
//                NSLog(@"----%@",dict);
        [self.dataArr removeAllObjects];
        NSArray *goodsArr=dict[@"content"][@"productList"];
        for (NSDictionary *obj in goodsArr) {
            ProductListModel *model=[[ProductListModel alloc] initWithDict:obj];
            [self.dataArr addObject:model];
        }
        //        [self addCollectionView];
        [_allProductCollection reloadData];
        [self setUpRefreshAndLoadMore];
    } failure:^(NSError *error) {
        
    }];
    
    
}

#pragma mark ========== 根据一级分类进行升序降序排列及筛选数据==========
-(void)postDataWithURL:(NSString *)Url {
    NSNumber * nums =nil;
    if ([self.HomeOrProtocol isEqualToString:@"首页进入"]) {
        nums = @([@":" integerValue]);
        if ([selectIndexCatID isEqualToNumber:@0]) {
            selectIndexCatID=self.defaultCatID;
        }
    }else{
        
        nums=[self getToken];
        
        if ([selectIndexCatID isEqualToNumber:@0]) {
            selectIndexCatID=self.catIDNum;
        }
        
    }
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    //    NSLog(@"selectIndexCatID:%@",selectIndexCatID);
    [dict setValue:selectIndexCatID forKey:@"catID"];
    [dict setValue:@1 forKey:@"page"];
    [dict setObject:@(statusNum) forKey:@"status"];
    [dict setValue:BrandIDNum forKey:@"brandID"];
    //    NSLog(@"BrandIDNum:%@,selectIndexCatID:%@",BrandIDNum,selectIndexCatID);
    
    [HTTPRequest POST:Url getToken:nums paramentDict:dict success:^(id responseObj) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
        //        NSLog(@"%@",dict);
        
        [self.dataArr removeAllObjects];
        NSArray *goodsArr=dict[@"content"][@"productList"];
        for (NSDictionary *obj in goodsArr) {
            ProductListModel *model=[[ProductListModel alloc] initWithDict:obj];
            [self.dataArr addObject:model];
        }
        [_allProductCollection reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)segmentTitleView:(LXSegmentTitleView *)segmentView selectedIndex:(NSInteger)selectedIndex lastSelectedIndex:(NSInteger)lastSelectedIndex{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"KbrandID"];
    BrandIDNum=nil;
    self.contentView.currentIndex = selectedIndex;
    //获取当前选中子分类的CatID
    selectIndexCatID= self.catIDArray[selectedIndex];
    
    if ([self.HomeOrProtocol isEqualToString:@"首页进入"]) {
        [self postSelectCatNameSeverWithSever:@"http://equipmentapp.qianchengwl.cn/api/show/screeningProductByID" AndCatID:self.catIDArray[selectedIndex]];
    }else{
        
        [self postSelectCatNameSeverWithSever:@"http://equipmentapp.qianchengwl.cn/api/supply/screeningProductByID" AndCatID:self.catIDArray[selectedIndex]];
        
    }
    
}

- (void)contentViewDidScroll:(LXScrollContentView *)contentView fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(float)progress{
    
}

- (void)contentViewDidEndDecelerating:(LXScrollContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    self.titleView.selectedIndex = endIndex;
}

- (void)addCollectionView{
    _flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _allProductCollection = [[UICollectionView alloc]initWithFrame:CGRectMake( 0, CGRectGetMaxY(self.btn.frame), kScreenWidth , kScreenHeight-(Is_Iphone_X ? 88 : 64)-self.btn.frame.size.height-self.titleView.frame.size.height) collectionViewLayout:_flowLayout];
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
