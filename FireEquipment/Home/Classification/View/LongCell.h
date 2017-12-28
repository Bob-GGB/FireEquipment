//
//  LongCell.h
//  TopMenu
//
//  Created by home on 2017/9/29.
//  Copyright © 2017年 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductListModel.h"
@interface LongCell : UICollectionViewCell
@property(nonatomic,strong) UIImageView * imageView;
@property(nonatomic,strong) UILabel * name;
@property(nonatomic,strong) UILabel * price;
@property(nonatomic,strong) UILabel * comName;
@property(nonatomic,strong) UILabel * countLabel;

-(void)bindDataWithModel:(ProductListModel *)model;
@end
