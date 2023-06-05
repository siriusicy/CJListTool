//
//  UIScrollView+YFEmpty.m
//  CJListTool
//
//  Created by ChenJie on 2022/9/5.
//

#import "UIScrollView+YFEmpty.h"
#import "CJDemoCommonHeader.h"
#import <objc/runtime.h>

@interface UIScrollView ()
@property (nonatomic, weak) id<DZNEmptyDataSetSource> yf_EmptyDataSetSource;
@property (nonatomic, weak) id<DZNEmptyDataSetDelegate> yf_EmptyDataSetDelegate;
@property (nonatomic, assign) BOOL allowTouch;
@end

@implementation UIScrollView (YFEmpty)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        yf_swizzled_instanceMethod(@selector(respondsToSelector:), @selector(yf_swizzled_emptyRespondsToSelector:), class);
        yf_swizzled_instanceMethod(@selector(methodSignatureForSelector:), @selector(yf_swizzled_emptyMethodSignatureForSelector:), class);
        yf_swizzled_instanceMethod(@selector(forwardInvocation:), @selector(yf_swizzled_emptyForwardInvocation:), class);
        yf_swizzled_instanceMethod(@selector(setEmptyDataSetSource:), @selector(yf_swizzled_setEmptyDataSetSource:), class);
        yf_swizzled_instanceMethod(@selector(setEmptyDataSetDelegate:), @selector(yf_swizzled_setEmptyDataSetDelegate:), class);
    });
}

#pragma mark -  swizzled
- (void)yf_swizzled_setEmptyDataSetSource:(id<DZNEmptyDataSetSource>)dataSource {
    self.yf_EmptyDataSetSource = dataSource != self ? dataSource : nil;
    [self yf_swizzled_setEmptyDataSetSource:self];
}

- (void)yf_swizzled_setEmptyDataSetDelegate:(id<DZNEmptyDataSetDelegate>)delegate {
    self.yf_EmptyDataSetDelegate = delegate != self ? delegate : nil;
    [self yf_swizzled_setEmptyDataSetDelegate:self];
}

- (BOOL)yf_swizzled_emptyRespondsToSelector:(SEL)selector{
    if ([self.yf_EmptyDataSetDelegate respondsToSelector:selector]) {
        return YES;
    }else if ([self.yf_EmptyDataSetSource respondsToSelector:selector]) {
        return YES;
    }
    return [self yf_swizzled_emptyRespondsToSelector:selector];
}

- (void)yf_swizzled_emptyForwardInvocation:(NSInvocation *)anInvocation{
    SEL sel = [anInvocation selector];
    if ([self.yf_EmptyDataSetDelegate respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:self.yf_EmptyDataSetDelegate];
    }else if ([self.yf_EmptyDataSetSource respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:self.yf_EmptyDataSetSource];
    }else{
        [self yf_swizzled_emptyForwardInvocation:anInvocation];
    }
}

- (NSMethodSignature *)yf_swizzled_emptyMethodSignatureForSelector:(SEL)aSelector{
    if ([self.yf_EmptyDataSetDelegate respondsToSelector:aSelector]) {
        return [(id)self.yf_EmptyDataSetDelegate methodSignatureForSelector:aSelector];
    }else if ([self.yf_EmptyDataSetSource respondsToSelector:aSelector]) {
        return [(id)self.yf_EmptyDataSetSource methodSignatureForSelector:aSelector];
    }else if ([super respondsToSelector:aSelector]) {
        return [self yf_swizzled_emptyMethodSignatureForSelector:aSelector];
    }else {
        return nil;
    }
}

#pragma mark - DZNEmptyDataSetSource

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    if ([self.yf_EmptyDataSetSource respondsToSelector:@selector(backgroundColorForEmptyDataSet:)]) {
        return [self.yf_EmptyDataSetSource backgroundColorForEmptyDataSet:scrollView];
    }
    if (self.emptyDataSetBackgroundColor) {
        return self.emptyDataSetBackgroundColor;
    }
    // 和 DZNEmptyDataSet 默认值一样
    return [UIColor clearColor];
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    if ([self.yf_EmptyDataSetSource respondsToSelector:@selector(spaceHeightForEmptyDataSet:)]) {
        return [self.yf_EmptyDataSetSource spaceHeightForEmptyDataSet:scrollView];
    }
    return 4;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    if ([self.yf_EmptyDataSetSource respondsToSelector:@selector(titleForEmptyDataSet:)]) {
        return [self.yf_EmptyDataSetSource titleForEmptyDataSet:scrollView];
    }
    if (self.isError) {
        return scrollView.errorAttributedString;
    }else {
        return scrollView.emptyAttributedString;
    }
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    if ([self.yf_EmptyDataSetSource respondsToSelector:@selector(descriptionForEmptyDataSet:)]) {
        return [self.yf_EmptyDataSetSource descriptionForEmptyDataSet:scrollView];
    }
    if (self.isError) {
        return scrollView.errorDescriptionAttributedString;
    }else {
        return scrollView.emptyDescriptionAttributedString;
    }
    return nil;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if ([self.yf_EmptyDataSetSource respondsToSelector:@selector(imageForEmptyDataSet:)]) {
        return [self.yf_EmptyDataSetSource imageForEmptyDataSet:scrollView];
    }
    if (self.isError) {
        return scrollView.errorImage;
    }else{
        return scrollView.emptyImage;
    }
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    if ([self.yf_EmptyDataSetSource respondsToSelector:@selector(verticalOffsetForEmptyDataSet:)]) {
        return [self.yf_EmptyDataSetSource verticalOffsetForEmptyDataSet:scrollView];
    }
    return -20;
}

#pragma mark - DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    if ([self.yf_EmptyDataSetDelegate respondsToSelector:@selector(emptyDataSetShouldDisplay:)]) {
        return [self.yf_EmptyDataSetDelegate emptyDataSetShouldDisplay:scrollView];
    }
    __block BOOL show = NO;
    void (^once)(void) = ^{
        if (objc_getAssociatedObject(self, _cmd)) {
            show = YES;
        }else{
            objc_setAssociatedObject(self, _cmd, @"YFEmpty_once", OBJC_ASSOCIATION_RETAIN);
        }
    };
    once();
    return show;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    if ([self.yf_EmptyDataSetDelegate respondsToSelector:@selector(emptyDataSetShouldAllowScroll:)]) {
        return [self.yf_EmptyDataSetDelegate emptyDataSetShouldAllowScroll:scrollView];
    }
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    if ([self.yf_EmptyDataSetDelegate respondsToSelector:@selector(emptyDataSetShouldAllowTouch:)]) {
        return [self.yf_EmptyDataSetDelegate emptyDataSetShouldAllowTouch:scrollView];
    }
    return scrollView.allowTouch;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    self.isError = NO;
    if ([self.yf_EmptyDataSetDelegate respondsToSelector:@selector(emptyDataSet:didTapView:)]) {
        return [self.yf_EmptyDataSetDelegate emptyDataSet:scrollView didTapView:view];
    }
}

#pragma mark - getters and setters
///isError
- (BOOL)isError {
    return [objc_getAssociatedObject(self, @selector(isError)) boolValue];
}

- (void)setIsError:(BOOL)isError {
    if (isError) {
        self.allowTouch = YES;
    }else {
        self.allowTouch = NO;
    }
    objc_setAssociatedObject(self, @selector(isError), @(isError), OBJC_ASSOCIATION_ASSIGN);
}

///errorString
- (NSString *)errorString {
    NSString *errorString = objc_getAssociatedObject(self, @selector(errorString));
    if (!errorString) {
        errorString = [[UIScrollView appearance] errorString];
    }
   return errorString;
}

- (void)setErrorString:(NSString *)errorString {
    objc_setAssociatedObject(self, @selector(errorString), errorString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

///errorAttributedString
- (NSAttributedString *)errorAttributedString {
    NSAttributedString *errorAttributedString = objc_getAssociatedObject(self, @selector(errorAttributedString));
    if (!errorAttributedString && self.errorString) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.errorString
                                                                                             attributes:@{
            
            
            NSFontAttributeName: [UIFont systemFontOfSize:14],
            NSForegroundColorAttributeName: [UIColor grayColor],
        }];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineHeightMultiple = 1.4;
        paragraphStyle.alignment = NSTextAlignmentCenter;
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.errorString length])];
        self.errorAttributedString = [attributedString copy];
        errorAttributedString = attributedString;
    }
    return errorAttributedString;
}

- (void)setErrorAttributedString:(NSAttributedString *)errorAttributedString {
    objc_setAssociatedObject(self, @selector(errorAttributedString), errorAttributedString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

///errorDescriptionString
- (NSString *)errorDescriptionString {
    NSString *errorDescriptionString = objc_getAssociatedObject(self, @selector(errorDescriptionString));
    if (!errorDescriptionString) {
        errorDescriptionString = [[UIScrollView appearance] errorDescriptionString];
    }
    return errorDescriptionString;
}

- (void)setErrorDescriptionString:(NSString *)errorDescriptionString {
    objc_setAssociatedObject(self, @selector(errorDescriptionString), errorDescriptionString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

///errorDescriptionAttributedString
- (NSAttributedString *)errorDescriptionAttributedString {
    NSAttributedString *errorDescriptionAttributedString = objc_getAssociatedObject(self, @selector(errorDescriptionAttributedString));
    if (!errorDescriptionAttributedString && self.errorDescriptionString) {
        NSMutableAttributedString *desAttributedText = [[NSMutableAttributedString alloc] initWithString:self.errorDescriptionString
                                                                                             attributes:@{
            NSFontAttributeName: [UIFont systemFontOfSize:16.0],
            NSForegroundColorAttributeName: [UIColor grayColor],
        }];
        self.errorDescriptionAttributedString = desAttributedText;
        errorDescriptionAttributedString = [desAttributedText copy];
    }
    return errorDescriptionAttributedString;
}

- (void)setErrorDescriptionAttributedString:(NSAttributedString *)errorDescriptionAttributedString {
    objc_setAssociatedObject(self, @selector(errorDescriptionAttributedString), errorDescriptionAttributedString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

///errorImage
- (UIImage *)errorImage {
    UIImage *errorImage = objc_getAssociatedObject(self, @selector(errorImage));
    if (!errorImage) {
        errorImage = [[UIScrollView appearance] errorImage];
    }
    return errorImage;
}

- (void)setErrorImage:(UIImage *)errorImage {
    objc_setAssociatedObject(self, @selector(errorImage), errorImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

///emptyString
- (NSString *)emptyString {
    NSString *emptyString = objc_getAssociatedObject(self, @selector(emptyString));
    if (!emptyString) {
        emptyString = [[UIScrollView appearance] emptyString];
    }
    return emptyString;
}

- (void)setEmptyString:(NSString *)emptyString {
    objc_setAssociatedObject(self, @selector(emptyString), emptyString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

///emptyAttributedString
- (NSAttributedString *)emptyAttributedString {
    NSAttributedString *emptyAttributedString = objc_getAssociatedObject(self, @selector(emptyAttributedString));
    if (!emptyAttributedString && self.emptyString) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.emptyString attributes:@{
            NSFontAttributeName: [UIFont systemFontOfSize:16.0],
            NSForegroundColorAttributeName: [UIColor lightGrayColor],
        }];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineHeightMultiple = 1.4;
        paragraphStyle.alignment = NSTextAlignmentCenter;
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.emptyString length])];
        self.emptyAttributedString = [attributedString copy];
        emptyAttributedString = attributedString;
    }
    return emptyAttributedString;
}

- (void)setEmptyAttributedString:(NSAttributedString *)emptyAttributedString {
    objc_setAssociatedObject(self, @selector(emptyAttributedString), emptyAttributedString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

///emptyDescriptionString
- (NSString *)emptyDescriptionString {
    NSString *emptyDescriptionString = objc_getAssociatedObject(self, @selector(emptyDescriptionString));
    if (!emptyDescriptionString) {
        emptyDescriptionString = [[UIScrollView appearance] emptyDescriptionString];
    }
    return emptyDescriptionString;
}

- (void)setEmptyDescriptionString:(NSString *)emptyDescriptionString {
    objc_setAssociatedObject(self, @selector(emptyDescriptionString), emptyDescriptionString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

///emptyDescriptionAttributedString
- (NSAttributedString *)emptyDescriptionAttributedString {
    NSAttributedString *emptyDescriptionAttributedString = objc_getAssociatedObject(self, @selector(emptyDescriptionAttributedString));
    if (!emptyDescriptionAttributedString && self.emptyDescriptionString) {
        NSMutableAttributedString *desAttributedText = [[NSMutableAttributedString alloc] initWithString:self.emptyDescriptionString
                                                                                              attributes:@{
            NSFontAttributeName: [UIFont systemFontOfSize:16.0],
            NSForegroundColorAttributeName: [UIColor lightGrayColor],
        }];
        self.emptyDescriptionAttributedString = desAttributedText;
        emptyDescriptionAttributedString = [desAttributedText copy];
    }
    return emptyDescriptionAttributedString;
}

- (void)setEmptyDescriptionAttributedString:(NSAttributedString *)emptyDescriptionAttributedString {
    objc_setAssociatedObject(self, @selector(emptyDescriptionAttributedString), emptyDescriptionAttributedString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

///emptyDataSetBackgroundColor
- (void)setEmptyDataSetBackgroundColor:(UIColor *)emptyDataSetBackgroundColor {
    objc_setAssociatedObject(self, @selector(emptyDataSetBackgroundColor), emptyDataSetBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)emptyDataSetBackgroundColor {
    UIColor *backgroundColor = objc_getAssociatedObject(self, @selector(emptyDataSetBackgroundColor));
    if (!backgroundColor) {
        backgroundColor = [[UIScrollView appearance] emptyDataSetBackgroundColor];
    }
    return backgroundColor;
}

///emptyImage
- (UIImage *)emptyImage {
    UIImage *emptyImage = objc_getAssociatedObject(self, @selector(emptyImage));
    if (!emptyImage) {
        emptyImage = [[UIScrollView appearance] emptyImage];
    }
    return emptyImage;
}

- (void)setEmptyImage:(UIImage *)emptyImage {
    objc_setAssociatedObject(self, @selector(emptyImage), emptyImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -  set/get
//是否可以点击 内部使用，外部依然使用- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView代理来判断
- (BOOL)allowTouch {
    return [objc_getAssociatedObject(self, @selector(allowTouch)) boolValue];
}

- (void)setAllowTouch:(BOOL)allowTouch {
    objc_setAssociatedObject(self, @selector(allowTouch), @(allowTouch), OBJC_ASSOCIATION_ASSIGN);
}

//因为没有 OBJC_ASSOCIATION_WEAK 所以套一层block 断开循环引用问题
- (id<DZNEmptyDataSetSource>)yf_EmptyDataSetSource {
    id (^block)(void) =  objc_getAssociatedObject(self, @selector(yf_EmptyDataSetSource));
    return block ? block() : nil;
}

- (void)setYf_EmptyDataSetSource:(id<DZNEmptyDataSetSource>)yf_EmptyDataSetSource {
    id __weak weakObject = yf_EmptyDataSetSource;
    id (^block)(void) = ^{ return weakObject; };
    objc_setAssociatedObject(self, @selector(yf_EmptyDataSetSource), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (id<DZNEmptyDataSetDelegate>)yf_EmptyDataSetDelegate {
    id (^block)(void) =  objc_getAssociatedObject(self, @selector(yf_EmptyDataSetDelegate));
    return block ? block() : nil;
}

- (void)setYf_EmptyDataSetDelegate:(id<DZNEmptyDataSetDelegate>)yf_EmptyDataSetDelegate {
    id __weak weakObject = yf_EmptyDataSetDelegate;
    id (^block)(void) = ^{ return weakObject; };
    objc_setAssociatedObject(self, @selector(yf_EmptyDataSetDelegate), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end

