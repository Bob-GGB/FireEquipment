//
//  GoodsDetailImagesTableViewCell.m
//  FireEquipment
//
//  Created by mc on 2017/11/27.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "GoodsDetailImagesTableViewCell.h"

@implementation GoodsDetailImagesTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier ];
    if (self) {
        
        [self setUpAllUI];
    }
    
    return self;
}

-(void)setUpAllUI{
    self.detailImageView =[UIImageView new];
    [self.contentView addSubview:self.detailImageView];
    
    [self.detailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(@0);
        
    }];
    
    
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
