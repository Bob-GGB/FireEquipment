//
//  SimilarCollectionViewCell.m
//  FireEquipment
//
//  Created by mc on 2017/11/27.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "SimilarCollectionViewCell.h"



@implementation SimilarCollectionViewCell

-(void)SetCollCellData:(SimModel *)HModel{
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:HModel.titleImage]];
    self.nameLabel.text=HModel.productName;
    self.priceLabel.text=[NSString stringWithFormat:@"¥%@",HModel.price];

    
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        [self creatAllUI];
    }
    return self;
}


-(void)creatAllUI{

    self.goodsImageView =[[UIImageView alloc] init];
        [self.goodsImageView setBackgroundColor:[UIColor redColor]];
    [self.contentView addSubview:self.goodsImageView];
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@5);
        make.left.equalTo(@5);
        make.right.equalTo(@(-5));
        make.height.equalTo(@110);
    }];
    
    self.nameLabel=[[UILabel alloc] init];
    [self.nameLabel setFont:[UIFont systemFontOfSize:13]];
    [self.nameLabel setTextColor:[UIColor colorWithHexString:@"#282828"]];
//        [self.nameLabel setText:@"水电费二无热无若翁热无"];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsImageView.mas_bottom).offset(5);
        make.left.equalTo(@5);
        make.size.mas_equalTo(CGSizeMake(110, 15));
    }];
    
    
    
    self.priceLabel =[[UILabel alloc] init];
    [self.priceLabel setFont:[UIFont systemFontOfSize:12]];
    [self.priceLabel setTextColor:[UIColor colorWithHexString:@"#282828"]];
//        [self.priceLabel setText:@"¥200"];
    [self.priceLabel setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.left.equalTo(@5);
        make.size.mas_equalTo(CGSizeMake(110, 15));
    }];
    
}



@end
