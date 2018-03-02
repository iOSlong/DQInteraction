//
//  SearchViewController.m
//  DQInteraction
//
//  Created by lxw on 2018/03/01.
//  Copyright © 2017年 lxw. All rights reserved.
//
#import "SearchViewController.h"
#import "SearchBusiness.h"
#import "SearchBarView.h"
#import "SectionTitlePageCollectionView.h"
#import "SearchSuggestViewController.h"

#pragma mark - Constant

@interface SearchViewController ()<SearchBarViewDelegate,SectionTitlePageCollectionViewDelegate>
@property (nonatomic, strong) UIButton                   *btnCancel;
@property (nonatomic, strong) SearchBarView              *barSearch;
@property (nonatomic, strong) SASView                    *searchNavBar;
//@property (nonatomic, strong) SASView                    *containerView;
@property (nonatomic, strong) SectionTitlePageCollectionView *searchRecommendView;//搜索推荐部分。
@property (nonatomic, strong) SearchSuggestViewController    *suggestViewController;
@end

@implementation SearchViewController

#pragma mark - Object Cycle
- (instancetype)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)dealloc {
}

#pragma mark - Override
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_HEX(0xF9F8F8);
//    self.view.backgroundColor = COLOR_HEX(0xFFFFFF);

    [self buildUI];
    
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.searchNavBar.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - suggestViewController
- (SearchSuggestViewController *)suggestViewController {
    if (!_suggestViewController) {
        _suggestViewController = [[SearchSuggestViewController alloc] init];
    }
    return _suggestViewController;
}


#pragma mark - Build UI
- (void)buildUI {
    [self buildSearchNavBar];
    [self buildContainerView];
}
- (void)buildSearchNavBar {
    self.searchNavBar = [[[SASView alloc] initWithFrame:self.navigationController.navigationBar.bounds] sas_decorate:^(UIView *navBar) {
        navBar.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:navBar];
        [navBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.left.right.equalTo(self.view);
            if ([UIDevice isIPhoneX]) {
                make.height.mas_equalTo(44+44);
            } else {
                make.height.mas_equalTo(44+20);
            }
        }];
    }];
    
    self.barSearch = [[[SearchBarView alloc] initWithFrame:CGRectZero] sas_decorate:^(SearchBarView *barView) {
        [self.searchNavBar addSubview:barView];
        barView.placeholder = @"请输入影片名，主演或者导演";
        [barView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.right.equalTo(self.searchNavBar.mas_right).offset(-62);
            make.height.equalTo(@32);
            make.bottom.equalTo(@-6);
        }];
        barView.delegate = self;
    }];
    
    UIButton *btn = [[UIButton buttonWithType:UIButtonTypeRoundedRect] sas_decorate:^(UIButton *cancelBtn) {
        [self.searchNavBar addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.barSearch.mas_right);
            make.right.equalTo(@0);
            make.height.equalTo(@32);
            make.bottom.equalTo(@-6);
        }];
        [cancelBtn addTarget:self action:@selector(cancelBtnAction:)forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [cancelBtn setTitleColor:COLOR_HEX(0x333333) forState:UIControlStateNormal];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitle:@"取消" forState:UIControlStateHighlighted];
        [cancelBtn setTitle:@"取消" forState:UIControlStateSelected];
        cancelBtn.selected = NO;
    }];
    self.btnCancel = btn;
}

- (void)buildContainerView {
    self.searchRecommendView = [[[SectionTitlePageCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 1106.0/2048.0,1352)] sas_decorate:^(__kindof UIView * _Nonnull $) {
        [self.view addSubview:$];
        [$ mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.searchNavBar.mas_bottom).offset(2);
            make.left.equalTo(self.view.mas_left);
            make.bottom.equalTo(self.view.mas_bottom);
            make.width.equalTo(@(self.view.frame.size.width * 1106.0/2048.0));
        }];
    }];
    self.searchRecommendView.delegate = self;
}

#pragma mark - Load Data

#pragma mark - 功能1
- (void)cancelBtnAction:(UIButton*)btn {
    [self.barSearch textfieldResignFirstResponder];
    if (self.navigationController.presentingViewController) {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - SearchBarViewDelegate
- (BOOL)searchBarShouldReturn:(SearchBarView*)searchBar {
    if (!isEmpty(searchBar.text)) {
        [self loadResultViewControllerWithKeyword:searchBar.text];
    }
    return YES;
}

- (BOOL)searchBarShouldClear:(SearchBarView*)searchBar {
    return YES;
}

- (void)searchBarDidBeginEditing:(SearchBarView*)searchBar {
//    [self removeEmptyView];
//    [self removeResultViewController];
    if (!isEmpty(searchBar.text)) {
        [self suggestKeyword:searchBar.text];
    }
}

- (void)searchBarChangedEditing:(SearchBarView*)searchBar {
    if (!isEmpty(searchBar.text)) {
        [self suggestKeyword:searchBar.text];
    } else {
        [self.suggestViewController.view removeFromSuperview];
    }
}



#pragma mark - SectionTitlePageCollectionViewDelegate
- (NSArray *)sectionTitlesOfPageCollection:(SectionTitlePageCollectionView *)pageCollectionView {
    return @[@"推荐",@"电视剧",@"电影",@"综艺",@"动漫",@"游戏"];
}

- (NSArray *)pageCollection:(SectionTitlePageCollectionView *)pageCollectionView dataSouceInSection:(NSInteger)section {
    return nil;
}


#pragma mark - loadData
- (void)loadData {
    [self.searchRecommendView reloadData];
}

- (void)suggestKeyword:(NSString*)keyWord {
    [self.view addSubview:self.suggestViewController.view];
    [self.suggestViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchRecommendView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
}


- (void)loadResultViewControllerWithKeyword:(NSString*)keyword {
    self.barSearch.text = keyword;
    [self.barSearch textfieldResignFirstResponder];
    
    /// 存入db库中
//    [SearchHistory dbSaveForKeyword:keyword];
    [self searchForKeyword:keyword];
}
- (void)searchForKeyword:(NSString*)keyword {
    
}

#pragma mark - 功能2
#pragma mark  Delegate & DataSource
#pragma mark Helper
@end
