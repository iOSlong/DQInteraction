//
//  DQHorizontalSelectionListView.m
//  Le123PhoneClient
//
//  Created by 刘洋 on 2016/10/28.
//  Copyright © 2016年 Ying Shi Da Quan. All rights reserved.
//

#import "DQHorizontalSelectionListView.h"
#import <Masonry/Masonry.h>

//static const CGFloat  kDQHorizontalSelectionListViewBottomLineHeight = 1.0f;
static const CGSize    kDQHorizontalSelectionListViewBottomTrimSize = {0, 3};
static const CGFloat   kDefaultPadding          = 15.f;
static const CGFloat   kDefaultSpacing          = 30;
static const NSInteger kSubContainerViewTagBase = 1000;

@interface DQHorizontalSelectionListView ()
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) UIView       *contentView;
@property (nonatomic, strong) UIView       *bottomTrimView;
@property (nonatomic, strong) UIView       *bottomLineView;


@property (nonatomic, strong) NSMutableDictionary *viwesMapOfIndex;

@property (nonatomic, copy) NSArray               *titles;

@end

@implementation DQHorizontalSelectionListView

/*
 * // Only override drawRect: if you perform custom drawing.
 * // An empty implementation adversely affects performance during animation.
 * - (void)drawRect:(CGRect)rect {
 * // Drawing code
 * }
 */

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _padding       = kDefaultPadding;
        _spacing       = kDefaultSpacing;
        _selectedIndex = -1;

        _normalColor     = [UIColor blackColor];
        _selectedColor   = [UIColor redColor];
        _bottomTrimColor = [UIColor redColor];

        _fontOfNormalState   = [UIFont systemFontOfSize:16];
        _fontOfSelectedState = [UIFont boldSystemFontOfSize:16];

        _boottomTrimSize = kDQHorizontalSelectionListViewBottomTrimSize;


        _viwesMapOfIndex = [NSMutableDictionary dictionary];
        [self setupSubVeiws];
    }

    return self;
}

- (void)layoutSubviews {
    [self reloadData];
    [super layoutSubviews];
    [self updateTrimViewLocation];
}

#pragma mark - Public Methods
- (void)reloadData {
    if (_dataSource) {
        NSInteger       count = [_dataSource numberOfItemsInSelectionList:self];
        count = MAX(count, 0);
        NSMutableArray *titles = [NSMutableArray arrayWithCapacity:count];
        for (NSInteger i = 0; i < count; i++) {
            NSString *title = [_dataSource selectionList:self titleForItemWithIndex:i];
            title = title?:@"";
            [titles addObject:title];
        }
        self.titles = [titles copy];
    }
}

/**
 *    set the offset of the indicator(only for HTHorizontalSelectionIndicatorStyleBottomBar).
 *    （add by liuyang13 ）
 *    @param offset -1~1
 */
- (void)setSelectionIndicatorOffsetRatio:(CGFloat)offset {
    //根据offSet的整数部分确定当前选中的位置
    NSInteger selectedIndex = _selectedIndex + (NSInteger)offset;
    //offset取小数部分
    offset = offset - (NSInteger)offset;
    UIView   *selectedView = [self viewAtIndex:selectedIndex];
    NSInteger desIndex     = selectedIndex;
    if (offset > 0.000001) {
        desIndex += 1;
    } else if (offset < -0.0000001) {
        desIndex -= 1;
    }
    if (desIndex == selectedIndex || desIndex < 0 || desIndex >= (NSInteger)self.titles.count) {
        //这种情况不需要调整
        NSLog(@"这种情况不需要调整");
    } else {
        UIView *desView = [self viewAtIndex:desIndex];
        //调整颜色
        //        UILabel *selectedLabel = [UILabel cast:selectedView];
        //        UILabel *desLabel      = [UILabel cast:desView];
        UILabel *selectedLabel = (UILabel*)selectedView;
        UILabel *desLabel      = (UILabel*)desView;
        CGFloat  scale         = ABS(offset);
        CGFloat  r,g,b,r1,g1,b1;
        [_selectedColor getRed:&r green:&g blue:&b alpha:nil];
        [_normalColor getRed:&r1 green:&g1 blue:&b1 alpha:nil];
        CGFloat rd = r - r1, gd = g - g1, bd = b - b1;
        rd *= scale;
        gd *= scale;
        bd *= scale;
        //NSLogInfo(@"rd = %f offset = %f scale = %f",rd, offset, scale );

        UIColor *color = [UIColor colorWithRed:r - rd green:g - gd blue:b - bd alpha:1.f];
        selectedLabel.textColor = color;
        color                   = [UIColor colorWithRed:r1 + rd green:g1 + gd blue:b1 + bd alpha:1.f];
        desLabel.textColor      = color;

        //调整位置
        CGFloat curWidth = [self bottomTrimWidth];
        CGFloat distance = ABS(desView.center.x - selectedView.center.x);
        CGFloat left,right;
        if (desIndex > selectedIndex) { //向右移动
            //目标右端位置
            CGFloat desRight = desView.center.x + curWidth / 2;
            if (offset < 0.5f) {
                //左端要慢慢从移到正常态的右端
                left = selectedView.center.x - curWidth / 2.f + offset * 2 * curWidth;
                //右端慢慢移动到目标右端
                right = desRight - (1 - offset * 2) * distance;
            } else {
                //左端要慢慢从正常态的右端移到当前label的右端
                left = (selectedView.center.x + curWidth / 2.f) + ((offset - 0.5) * 2) * (distance - curWidth);
                //右端固定为目标右端位置
                right = desRight;
            }
        } else { //向左移动
            offset = ABS(offset);
            //目标左端位置
            CGFloat desLeft = desView.center.x - curWidth / 2;
            if (offset < 0.5f) {
                //右端慢慢移到正常态的左端
                right = (selectedView.center.x + curWidth / 2.f) - offset * 2 * curWidth;
                //左端慢慢移动到目标右端
                left = desLeft + (1 - offset * 2) * distance;
            } else {
                //右端慢慢从正常态的左端移到当前label的左端
                right = (selectedView.center.x - curWidth / 2.f) - (offset - 0.5) * 2 * (distance - curWidth);
                //左端固定为目标左端位置
                left = desLeft;
            }
        }
        CGFloat width = right - left;
        [self.bottomTrimView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(left));
            make.width.equalTo(@(width));
            make.height.equalTo(@(self->_boottomTrimSize.height));
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
    }
} /* setSelectionIndicatorOffsetRatio */

#pragma mark - Access Methods

- (UIView*)bottomTrimView {
    if (!_bottomTrimView) {
        _bottomTrimView                 = [[UIView alloc] init];
        _bottomTrimView.backgroundColor = _bottomTrimColor;
    }

    return _bottomTrimView;
}

- (void)setBottomTrimColor:(UIColor*)bottomTrimColor {
    _bottomTrimColor                    = bottomTrimColor;
    self.bottomTrimView.backgroundColor = bottomTrimColor;
}

- (CGFloat)bottomTrimWidth {
    return _boottomTrimSize.width? _boottomTrimSize.width:([self viewAtIndex:_selectedIndex].frame.size.width);
}

#pragma mark - Private Methods
- (void)setupSubVeiws {
    UIScrollView *scrollView = UIScrollView.new;
    self.contentScrollView                    = scrollView;
    scrollView.backgroundColor                = [UIColor clearColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];
    [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

    UIView*contentView = UIView.new;
    contentView.backgroundColor = [UIColor clearColor];
    [self.contentScrollView addSubview:contentView];
    self.contentView = contentView;
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentScrollView);
        make.height.equalTo(self.contentScrollView);
    }];
}

- (void)setTitles:(NSArray*)titles {
    _titles = [titles copy];
    [self refresh];
}

- (void)refresh {
    UIView*contentView = self.contentView;
    [contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    UIView *lastView;
    for (NSInteger i = 0; i < (NSInteger)self.titles.count; i++) {
        NSString *title = self.titles[i];
        NSInteger tag   = i + kSubContainerViewTagBase;
        //先获取已存在的子view 如果不存在再创建
        UILabel  *view = [contentView viewWithTag:tag];
        if (!view) {
            view = UILabel.new;
        }
        view.tag  = tag;
        view.text = title;
        [self updateView:view withSelectedState:i == _selectedIndex];
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapedHandler:)];
        [view addGestureRecognizer:recognizer];


        [contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lastView? lastView.mas_right:@(self->_padding)).offset(lastView? self->_spacing:self->_padding);
            make.top.equalTo(@0);
            make.height.equalTo(contentView.mas_height);
        }];
        lastView = view;
    }

    [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastView.mas_right).offset(self->_padding);
    }];

    [self.contentView addSubview:self.bottomTrimView];
    [self updateTrimViewLocation];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    //UILabel *oldView = [self viewAtIndex:_selectedIndex];
    UILabel *newView = [self viewAtIndex:selectedIndex];
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView*_Nonnull obj, NSUInteger idx, BOOL*_Nonnull stop) {
        NSInteger tag = obj.tag - kSubContainerViewTagBase;
        if (tag >= 0) {
            [self updateView:obj withSelectedState:(NSInteger)idx == selectedIndex];
        }
    }];

    if (_selectedIndex != selectedIndex) {
        _selectedIndex = selectedIndex;
        CGRect  frame   = newView.frame;
        CGFloat anchorX = frame.origin.x + frame.size.width;
        CGFloat offsetX = anchorX - self.frame.size.width / 2;
        offsetX = MIN(offsetX, self.contentScrollView.contentSize.width - self.contentScrollView.frame.size.width);
        offsetX = MAX(offsetX, 0);

        [UIView animateWithDuration:0.3 animations:^{
            [self updateTrimViewLocation];
        }];

        [self.contentScrollView setContentOffset:CGPointMake(offsetX, self.contentScrollView.contentOffset.y) animated:YES];

        if ([_delegate respondsToSelector:@selector(selectionList:didSelectButtonWithIndex:)]) {
            [_delegate selectionList:self didSelectButtonWithIndex:_selectedIndex];
        }
    }
}

- (void)updateTrimViewLocation {
    UIView *viewSelected = [self viewAtIndex:_selectedIndex];
    CGFloat width        = _boottomTrimSize.width, height = _boottomTrimSize.height;
    if (width == 0) {
        width = RECT_WIDTH(viewSelected.bounds);
    }
    _bottomTrimView.frame = RECT(viewSelected.center.x - width / 2.f, viewSelected.frame.size.height - height, width, height);
    if (viewSelected) {
        [_bottomTrimView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(viewSelected);
            make.width.equalTo(self->_boottomTrimSize.width == 0? viewSelected:@(self->_boottomTrimSize.width));
            make.height.equalTo(@(self->_boottomTrimSize.height));
            make.bottom.equalTo(viewSelected.mas_bottom);
        }];
        [self.contentView setNeedsUpdateConstraints];
    }
}

- (UILabel*)viewAtIndex:(NSInteger)index {
    return [self.contentView viewWithTag:index + kSubContainerViewTagBase];
}

- (void)updateView:(UIView*)view withSelectedState:(BOOL)selected {
    UILabel *label = (UILabel*)view;
    if (selected) {
        label.textColor              = _selectedColor;
        label.font                   = _fontOfSelectedState;
        label.userInteractionEnabled = NO;
    } else {
        label.textColor              = _normalColor;
        label.font                   = _fontOfNormalState;
        label.userInteractionEnabled = YES;
    }
}

#pragma mark - Action Handler
- (void)viewTapedHandler:(UITapGestureRecognizer*)gestureRecognizer {
    UIView   *view  = gestureRecognizer.view;
    NSInteger index = view.tag - kSubContainerViewTagBase;
    if (index != self.selectedIndex) {
        self.selectedIndex = index;
    }
}

#pragma mark - KVO监听
- (void)setScrollView:(UIScrollView*)scrollView {
    [self removeObservers];
    _scrollView = scrollView;
    [self addObservers];
}

- (void)addObservers {
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
}

- (void)removeObservers {
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context {
    if ([self.scrollView isKindOfClass:[UICollectionView class]]) {
        if (self.scrollView.isDragging || self.scrollView.isDecelerating) {
            CGFloat offset = (self.scrollView.contentOffset.x - self.scrollView.frame.size.width * self.selectedIndex) / self.scrollView.frame.size.width;
            [self setSelectionIndicatorOffsetRatio:offset];
        }
        return;
    }
   #if 1
        CGFloat offPercent = self.scrollView.contentOffset.x + (self.selectedIndex * RECT_WIDTH(self.scrollView.bounds)) - RECT_WIDTH(self.scrollView.bounds);
        if (self.scrollView.isDragging || self.scrollView.isDecelerating) {
            CGFloat offset = (offPercent - RECT_WIDTH(self.scrollView.bounds) * self.selectedIndex) / RECT_WIDTH(self.scrollView.bounds);
            [self setSelectionIndicatorOffsetRatio:offset];
        }
   #else // if 0
        if (self.scrollView.isDragging || self.scrollView.isDecelerating) {
            CGFloat offset = (self.scrollView.contentOffset.x - self.scrollView.frame.size.width * self.selectedIndex) / self.scrollView.frame.size.width;
            [self setSelectionIndicatorOffsetRatio:offset];
        }
   #endif // if 0
}

- (void)dealloc {
    [self removeObservers];
}


@end
