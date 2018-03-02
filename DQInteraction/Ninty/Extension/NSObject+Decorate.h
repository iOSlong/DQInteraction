//
//  NSObject+Decorate.h
//  SARRS
//
//  Created by wangchao on 2017/6/25.
//  Copyright © 2017年 wangchao9. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^NTYDecorateBlock)(id);
@interface NSObject (NTYDecorate)
- (instancetype)sas_decorate:(NTYDecorateBlock)block;
@end

/// 以下代码仅为了让代码提示更友好
#ifdef DEBUG

    #define NTYDecorateExtension(class, parameter) \
        @interface class (NTYDecorate) \
        - (instancetype)sas_decorate:(void (^)(__kindof class*parameter))block; \
        @end \

    NTYDecorateExtension(UIView,                 $);
    NTYDecorateExtension(UIScrollView,           $);
    NTYDecorateExtension(UITableView,            $);
    NTYDecorateExtension(UICollectionView,       $);
    NTYDecorateExtension(UILabel,                $);
    NTYDecorateExtension(UIButton,               $);
    NTYDecorateExtension(UIImageView,            $);

    NTYDecorateExtension(UITableViewCell,        $);
    NTYDecorateExtension(UICollectionViewCell,   $);

    NTYDecorateExtension(UITapGestureRecognizer, $);
    //NTYDecorateExtension(UIView, view);
    //NTYDecorateExtension(UIView, view);
    //NTYDecorateExtension(UIView, view);
    NTYDecorateExtension(UIViewController, $);


#endif // ifdef DEBUG

NS_ASSUME_NONNULL_END
