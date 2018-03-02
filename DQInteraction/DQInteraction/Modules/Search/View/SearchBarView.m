//
//  SearchBarView.m
//  SARRS
//
//  Created by xuewu.long on 17/7/7.
//  Copyright © 2017年 Beijing Ninety Culture Co.ltd. All rights reserved.
//

#import "SearchBarView.h"
#import "NTYKeyValueObserver.h"

@interface SearchBarView ()
@property (nonatomic, strong) NSMutableArray *notificationObservers;
@end

@implementation SearchBarView {
    NSString *_text;
}

+ (instancetype)searchBarView {
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"SearchBarView" owner:nil options:nil];
    return [array firstObject];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupItems];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder*)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupItems];
    }
    return self;
}

- (void)setupItems {
    self.layer.cornerRadius  = 2;
    self.layer.masksToBounds = YES;
    
    UITextField *textField = [[UITextField alloc] initWithFrame:self.bounds];
    [self addSubview:textField];
    textField.font = [UIFont systemFontOfSize:15];
    textField.returnKeyType = UIReturnKeySearch;
    textField.layer.cornerRadius = 2;
    textField.returnKeyType = UIReturnKeySearch;
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
    UIImage     *searchImage = [UIImage imageNamed:@"main_search_small"];
    UIImageView *leftImgView = [[UIImageView alloc] initWithImage:searchImage];
    leftImgView.frame       = RECT(0, 0, 30, 30);
    leftImgView.contentMode = UIViewContentModeCenter;
    
    
    UIImage  *clearImage = [UIImage imageNamed:@"search_edit_delete"];
    UIButton *rightBtn   = [[UIButton alloc] initWithFrame:RECT(0, 0, 30, 30)];
    [rightBtn setImage:clearImage forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(clearKeyWord)forControlEvents:UIControlEventTouchUpInside];
    
    self.textField = textField;
    self.imgvLeft  = leftImgView;
    self.btnClear  = rightBtn;
    
    self.textField.leftView      = leftImgView;
    self.textField.rightView     = rightBtn;
    self.textField.leftViewMode  = UITextFieldViewModeAlways;
    self.textField.rightViewMode = UITextFieldViewModeWhileEditing;
    self.textField.delegate      = self;
    self.textField.placeholder   = @"";
    
    [self addKeyboardNotification];
}

- (void)clearKeyWord {
    if ([self.delegate respondsToSelector:@selector(searchBarShouldClear:)]) {
        if ([self.delegate searchBarShouldClear:self]) {
            self.textField.text = nil;
            if ([self.delegate respondsToSelector:@selector(searchBarChangedEditing:)]) {
                [self.delegate searchBarChangedEditing:self];
            }
        }
    }
}

- (void)setPlaceholder:(NSString*)placeholder {
    _placeholder               = placeholder;
    self.textField.placeholder = placeholder;
}

- (void)setText:(NSString*)text {
    _text = text;
    if (![self.textField.text isEqualToString:text]) {
        self.textField.text = text;
    }
}

- (NSString*)text {
    _text = self.textField.text;
    return _text;
}

- (void)textfieldResignFirstResponder {
    [self.textField resignFirstResponder];
}

- (void)searchWordChanged:(NSNotification*)sender {
    if ([self.delegate respondsToSelector:@selector(searchBarChangedEditing:)]) {
        [self.delegate searchBarChangedEditing:self];
    }
}

- (void)didEndEditingNoti:(NSNotification*)sender {
    [self resignFirstResponder];
}

#pragma mark TextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    if ([self.delegate respondsToSelector:@selector(searchBarShouldReturn:)]) {
        return [self.delegate searchBarShouldReturn:self];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField*)textField {
    if ([self.delegate respondsToSelector:@selector(searchBarDidBeginEditing:)]) {
        [self.delegate searchBarDidBeginEditing:self];
    }
}

- (void)textFieldDidEndEditing:(UITextField*)textField {
    _text = textField.text;
}

- (void)addKeyboardNotification {
    self.notificationObservers = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchWordChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEndEditingNoti:) name:UITextFieldTextDidEndEditingNotification object:nil];
}

- (void)removeKeyboardNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillChangeFrameNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
