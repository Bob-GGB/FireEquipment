//
//  GoodsDetailViewController.m
//  FireEquipment
//
//  Created by mc on 2017/11/24.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "LXSegmentTitleView.h"
#import "LXScrollContentView.h"
#import "GoodsDetailInfoViewController.h"
#import "CommentsViewController.h"
#import "DetailsViewController.h"
#import "CommentsModel.h"
@interface GoodsDetailViewController ()<LXSegmentTitleViewDelegate,LXScrollContentViewDelegate>
@property (nonatomic, strong) LXSegmentTitleView *titleView;
@property (nonatomic,strong) NSArray *titleCountArr;
@property (nonatomic, strong) LXScrollContentView *contentView;
@property (nonatomic,strong) CommentsViewController*comVC;
@property (nonatomic,strong) GoodsDetailInfoViewController *goodsvc ;

@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self postDataFromSeverWithURL:@"http://equipmentapp.qianchengwl.cn/api/show/getAllCom"];

    [self addLeftBarButtonWithImage:@"back.png"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#f2f2f2"];
    [self setupUI];
    [self reloadData];
//    [self setrightBarButtonItemWithImageName:@"xing.png-1" andTitle:nil];
//    [self addRightBarButtonItemWithTitle:@"back.png" action:@selector(shoucang:)];
//    [self addRightTwoBarButtonsWithFirstImage:[UIImage imageNamed:@"fenxiang.png"] firstAction:@selector(shoucang:) secondImage:[UIImage imageNamed:@"xing.png-1"] secondAction:@selector(fenxiang:)];
    [self addRightBarButtonWithFirstImage:[UIImage imageNamed:@"fenxiang.png"] action:@selector(fenxiang:)];
    
}
//-(void)shoucang:(UIButton *)sender{
//    NSLog(@"哈哈");
//    
//}
-(void)fenxiang:(UIButton *)sender{

}



- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.titleView.frame = CGRectMake(0, 0, 180,40);
    self.contentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)reloadData{
    NSArray *titles = @[@"商品",@"评价",@"详情"];
    self.titleView.segmentTitles = titles;
    NSMutableArray *vcs = [[NSMutableArray alloc] init];

    _goodsvc= [[GoodsDetailInfoViewController alloc] init];
    _comVC=[[CommentsViewController alloc] init];
    DetailsViewController *detailVC=[[DetailsViewController alloc] init];
   _goodsvc.productIDNum = self.productIDNum;
    _comVC.productIDnum=self.productIDNum;
    _goodsvc.HomeOrProtocol=self.HomeOrProtocol;//判断首页进入还是协议供货进入
  
//    detailVC.productIDnum=self.productIDNum;
    
    [vcs addObject:_goodsvc];
    [vcs addObject:_comVC];
    [vcs addObject:detailVC];
    [self.contentView reloadViewWithChildVcs:vcs parentVC:self];
    self.titleView.selectedIndex = 0;
    self.contentView.currentIndex = 0;
}
- (void)setupUI{
    self.titleView = [[LXSegmentTitleView alloc] initWithFrame:CGRectZero];
    self.titleView.itemMinMargin = 15.f;
    self.titleView.titleFont=[UIFont systemFontOfSize:16.0f];
    self.titleView.delegate = self;
    self.titleView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView =self.titleView;
    
    self.contentView = [[LXScrollContentView alloc] initWithFrame:CGRectZero];
    self.contentView.delegate = self;
    [self.view addSubview:self.contentView];
}

- (void)segmentTitleView:(LXSegmentTitleView *)segmentView selectedIndex:(NSInteger)selectedIndex lastSelectedIndex:(NSInteger)lastSelectedIndex{
    self.contentView.currentIndex = selectedIndex;
}

- (void)contentViewDidScroll:(LXScrollContentView *)contentView fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(float)progress{
    
}

- (void)contentViewDidEndDecelerating:(LXScrollContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    self.titleView.selectedIndex = endIndex;
}




-(void)postDataFromSeverWithURL:(NSString*)URL{
    
    NSNumber * nums = @([@":" integerValue]);
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setValue:self.productIDNum forKey:@"productID"];
    [HTTPRequest POST:URL getToken:nums paramentDict:dict success:^(id responseObj) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"%@",dict);
        
        NSMutableArray *AllArr=[NSMutableArray array];
        NSMutableArray *goodArr=[NSMutableArray array];
        NSMutableArray *midArr=[NSMutableArray array];
        NSMutableArray *badArr=[NSMutableArray array];
        
        [AllArr removeAllObjects];
        [goodArr removeAllObjects];
        [midArr removeAllObjects];
        [badArr removeAllObjects];
        NSArray *Garr=dict[@"content"][@"good"];
        NSArray *Marr=dict[@"content"][@"mid"];
        NSArray *Barr=dict[@"content"][@"bad"];
        for (NSDictionary *obj in Garr) {
            CommentsModel *model=[[CommentsModel alloc] initWithDict:obj];
            [goodArr addObject:model];
            [AllArr addObject:model];
            
        }
        for (NSDictionary *obj in Marr) {
            CommentsModel *model=[[CommentsModel alloc] initWithDict:obj];
            [midArr addObject:model];
            [AllArr addObject:model];
        }
        for (NSDictionary *obj in Barr) {
            CommentsModel *model=[[CommentsModel alloc] initWithDict:obj];
            [badArr addObject:model];
            [AllArr addObject:model];
        }
        
        self.titleCountArr=[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@\n%ld",@"全部评价",AllArr.count],[NSString stringWithFormat:@"%@\n%ld",@"好评",goodArr.count],[NSString stringWithFormat:@"%@\n%ld",@"中评",midArr.count],[NSString stringWithFormat:@"%@\n%ld",@"差评",badArr.count],nil];

        _comVC.titleCountArr=self.titleCountArr;
        _goodsvc.titleCountArr=self.titleCountArr;
        
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
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
