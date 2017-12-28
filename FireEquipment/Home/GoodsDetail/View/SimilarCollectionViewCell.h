//
//  SimilarCollectionViewCell.h
//  FireEquipment
//
//  Created by mc on 2017/11/27.
//  Copyright © 2017年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimModel.h"
@interface SimilarCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView *goodsImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *priceLabel;
/**
 *  接收数据
 */
-(void)SetCollCellData :(SimModel *)HModel;
@end
