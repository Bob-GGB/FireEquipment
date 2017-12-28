//
//  RecommendCollectionViewCell.h
//  FireEquipment
//
//  Created by mc on 2017/11/20.
//  Copyright © 2017年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectProductListModel.h"
@interface RecommendCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView *goodsImageView;
@property (nonatomic,strong) UILabel *goodsTitleLabel;
@property (nonatomic,strong) UILabel *priceLabel;

-(void)sendDataWithModel:(SelectProductListModel *)model;
@end
