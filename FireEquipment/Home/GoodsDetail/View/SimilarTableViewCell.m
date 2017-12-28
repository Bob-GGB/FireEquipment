//
//  SimilarTableViewCell.m
//  FireEquipment
//
//  Created by mc on 2017/11/27.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "SimilarTableViewCell.h"
#import "SimilarCollectionViewCell.h"
#import "SimModel.h"
@interface SimilarTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@end





@implementation SimilarTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier ];
    if (self) {

        [self addCollectionView];
    }

    return self;
}


- (void)addCollectionView{
    UILabel *label=[UILabel new];
   
    label.textColor=[UIColor colorWithHexString:@"#282828"];
    label.font=[UIFont systemFontOfSize:14];
    label.textAlignment=NSTextAlignmentLeft;
    label.text=@"相似推荐";
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/3, 20));
    }];
    
   UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake( 0,20, kScreenWidth , 160) collectionViewLayout:flowLayout];
     [_collectionView removeFromSuperview];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor  = [UIColor whiteColor];
    _collectionView.showsVerticalScrollIndicator = NO;
    flowLayout.itemSize = CGSizeMake((kScreenWidth-40)/3,160);
    [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [_collectionView registerClass:[SimilarCollectionViewCell class] forCellWithReuseIdentifier:@"NormalCell"];
    [self.contentView addSubview:_collectionView];

}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.HomeArray.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
       SimilarCollectionViewCell *collcell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NormalCell" forIndexPath:indexPath];
    
        SimModel *HModel = [self.HomeArray objectAtIndex:indexPath.row];
          [collcell SetCollCellData:HModel];
    
    
 
  
    
    
    return collcell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenWidth-40)/3, 160);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 5, 0,5);
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    //代理传值
     SimModel *HModel = [self.HomeArray objectAtIndex:indexPath.row];
    if([self.delegateColl respondsToSelector:@selector(ClickCooRow:)])
    {
        [self.delegateColl ClickCooRow:indexPath.row andProductNum:[HModel.productID integerValue]];
        [self.delegateColl ClickCooRow:indexPath.row];
    }
    
}

//接收数据
-(void)getHomeArray:(NSArray *)homeArray
{
    self.HomeArray = homeArray;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
