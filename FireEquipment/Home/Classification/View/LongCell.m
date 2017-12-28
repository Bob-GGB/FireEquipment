//
//  LongCell.m
//  TopMenu
//
//  Created by home on 2017/9/29.
//  Copyright © 2017年 home. All rights reserved.
//

#import "LongCell.h"
#import "Masonry.h"
#define kWidth  [UIScreen mainScreen].bounds.size.width
@interface LongCell()

@end
@implementation LongCell

-(void)bindDataWithModel:(ProductListModel *)model{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.titleImage]];
    self.name.text=model.name;
    self.comName.text=model.sellerName;
    self.price.text=model.price;
//    self.countLabel.text=model.
    
}


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor=[UIColor whiteColor];
        [self makeUI];
    }
    return self;
}
-(void)makeUI{
    self.imageView = ({
        UIImageView * imageView = [UIImageView new];
       imageView.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(150);
            make.top.left.equalTo(self).offset(10);
        }];
        imageView;
    });
    
    self.name = ({
        UILabel * name = [UILabel new];
        name.text = @"iPhoneX";
        name.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:name];
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_imageView.mas_right).offset(10);
            make.right.equalTo(@-5);
            make.top.equalTo(_imageView.mas_top).offset(10);
        }];
        name;
    });
    
    self.comName=({
        UILabel * comName = [UILabel new];
        comName.text = @"额外热无热无若";
        comName.textColor = [UIColor colorWithHexString:@"#757575"];
        comName.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:comName];
        [comName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_name.mas_bottom).offset(10);
            make.left.equalTo(_imageView.mas_right).offset(10);
        }];
        comName;
    });
    
    self.price = ({
        UILabel * price = [UILabel new];
        price.text = @"¥9999";
        price.textColor = [UIColor redColor];
        price.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:price];
        [price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_comName.mas_bottom).offset(40);
            make.left.equalTo(_imageView.mas_right).offset(10);
        }];
        price;
    });
    self.countLabel = ({
        UILabel * countLabelce = [UILabel new];
        countLabelce.text = @"月销量：9999";
        countLabelce.textColor = [UIColor colorWithHexString:@"#757575"];
        countLabelce.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:countLabelce];
        [countLabelce mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_price.mas_top);
            make.left.equalTo(_price.mas_right).offset(30);
        }];
        countLabelce;
    });
    
    
}
-(void)reloadDatewith:(NSDictionary*)dict{
   
}
@end
