//
//  L_ServiceHeaderReusableView.h
//  Looktm
//
//  Created by mengqingzheng on 2017/5/12.
//  Copyright © 2017年 北京聚集科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderReusableView : UICollectionReusableView<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, retain) NSTimer * timer;

@property (nonatomic, retain) UIScrollView * scrollView;
@property (nonatomic, retain) UIPageControl * pageControl;
@property (nonatomic, retain) UILabel * currentPageLabel;

@property (nonatomic, retain) NSArray * dataSource;

@property(nonatomic,assign)BOOL scrollBool;


- (void) startTimer;
- (void) stopTimer;

@end
