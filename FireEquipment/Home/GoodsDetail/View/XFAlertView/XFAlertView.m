//
//  XFAlertView.m
//  SCPay
//
//  Created by weihongfang on 2017/6/28.
//  Copyright © 2017年 weihongfang. All rights reserved.
//

#import "XFAlertView.h"
#import "UILabel+XFLabel.h"


@interface XFAlertView()<UIGestureRecognizerDelegate>

@property (nonatomic, retain)NSString       *danwei;
@property (nonatomic, retain)NSString       *dizhi;
@property (nonatomic, retain)NSString       *shouji;
@property (nonatomic, retain)NSString       *lianxiren;
@property (nonatomic, retain)NSString       *images;
@property (nonatomic, retain)NSString       *okBtnTitle;
@property (nonatomic, retain)UIImage        *img;
@property (nonatomic,assign) CGFloat        alertHeight;
@property (nonatomic, strong)UILabel        *lblTitle;
@property (nonatomic, strong)UILabel        *lblMsg;
@property (nonatomic, strong)UIButton       *btnCancel;
@property (nonatomic, strong)UIButton       *btnOK;
@property (nonatomic, strong)UIImageView    *imgView;

@property (strong, nonatomic) UIView        *backgroundView;

@end

@implementation XFAlertView

- (instancetype)initWithArr:(NSArray *)Arr CancelBtnimage:(NSString *)images
{
    if ([super init])
    {
        _images = images;
      
        CGFloat alertViewWidth = 303;
        self.backgroundColor = [UIColor whiteColor];
        
        
        for (int i=0; i<Arr.count; i++) {
           
            _danweiLabel = [[UILabel alloc]init];
            _danweiLabel.textColor = [UIColor colorWithHexString:@"#333333"];
            _danweiLabel.textAlignment = NSTextAlignmentLeft;
            _danweiLabel.font = [UIFont systemFontOfSize:14];
            _danweiLabel.text =Arr[i];
            _danweiLabel.numberOfLines = 0;
            
            _danweiLabel.frame=CGRectMake(15,([UILabel getHeightByWidth:alertViewWidth title:Arr[i] font:_danweiLabel.font])*i+10, alertViewWidth, [UILabel getHeightByWidth:alertViewWidth title:Arr[i] font:_danweiLabel.font]);
            if (i==0) {
            _danweiLabel.frame=CGRectMake(15,10,alertViewWidth-40,[UILabel getHeightByWidth:alertViewWidth-40 title:Arr[i] font:_danweiLabel.font]);
            }
            if (i==Arr.count-1) {
                _alertHeight=CGRectGetMaxY(_danweiLabel.frame)+20;
            }
            [self addSubview:_danweiLabel];
            
        }
        
        
        _btnCancel = [[UIButton alloc]init];
//        _btnCancel.backgroundColor = CANCELCOLOR;
        [_btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnCancel setImage:[UIImage imageNamed:_images]  forState:UIControlStateNormal];
        [_btnCancel addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnCancel];
        
        
        [self.backgroundView addSubview:self];
    }
    return self;
}

- (UIView *)backgroundView
{
    if (_backgroundView == nil)
    {
        _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        
        [_backgroundView addGestureRecognizer:singleTap];
        _backgroundView.layer.masksToBounds = YES;
    }
    
    return _backgroundView;
}

- (void)layoutSubviews
{
   

    
    CGFloat alertViewWidth=303;
   CGRect  cancelRect = CGRectMake(alertViewWidth-30,0,30,30);

    _btnCancel.frame = cancelRect;

    
    
    self.frame = CGRectMake((_backgroundView.frame.size.width - alertViewWidth) / 2,
                            (_backgroundView.frame.size.height - _alertHeight) / 2,
                            alertViewWidth,
                            _alertHeight);
   
    
   
    
    self.layer.cornerRadius = 5;
    
}

- (void)clickBtn:(UIButton *)sender
{
//    NSLog(@"XFAlertView: click %@", [sender titleForState:UIControlStateNormal]);
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(alertView:didClickTitle:)])
    {
        [self.delegate alertView:self didClickTitle:[sender titleForState:UIControlStateNormal]];
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        
    } completion:^(BOOL finished) {
        
        [self.backgroundView removeFromSuperview];
    }];
}

#pragma mark - public method

- (void)show
{
    [[UIApplication sharedApplication].delegate.window addSubview:self.backgroundView];
    
    [UIView animateWithDuration:0.1 animations:^{
        
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        
    } completion:nil];
}



-(void)handleSingleTap:(UITapGestureRecognizer *)sender

{
    
     [self.backgroundView removeFromSuperview];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer

{
    
    return YES;
    
}

@end
