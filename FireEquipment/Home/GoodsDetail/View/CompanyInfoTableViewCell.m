//
//  CompanyInfoTableViewCell.m
//  FireEquipment
//
//  Created by mc on 2017/11/24.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "CompanyInfoTableViewCell.h"
#import "ShopViewController.h"


@implementation CompanyInfoTableViewCell

-(void)bindDataWithModel:(CompanyInfoModel *)model{
    
    self.nameLabel.text=model.sellerName;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    self.goodsCoutLabel.text=[NSString stringWithFormat:@"商品描述:%.0f",model.similarity];
    self.xiaoliangCoutLabel.text=[NSString stringWithFormat:@"发货速度:%.0f",model.shipping];
    self.taiduLabel.text=[NSString stringWithFormat:@"服务态度:%.0f",model.attitude];
    self.wuliuLabel.text=[NSString stringWithFormat:@"物流速度:%.0f",model.logistics];
    self.haopingLabel.text=[NSString stringWithFormat:@"好评率:%.0f%@",model.rate,@"%"];
    self.sellerIDNum=model.sellerID;
    self.sellerNameStr=model.sellerName;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier ];
    if (self) {
        
        [self setUpAllView];
    }
    
    return self;
}

-(void)setUpAllView{
    self.headImageView=[UIImageView new];
//    self.headImageView.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@5);
        make.left.equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(66, 26));
    }];
    self.nameLabel=[UILabel new];
    self.nameLabel.textColor=[UIColor colorWithHexString:@"#282828"];
    self.nameLabel.font=[UIFont systemFontOfSize:15];
//    self.nameLabel.text=@"某某公司";
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView.mas_top);
        make.left.equalTo(self.headImageView.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-self.headImageView.frame.size.width-10, 26));
    }];

    self.goodsCoutLabel=[UILabel new];
    self.goodsCoutLabel.textColor=[UIColor colorWithHexString:@"#737373"];
    self.goodsCoutLabel.font=[UIFont systemFontOfSize:12];
    self.goodsCoutLabel.textAlignment=NSTextAlignmentCenter;
//    self.goodsCoutLabel.text=@"24";
    [self.contentView addSubview:self.goodsCoutLabel];
    [self.goodsCoutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView.mas_bottom).offset(10);
        make.left.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/3, 20));
    }];
    self.xiaoliangCoutLabel=[UILabel new];
    self.xiaoliangCoutLabel.textColor=[UIColor colorWithHexString:@"#737373"];
    self.xiaoliangCoutLabel.font=[UIFont systemFontOfSize:12];
    self.xiaoliangCoutLabel.textAlignment=NSTextAlignmentCenter;
//    self.xiaoliangCoutLabel.text=@"24";
    [self.contentView addSubview:self.xiaoliangCoutLabel];
    [self.xiaoliangCoutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView.mas_bottom).offset(10);
        make.left.equalTo(self.goodsCoutLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/3, 20));
    }];
    

    self.taiduLabel=[UILabel new];
    self.taiduLabel.textColor=[UIColor colorWithHexString:@"#737373"];
    self.taiduLabel.font=[UIFont systemFontOfSize:12];
    self.taiduLabel.textAlignment=NSTextAlignmentCenter;
//    self.taiduLabel.text=@"24";
    [self.contentView addSubview:self.taiduLabel];
    [self.taiduLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsCoutLabel.mas_bottom);
        make.left.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/3, 20));
    }];
    
    self.wuliuLabel=[UILabel new];
    self.wuliuLabel.textColor=[UIColor colorWithHexString:@"#737373"];
    self.wuliuLabel.font=[UIFont systemFontOfSize:12];
    self.wuliuLabel.textAlignment=NSTextAlignmentCenter;
//    self.wuliuLabel.text=@"24";
    [self.contentView addSubview:self.wuliuLabel];
    [self.wuliuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsCoutLabel.mas_bottom);
        make.left.equalTo(self.taiduLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/3, 20));
    }];
    
    self.haopingLabel=[UILabel new];
    self.haopingLabel.textColor=[UIColor colorWithHexString:@"#737373"];
    self.haopingLabel.font=[UIFont systemFontOfSize:12];
    self.haopingLabel.textAlignment=NSTextAlignmentCenter;
//    self.haopingLabel.text=@"24";
    
    [self.contentView addSubview:self.haopingLabel];
    [self.haopingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsCoutLabel.mas_bottom);
        make.left.equalTo(self.wuliuLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/3, 20));
    }];
   
    
    NSArray *arrss=@[@"danweixingxi",@"jinrudianpu1.png"];
    
    for (int i=0;i<arrss.count;i++){
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:arrss[i]] forState:UIControlStateNormal];
        btn.tag=100+i;
        [btn addTarget:self action:@selector(selectBtnDidPress:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.goodsCoutLabel.mas_bottom).offset(40);
            if (i==0) {
                make.left.equalTo(@10);
            }
            else{
                make.left.equalTo(@((kScreenWidth-40)/2+30));
            }
            make.size.mas_equalTo(CGSizeMake((kScreenWidth-40)/2, 30));
        }];
    }
    
    
}
-(void)selectBtnDidPress:(UIButton *)sender{
    
    if (sender.tag==100) {
        
        if (self.sendController) {
            self.sendController();
        }
        
    }
    else{
        ShopViewController *shopVC=[[ShopViewController alloc] init];
        shopVC.sellerIDNum=self.sellerIDNum;
        shopVC.sellerNameStr=self.sellerNameStr;
        if (self.sendControllerView) {
            self.sendControllerView(shopVC);
        }
    }
    
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
