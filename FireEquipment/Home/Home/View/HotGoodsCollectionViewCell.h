//
//  HotGoodsCollectionViewCell.h
//  FireEquipment
//
//  Created by mc on 2017/11/20.
//  Copyright © 2017年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotProductListModel.h"
@interface HotGoodsCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView *goodsImageView;
@property (nonatomic,strong) UILabel *goodsTitleLabel;
@property (nonatomic,strong) UILabel *comNameLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UIButton *enterButton;
@property (nonatomic , strong) void(^sendController)(UIViewController *controller);
@property (nonatomic,assign) NSInteger  sellerIDNUm;
@property (nonatomic, copy) NSString *sellerNameStr;
-(void)BindDataWithModel:(HotProductListModel *)model;
@end
