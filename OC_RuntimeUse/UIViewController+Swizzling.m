//
//  UIViewController+Swizzling.m
//  OC_RuntimeUse
//
//  Created by passionHan on 03/05/2017.
//  Copyright © 2017 www.hopechina.cc 中和黄埔. All rights reserved.
//

#import "UIViewController+Swizzling.h"
#import <objc/runtime.h>

static const char nameKey;

@implementation UIViewController (Swizzling)

//当程序装载到内存中的时候调用
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod([UIViewController class], @selector(viewDidLoad));
        Method swizzledMethod = class_getInstanceMethod([UIViewController class], @selector(swizzling_viewDidLoad));
        
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

- (void)swizzling_viewDidLoad {
    if (self.navigationController) {
        UIImage *buttonNormal = [[UIImage imageNamed:@"nav_back_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self.navigationController.navigationBar setBackIndicatorImage:buttonNormal];
        [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:buttonNormal];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backItem;
    }
    [self swizzling_viewDidLoad];
}

- (void)setName:(NSString *)name {
    //将值和对象关联起来
    objc_setAssociatedObject(self, &nameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name {
    return objc_getAssociatedObject(self, &nameKey);
}

@end
