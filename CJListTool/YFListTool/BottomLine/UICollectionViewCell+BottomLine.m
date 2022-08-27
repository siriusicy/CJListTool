//
//  UICollectionViewCell+BottomLine.m
//  CJListTool
//
//  Created by ChenJie on 2022/8/27.
//

#import "UICollectionViewCell+BottomLine.h"
#import "CJDemoCommonHeader.h"
#import <objc/runtime.h>

@interface UICollectionViewCell ()

@property (nonatomic, strong, readwrite) UIView *bottomLineView;

@end


@implementation UICollectionViewCell (Extend)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL layoutSubviewsSel = @selector(layoutSubviews);
        SEL swizzhlayoutSubviewsSel = @selector(yf_layoutSubviews);
        yf_swizzled_instanceMethod(layoutSubviewsSel, swizzhlayoutSubviewsSel, [self class]);
    });
}

- (void)yf_layoutSubviews {
    [self yf_layoutSubviews];
    
    if ([self.bottomLineView isDescendantOfView:self.contentView]) {
        [self.contentView bringSubviewToFront:self.bottomLineView];
    }
}

#pragma mark - public methods
- (void)yf_decorateWithBottomInfo:(YFCellBottomLineInfoModel *)info {
    if (info) {
        self.showBottomLine = info.showBottomLine;
        self.bottomLineLeft = info.bottomLineLeft;
        self.bottomLineRight = info.bottomLineRight;
        self.bottomLineHeight = info.bottomLineheight;
        self.bottomLineColor = info.bottomLineColor;
    } else {
        self.showBottomLine = NO;
        self.bottomLineLeft = 0;
        self.bottomLineRight = 0;
        self.bottomLineColor = [UIColor grayColor];
        self.bottomLineHeight = 1 / [[UIScreen mainScreen] scale];
    }
}

#pragma mark -  private

- (void)updateBottomLineView {
    self.bottomLineView.hidden = !self.showBottomLine;
    self.bottomLineView.backgroundColor = self.bottomLineColor;
    
    if (self.bottomLineView.hidden) {
        return;
    }
    
    if (![self.bottomLineView isDescendantOfView:self.contentView]) {
        [self.contentView addSubview:self.bottomLineView];
        [self.bottomLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bottomLineLeft);
            make.right.mas_equalTo(-fabs(self.bottomLineRight));
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(self.bottomLineHeight);
        }];
    } else {
        [self.bottomLineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bottomLineLeft);
            make.right.mas_equalTo(-fabs(self.bottomLineRight));
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(self.bottomLineHeight);
        }];
    }
}

#pragma mark - getters and setters
- (void)setShowBottomLine:(BOOL)showBottomLine{
    objc_setAssociatedObject(self, @selector(showBottomLine), @(showBottomLine), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateBottomLineView];
}
//
- (BOOL)showBottomLine{
    return [objc_getAssociatedObject(self, @selector(showBottomLine)) boolValue];
}
//
- (void)setBottomLineLeft:(CGFloat)bottomLineLeft{
    objc_setAssociatedObject(self, @selector(bottomLineLeft), @(bottomLineLeft), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateBottomLineView];
}
- (CGFloat)bottomLineLeft{
    return [objc_getAssociatedObject(self, @selector(bottomLineLeft)) floatValue];
}
//
- (void)setBottomLineRight:(CGFloat)bottomLineRight{
    objc_setAssociatedObject(self, @selector(bottomLineRight), @(bottomLineRight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateBottomLineView];
}
- (CGFloat)bottomLineRight{
    return [objc_getAssociatedObject(self, @selector(bottomLineRight)) floatValue];
}
//
- (void)setBottomLineHeight:(CGFloat)bottomLineheight{
    objc_setAssociatedObject(self, @selector(bottomLineHeight), @(bottomLineheight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateBottomLineView];
}
- (CGFloat)bottomLineHeight{
    CGFloat height =  [objc_getAssociatedObject(self, @selector(bottomLineHeight)) floatValue];
    if (height <= 0) {
        height = 1 / [[UIScreen mainScreen] scale];
    }
    return height;
}
//
- (void)setBottomLineColor:(UIColor *)bottomLineColor {
    objc_setAssociatedObject(self, @selector(bottomLineColor), bottomLineColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.bottomLineView.backgroundColor = bottomLineColor;
}
- (UIColor *)bottomLineColor {
    UIColor *color = objc_getAssociatedObject(self, @selector(bottomLineColor));
    return color;
}
//
- (void)setBottomLineView:(UIView *)bottomLineView{
    objc_setAssociatedObject(self, @selector(bottomLineView), bottomLineView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)bottomLineView{
    UIView * view = objc_getAssociatedObject(self , @selector(bottomLineView));
    if (!view) {
        view = [[UIView alloc] init];
        view.backgroundColor = [UIColor grayColor];
        view.hidden = YES;
        self.bottomLineView = view;
    }
    return view;
}

@end

