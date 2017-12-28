//
//  CompanyInfoTableViewCell.h
//  FireEquipment
//
//  Created by mc on 2017/11/24.
//  Copyright © 2017年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyInfoModel.h"
#import "SellerInfoModel.h"
@interface CompanyInfoTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *goodsCoutLabel;
@property (nonatomic,strong) UILabel *xiaoliangCoutLabel;
@property (nonatomic,strong) UILabel *shoucangCoutLabel;
@property (nonatomic,strong) UILabel *taiduLabel;
@property (nonatomic,strong) UILabel *wuliuLabel;
@property (nonatomic,strong) UILabel *haopingLabel;
@property (nonatomic,assign) NSInteger sellerIDNum;
@property (nonatomic,copy) NSString *sellerNameStr;

@property (nonatomic , strong) void(^sendController)(void);
@property (nonatomic , strong) void(^sendControllerView)(UIViewController *Controller);

-(void)bindDataWithModel:(CompanyInfoModel *)model;
@end
