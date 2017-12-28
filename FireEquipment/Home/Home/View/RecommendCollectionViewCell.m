//
//  RecommendCollectionViewCell.m
//  FireEquipment
//
//  Created by mc on 2017/11/20.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "RecommendCollectionViewCell.h"

@implementation RecommendCollectionViewCell


-(void)sendDataWithModel:(SelectProductListModel *)model{
    
    self.goodsTitleLabel.text=model.name;
    self.priceLabel.text=[NSString stringWithFormat:@"¥%@",model.price];
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.titleImage]];

    
}

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}


-(void)setUpUI{
    
    UIView *backGroundView=[[UIView alloc] initWithFrame:CGRectMake(10, 0, 173, 217)];
    [backGroundView setBackgroundColor:[UIColor whiteColor]];
    backGroundView.layer.borderWidth = 1;
    backGroundView.layer.borderColor = [[UIColor colorWithHexString:@"dcdcdc"] CGColor];
    [backGroundView.layer setMasksToBounds:YES];
    [backGroundView.layer setCornerRadius:5];
    [self addSubview:backGroundView];
    
    
    self.goodsImageView =[[UIImageView alloc] init];
//    [self.goodsImageView setBackgroundColor:[UIColor redColor]];
    [backGroundView addSubview:self.goodsImageView];
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@5);
        make.size.mas_equalTo(CGSizeMake(160, 160));
    }];
    
    self.goodsTitleLabel=[[UILabel alloc] init];
    [self.goodsTitleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.goodsTitleLabel setTextColor:[UIColor colorWithHexString:@"#000000"]];
//    [self.goodsTitleLabel setText:@"水电费二无热无若翁热无"];
    [backGroundView addSubview:self.goodsTitleLabel];
    [self.goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsImageView.mas_bottom).offset(10);
        make.left.equalTo(self.goodsImageView.mas_left).offset(5);
        make.size.mas_equalTo(CGSizeMake(backGroundView.frame.size.width-10, 15));
    }];
   
    
    
    self.priceLabel =[[UILabel alloc] init];
    [self.priceLabel setFont:[UIFont systemFontOfSize:14]];
    [self.priceLabel setTextColor:[UIColor colorWithHexString:@"#b6463b"]];
//    [self.priceLabel setText:@"¥200"];
    [backGroundView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsTitleLabel.mas_bottom).offset(10);
       make.left.equalTo(self.goodsImageView.mas_left).offset(5);
       make.size.mas_equalTo(CGSizeMake(backGroundView.frame.size.width, 15));
    }];
    
    
}


@end
