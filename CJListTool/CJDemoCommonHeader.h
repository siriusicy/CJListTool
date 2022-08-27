//
//  CJDemoCommonHeader.h
//  CJListTool
//
//  Created by ChenJie on 2022/8/20.
//

#ifndef CJDemoCommonHeader_h
#define CJDemoCommonHeader_h

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Masonry/Masonry.h>
//#import "UIColor+Tool.h"
#import "UIScrollView+Refresh.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

/// 状态栏高度
#define YYStatusHeight ([YYGlobelConst yf_statusBarFrame].size.height)
/// 导航高度
#define YYNavHeight (YYStatusHeight + 44.0)

#pragma mark -  方法交换
#import <objc/runtime.h>
static inline void yf_swizzled_instanceMethod(SEL originalSelector, SEL swizzledSelector, Class class) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

#pragma mark -  weakStrong
#ifndef weakobj
    #if DEBUG
        #if __has_feature(objc_arc)
        #define weakobj(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakobj(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define weakobj(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakobj(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongobj
    #if DEBUG
        #if __has_feature(objc_arc)
        #define strongobj(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
        #define strongobj(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define strongobj(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
        #define strongobj(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif


#endif /* CJDemoCommonHeader_h */
