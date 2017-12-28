//
//  CommentsTableViewCell.h
//  FireEquipment
//
//  Created by mc on 2017/11/27.
//  Copyright © 2017年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentsModel.h"
@interface CommentsTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *commentLabel;



-(void)bindDataWithModel:(CommentsModel *)model;
@end
