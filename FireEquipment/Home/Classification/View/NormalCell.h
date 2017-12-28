//
//  SearchCell.h
//  TopMenu
//
//  Created by home on 2017/9/29.
//  Copyright © 2017年 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductListModel.h"
@interface NormalCell : UICollectionViewCell

-(void)bindDataWithModel:(ProductListModel *)model;
@end
