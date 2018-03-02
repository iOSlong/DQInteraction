//
//  RecommendViewController.h
//  DQInteraction
//
//  Created by lxw on 2018/03/01.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecommendBusiness;

@interface RecommendViewController : DQViewController
@property (nonatomic,strong) RecommendBusiness*business;

@property (nonatomic, strong) UIView     *toolView;
@property (nonatomic, strong) UIButton   *searchButton;
@property (nonatomic, strong) UIButton   *moreButton;


@end
