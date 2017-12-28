//
//  HotGoodsCollectionViewCell.m
//  FireEquipment
//
//  Created by mc on 2017/11/20.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "HotGoodsCollectionViewCell.h"
#import "ShopViewController.h"


@implementation HotGoodsCollectionViewCell


-(void)BindDataWithModel:(HotProductListModel *)model{
    
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    self.goodsTitleLabel.text=model.productName;
    self.comNameLabel.text=model.sellerName;
    self.priceLabel.text=[NSString stringWithFormat:@"¥%@",model.price];
    self.sellerIDNUm=model.sellerID;
    self.sellerNameStr=model.sellerName;
    
}
    
    
    


-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}


-(void)setUpUI{
    
    UIView *backGroundView=[[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 116)];
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
        make.left.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(115, 115));
    }];
    
    self.goodsTitleLabel=[[UILabel alloc] init];
    [self.goodsTitleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.goodsTitleLabel setTextColor:[UIColor colorWithHexString:@"#000000"]];
//    [self.goodsTitleLabel setText:@"水电费二无热无若翁热无"];
    [backGroundView addSubview:self.goodsTitleLabel];
    [self.goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.left.equalTo(self.goodsImageView.mas_right).offset(12);
        make.right.equalTo(@-10);
        make.height.equalTo(@15);
    }];
    self.comNameLabel =[[UILabel alloc] init];
    [self.comNameLabel setFont:[UIFont systemFontOfSize:12]];
    [self.comNameLabel setTextColor:[UIColor colorWithHexString:@"#6e6e6e"]];
//    [self.comNameLabel setText:@"玩儿翁热无"];
    [backGroundView addSubview:self.comNameLabel];
    [self.comNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsTitleLabel.mas_bottom).offset(15);
        make.left.equalTo(self.goodsImageView.mas_right).offset(12);
        make.right.equalTo(@-10);
        make.height.equalTo(@15);
    }];
    
    
    self.priceLabel =[[UILabel alloc] init];
    [self.priceLabel setFont:[UIFont systemFontOfSize:15]];
    [self.priceLabel setTextColor:[UIColor colorWithHexString:@"#b6463b"]];
//    [self.priceLabel setText:@"¥200"];
    [backGroundView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.comNameLabel.mas_bottom).offset(20);
        make.left.equalTo(self.goodsImageView.mas_right).offset(12);
        make.right.equalTo(@-10);
        make.height.equalTo(@15);
    }];
    
    self.enterButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.enterButton setImage:[UIImage imageNamed:@"jinrudianpu.png"] forState:UIControlStateNormal];
    [self.enterButton addTarget:self action:@selector(enterButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:self.enterButton];
    [self.enterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.comNameLabel.mas_bottom).offset(10);
        make.right.equalTo(@-20);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
}



-(void)enterButtonDidPress{
     ShopViewController *shopVC=[[ShopViewController alloc] init];
    shopVC.sellerIDNum=self.sellerIDNUm;
    shopVC.sellerNameStr=self.sellerNameStr;
    shopVC.HomeOrProtocol=@"首页进入";
//    NSLog(@"sellerIDNum:%ld",shopVC.sellerIDNum);
    if (self.sendController) {
        self.sendController(shopVC);
    }
    
}

@end
