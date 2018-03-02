//
//  RecommendViewController.m
//  DQInteraction
//
//  Created by lxw on 2018/03/01.
//  Copyright © 2017年 lxw. All rights reserved.
//
#import "RecommendViewController.h"
#import "RecommendBusiness.h"
#import "DQHorizontalSelectionListView.h"
#import "RecommendPageViewController.h"
#import "SearchViewController.h"
#import "DQNavigationController.h"

#pragma mark - Constant

@interface RecommendViewController ()<DQHorizontalSelectionListDelegate,DQHorizontalSelectionListDataSource,UIPageViewControllerDelegate,
UIPageViewControllerDataSource,
UIScrollViewDelegate>

@property (nonatomic, strong) SASView                       *headerViewContainer;
@property (nonatomic, strong) DQHorizontalSelectionListView *headerView;

@property (nonatomic, strong) NSArray      *headers;
@property (nonatomic, strong) NSMutableArray                *controllers;
@property (nonatomic, strong) UIPageViewController      *pageController;
@end

@implementation RecommendViewController

#pragma mark - Object Cycle
- (instancetype)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

///  添加要追踪的属性

- (void)dealloc {
}

#pragma mark - Override
- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildUI];
    [self loadData];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
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
#pragma mark - Build UI
- (void)buildUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self buildHeader];
    [self buildToolbar];
    [self buildPageViewController];
}
- (void)buildHeader {
    const CGFloat HeaderHeight        = 64.0f;
    SASView       *headerContainerView = [[SASView alloc] init];
    headerContainerView.backgroundColor = COLOR_HEXA(0xFFFFFFFF, 0.98);
    headerContainerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    headerContainerView.layer.borderWidth = 1;
    [self.view addSubview:headerContainerView];
    [headerContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(HeaderHeight));
    }];
    self.headerViewContainer = headerContainerView;
    
    //初始化
    CGRect headerViewFrame = RECT(0, 0, 100, 20);
    self.headerView = [[DQHorizontalSelectionListView alloc] initWithFrame:headerViewFrame];
    self.headerView.selectedIndex = 0;
    self.headerView.dataSource = self;
    self.headerView.delegate = self;
    self.headerView.normalColor = COLOR_HEX(0x333333);
    UIColor *selectColor;
    selectColor = COLOR_HEX(0x3599F8);
    self.headerView.selectedColor = selectColor;
    
    self.headerView.fontOfNormalState =  [UIFont systemFontOfSize:16];
    self.headerView.fontOfSelectedState = [UIFont boldSystemFontOfSize:16];
    self.headerView.bottomTrimColor = selectColor;
    
    self.headerView.boottomTrimSize = SIZE(14,3);
    self.headerView.bottomTrimView.layer.cornerRadius = 1.5f;
    
    [headerContainerView addSubview:self.headerView];
    
    
    DQHorizontalSelectionListView *headerView = self.headerView;
    
    UIImageView                   *rightShadowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_tag_shadow"]];
    [headerContainerView addSubview:rightShadowImageView];
    
    [rightShadowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerView.mas_right);
        make.centerY.equalTo(headerView.mas_centerY);
    }];
    
    
    self.moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage  *image = [UIImage imageNamed:@"home_more"];
    [self.moreButton setImage:image forState:UIControlStateNormal];
    self.moreButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.moreButton addTarget:self action:@selector(showHeaders) forControlEvents:UIControlEventTouchUpInside];
    
    [headerContainerView addSubview:self.moreButton];
    
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerContainerView.mas_right);
        make.width.equalTo(@(44));
        make.top.equalTo(headerView.mas_top);
        make.bottom.equalTo(headerView.mas_bottom);
    }];
    
    const CGFloat HeaderViewHeight = 33;
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerContainerView.mas_left);
        make.right.equalTo(self.moreButton.mas_left);
        make.bottom.equalTo(headerContainerView.mas_bottom);
        make.height.equalTo(@(HeaderViewHeight));
    }];
}
- (void)buildToolbar {
    const CGFloat ToolViewHeight = 44.f;
    const CGFloat viewHeight     = RECT_HEIGHT(self.view.frame);
    self.toolView = [[UIView alloc] initWithFrame:RECT(0, 0, viewHeight, ToolViewHeight)];
    self.toolView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.toolView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.97f];
    [self.view addSubview:self.toolView];
    
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.headerViewContainer.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(ToolViewHeight));
    }];
    
    
    // [self updateSearchKeyWord:self.indexHeaderItem.search_query];
    self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchButton.backgroundColor = COLOR_HEX(0xF0F0F0);
    [self.searchButton setImage:[UIImage imageNamed:@"search_icon"] forState:UIControlStateNormal];
    [self.searchButton setTitleColor:COLOR_HEX(0x777777) forState:UIControlStateNormal];
    self.searchButton.titleLabel.font = [UIFont systemFontOfSize:12];
    self.searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    self.searchButton.layer.cornerRadius = 3;
    self.searchButton.layer.masksToBounds = YES;
    
    [self.searchButton setTitle:@"请输入影片名" forState:UIControlStateNormal];
    self.searchButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.searchButton addTarget:self forClickAction:@selector(showSearch)];
    [self.toolView addSubview:self.searchButton];
    
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.toolView).offset(8);
        make.top.equalTo(self.toolView).offset(8);
        make.bottom.equalTo(self.toolView).offset(-10);
    }];
    
    const CGSize size = CGSizeMake(40.0f, 40.0f);
    
    // download button
    UIButton *downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    downloadButton.backgroundColor = [UIColor yellowColor];
    [downloadButton setTitle:@"DOWN" forState:UIControlStateNormal];
    [downloadButton addTarget:self forClickAction:@selector(showDownload)];
    [self.toolView addSubview:downloadButton];
    [downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.toolView.mas_right).offset(-5);
        make.centerY.equalTo(self.toolView.mas_centerY);
        make.size.equalTo([NSValue valueWithCGSize:size]);
    }];
    
    // history button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor purpleColor];
    [downloadButton setTitle:@"HIST" forState:UIControlStateNormal];
    [button addTarget:self forClickAction:@selector(showHistory)];
    
    [self.toolView addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchButton.mas_right);
        make.right.equalTo(downloadButton.mas_left);
        make.centerY.equalTo(self.toolView.mas_centerY);
        make.size.equalTo([NSValue valueWithCGSize:size]);
    }];
}
- (void)buildPageViewController {
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    self.pageController.view.backgroundColor = [UIColor lightGrayColor];
    self.pageController.dataSource = self;
    self.pageController.delegate = self;
    
    for (UIView *view in self.pageController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scroll = (UIScrollView*)view;
            self.headerView.scrollView = scroll;
        }
    }
    [self.pageController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.toolView.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

- (void)reloadRecommendViewControllers {
    if (!self.controllers) {
        self.controllers = [NSMutableArray array];
    }
    [self.controllers removeAllObjects];
    NSInteger defaultIndex = 0;
    for (NSInteger i = 0; i < (NSInteger)self.headers.count; i++) {
        NSString *title = self.headers[i];
        RecommendPageViewController *viewController = [[RecommendPageViewController alloc] init];
        viewController.view.backgroundColor = COLOR_RGB(100, i * arc4random()%100, i * arc4random()%100);
        viewController.title                = title;
        [self.controllers addObject:viewController];
    }
    [self.headerView reloadData];
    [self.pageController setViewControllers:@[self.controllers[defaultIndex]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
}


#pragma mark - Load Data
- (void)loadData {
    self.headers = @[@"推荐",@"电视剧",@"电影",@"综艺",@"动漫",@"游戏"];
    [self reloadRecommendViewControllers];
}

#pragma mark - 功能1
- (void)showHeaders {
    NSLog(@"showHeaders");
}
- (void)showDownload {
    NSLog(@"showDownload");
}
- (void)showHistory {
    NSLog(@"showHistory");
}
- (void)showSearch {
    NSLog(@"showSearch");
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    DQNavigationController *searchNav = [[DQNavigationController alloc] initWithRootViewController:searchVC];
    [self.navigationController presentViewController:searchNav animated:YES completion:nil];
}

#pragma mark  Delegate & DataSource
#pragma mark - DQHorizontalSelectionListDataSource, DQHorizontalSelectionListDelegate
- (NSInteger)numberOfItemsInSelectionList:(DQHorizontalSelectionListView*)selectionList {
    return self.headers.count?:1;
}

- (NSString*)selectionList:(DQHorizontalSelectionListView*)selectionList titleForItemWithIndex:(NSInteger)index {
    return self.headers[index]?:@"推荐";
}

- (void)selectionList:(DQHorizontalSelectionListView*)selectionList didSelectButtonWithIndex:(NSInteger)index {
    //[self setReportCenterCurUrlWithIndex:index];
    NSInteger originIndex = [self.controllers indexOfObject:self.pageController.viewControllers[0]];
    [self.pageController setViewControllers:@[self.controllers[index]] direction:index > originIndex? UIPageViewControllerNavigationDirectionForward:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
}

#pragma mark - UIPageViewControllerDelegate,UIPageViewControllerDataSource
- (nullable UIViewController*)pageViewController:(UIPageViewController*)pageViewController viewControllerBeforeViewController:(UIViewController*)viewController {
    NSInteger index = [self.controllers indexOfObject:viewController];
    index--;
    if (index < 0 || index == NSNotFound) {
        return nil;
    }
    return self.controllers[index];
}

- (nullable UIViewController*)pageViewController:(UIPageViewController*)pageViewController viewControllerAfterViewController:(UIViewController*)viewController;{
    NSInteger index = [self.controllers indexOfObject:viewController];
    index++;
    if (index == (NSInteger)self.controllers.count) {
        return nil;
    }
    return self.controllers[index];
}

- (void)pageViewController:(UIPageViewController*)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController*>*)previousViewControllers transitionCompleted:(BOOL)completed {
    if (finished || completed) {
        NSInteger page = [self.controllers indexOfObject:[pageViewController.viewControllers firstObject]];
        self.headerView.selectedIndex = page;
    }
}

//- (void)setReportCenterCurUrlWithIndex:(NSInteger)recommendIndex {
//    id<HeaderViewModel> headerViewModel = self.headers[recommendIndex];
//    NSString           *cur_url         = [NSString stringWithFormat:@"home_%@",headerViewModel.page];
//    ReportCenter.curURL = cur_url;
//}
@end
