//
//  GoodsBaseInfoTableViewCell.m
//  FireEquipment
//
//  Created by mc on 2017/11/24.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "GoodsBaseInfoTableViewCell.h"

@implementation GoodsBaseInfoTableViewCell




-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier ];
    if (self) {
        
        [self setUpAllView];
    }
    
    return self;
}

-(void)setUpAllView{
    
    self.titleNameLabel=[[UILabel alloc] init];
    [self.titleNameLabel setFont:[UIFont systemFontOfSize:17]];
    [self.titleNameLabel setTextColor:[UIColor colorWithHexString:@"#282828"]];
    [self.titleNameLabel setText:@"水电费二无热无若翁热无玩儿翁若无热无热无热无热无热无热无热无若"];
    [self.titleNameLabel setNumberOfLines:0];
    [self.contentView addSubview:self.titleNameLabel];
    [self.titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.equalTo(@45);
    }];

    
    self.priceLabel =[[UILabel alloc] init];
    [self.priceLabel setFont:[UIFont systemFontOfSize:15]];
    [self.priceLabel setTextColor:[UIColor colorWithHexString:@"#b6463b"]];
        [self.priceLabel setText:@"¥200"];
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@10);
        make.height.equalTo(@15);
        make.width.equalTo(@100);
        make.bottom.equalTo(@(-20));
    }];
   
    //先隐藏对比功能 等后期实现
//    self.ComparedBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [self.ComparedBtn setImage:[UIImage imageNamed:@"duibi.png"] forState:UIControlStateNormal];
//    [self.ComparedBtn addTarget:self action:@selector(ComparedBtnDidPress:) forControlEvents:UIControlEventTouchUpInside];
////    [self.contentView addSubview:self.ComparedBtn];
//    [self.ComparedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(@(-10));
//        make.bottom.equalTo(@(-10));
//        make.size.mas_equalTo(CGSizeMake(100, 40));
//    }];
    
}

//-(void)ComparedBtnDidPress:(UIButton *)sender{
//    
//    
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
