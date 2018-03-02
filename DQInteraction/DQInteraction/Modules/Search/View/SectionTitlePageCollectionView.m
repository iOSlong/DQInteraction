//
//  SectionTitlePageCollectionView.m
//  DQInteraction
//
//  Created by lxw on 2018/3/2.
//  Copyright © 2018年 lxw. All rights reserved.
//

#import "SectionTitlePageCollectionView.h"
#import "DQHorizontalSelectionListView.h"
#import "SearchSuggestAlbumPageCell.h"

@interface SectionTitlePageCollectionView()
<UICollectionViewDelegate,
UICollectionViewDataSource,
DQHorizontalSelectionListDataSource,
DQHorizontalSelectionListDelegate>

@property (nonatomic, strong) SASView *headerViewContainer;
@property (nonatomic, strong) DQHorizontalSelectionListView *headerView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *headers;

@end


@implementation SectionTitlePageCollectionView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
    }
    return self;
}
- (void)buildUI {
    self.layer.borderColor = [UIColor cyanColor].CGColor;
    self.layer.borderWidth = 0.5f;
        [self buidHeaderView];
    [self buildCollectionView];
    //    [self reloadData];
}

- (void)buidHeaderView {
    const CGFloat HeaderHeight        = 59.0f;
    SASView       *headerContainerView = [[SASView alloc] init];
    headerContainerView.backgroundColor = COLOR_HEXA(0xFFFFFFFF, 0.98);
    headerContainerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    headerContainerView.layer.borderWidth = 1;
    [self addSubview:headerContainerView];
    [headerContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(HeaderHeight));
    }];
    self.headerViewContainer = headerContainerView;
    
    //初始化
    CGRect headerViewFrame = RECT(0, 0, 100, 20);
    self.headerView = [[[DQHorizontalSelectionListView alloc] initWithFrame:headerViewFrame] sas_decorate:^(DQHorizontalSelectionListView*view) {
        view.selectedIndex = 0;
        view.dataSource = self;
        view.delegate = self;
        view.normalColor = COLOR_HEX(0x333333);
        UIColor *selectColor;
        selectColor = COLOR_HEX(0x3599F8);
        view.selectedColor = selectColor;
        view.fontOfNormalState = [UIFont systemFontOfSize:16];
        view.fontOfSelectedState = [UIFont boldSystemFontOfSize:16];
        view.bottomTrimColor = selectColor;
        view.boottomTrimSize = SIZE(14,3);
        view.bottomTrimView.layer.cornerRadius = 1.5f;
        [headerContainerView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerContainerView.mas_left);
            make.right.equalTo(headerContainerView.mas_right);
            make.bottom.equalTo(headerContainerView.mas_bottom);
            make.height.equalTo(@(33));
        }];
    }];
    
    
}

- (void)buildCollectionView {
    CGRect collectionFrame = CGRectMake(0, 59, self.frame.size.width, self.frame.size.height - 59);
    UICollectionViewFlowLayout *_layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.scrollDirection         = UICollectionViewScrollDirectionHorizontal;
    _layout.minimumLineSpacing      = 0;
    _layout.minimumInteritemSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:collectionFrame collectionViewLayout:_layout];
    [self addSubview:collectionView];
    collectionView.layer.borderWidth = 1;
    collectionView.layer.backgroundColor = [UIColor redColor].CGColor;
//    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    [collectionView registerClass:[SearchSuggestAlbumPageCell class] forCellWithReuseIdentifier:NSStringFromClass([SearchSuggestAlbumPageCell class])];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    self.collectionView = collectionView;
    self.headerView.scrollView = collectionView;
}


- (void)reloadData {
    [self.headerView reloadData];
}

- (void)reloadSection:(NSInteger)section {
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
    [self.collectionView reloadSections:indexSet];
}

#pragma mark - DQHorizontalSelectionListDataSource, DQHorizontalSelectionListDelegate
- (NSInteger)numberOfItemsInSelectionList:(DQHorizontalSelectionListView*)selectionList {
    if ([self.delegate respondsToSelector:@selector(sectionTitlesOfPageCollection:)]) {
        self.headers = [self.delegate sectionTitlesOfPageCollection:self];
    }
    return self.headers.count?:1;
}

- (NSString*)selectionList:(DQHorizontalSelectionListView*)selectionList titleForItemWithIndex:(NSInteger)index {
    return self.headers[index]?:@"推荐";
}

- (void)selectionList:(DQHorizontalSelectionListView*)selectionList didSelectButtonWithIndex:(NSInteger)index {
    //[self setReportCenterCurUrlWithIndex:index];
    //    NSInteger originIndex = [self.controllers indexOfObject:self.pageController.viewControllers[0]];
    //    [self.pageController setViewControllers:@[self.controllers[index]] direction:index > originIndex? UIPageViewControllerNavigationDirectionForward:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.headers.count?:1;
}
- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath {
    SearchSuggestAlbumPageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SearchSuggestAlbumPageCell class]) forIndexPath:indexPath];
    NSArray              *pageEpisodes = [self.delegate pageCollection:self dataSouceInSection:indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath {
    return CGSizeMake(RECT_WIDTH(self.bounds), RECT_HEIGHT(collectionView.bounds));
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView {
    NSInteger page = scrollView.contentOffset.x / RECT_WIDTH(self.collectionView.bounds);
    [self moveToPage:page];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView*)scrollView {
    NSInteger page = scrollView.contentOffset.x / RECT_WIDTH(self.collectionView.bounds);
    [self moveToPage:page];
}

- (void)moveToPage:(NSUInteger)page {
    NSUInteger scrollTempPage = self.collectionView.contentOffset.x / RECT_WIDTH(self.collectionView.bounds);
    if ([self.headers count] <= scrollTempPage) {
        return;
    }
    self.headerView.selectedIndex = page;
}

@end








