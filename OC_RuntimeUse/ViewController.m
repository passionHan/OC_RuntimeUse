//
//  ViewController.m
//  OC_RuntimeUse
//
//  Created by passionHan on 03/05/2017.
//  Copyright © 2017 www.hopechina.cc 中和黄埔. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+Swizzling.h"
#import "Animal.h"
#import "UserInfo.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     runtime 简介
        runtime是OC的一个很重要的机制，运行时机制，我们平时写的OC代码都会被转成runtime代码 runtime是一套比较底层的纯C语言的API。
        runtime最主要的应该就是消息机制了，OC调用函数为消息发送，属于动态调用，编译的时候不能决定真正调用的哪个函数，这个和C，C++不同，C，C++在一个函数没有实现的时候编译也是通过不了的，而OC则不会。
        OC调用函数在runtime中用 objc_msgSend(obj,@selecter(make))表示
        runtime属于OC的底层了，可以进行一些非常底层的操作,例如：
        1.分类设置属性
            我们应该都试过，直接在分类中是不能添加属性的，运行会crash，但是可以利用runtime给分类添加属性，参考UIViewController+Swizzling，给控制器添加一个name属性
        2.交换两个方法的实现
            比较常用的是拦截系统自带方法调用（Swizzling),如果我们想统一给项目中的控制器自定义返回按钮样式，则可以Swizzling 控制器的ViewDidLoad方法,参考UIViewController+Swizzling  注：统一设置项目中的返回按钮，常用的方法还有是自定义导航控制器，重写导航控制器的push方法统一设置。这里主要是介绍OC的黑魔法 runtime Swizzling使用。
        3.获取某个类的所有成员变量 class_copyIvarList 和方法 class_copyMethodList
            获得变量名 ivar_getName，获得变量类型 ivar_getTypeEncoding
            获得方法名 method_getName 
        4.动态生成一个类。objc_allocateClassPair
            添加一个成员变量：class_addIvar
            添加一个方法：class_addMethod
            必须要注册到运行时环境才能生效：objc_registerClassPair
     
        **详细使用见Animal类
     
        runtime 经典使用例子：对一个类的对象进行归档
            我们在常规的归档中，如果一个类有很多属性的话，那么我们需要在归档和解档的方法中需要添加很多重复的代码。利用runtime我们可以获得一个类的所有成员变量，那么我们就能减少很多重复代码了。详见 UserInfo类
        还有一个好的处理方式是给NSObject添加一个分类，详见NSObject+Coding 和 UserInfo类
            
     */
    
    self.name = @"RootViewController";
    NSLog(@"%@", self.name);
    
    Animal *animal = [Animal new];
    
    //动态创建一个继承子Animal的Dog类
    [animal dymicCreateDogClass];
    
    //打印Dog类的所有成员变量
    [animal printDogIvars];
    
    if ([UserInfo sharedUserInfo].name == nil) {
        [UserInfo sharedUserInfo].name = @"哈哈哈";
        [[UserInfo sharedUserInfo] save];
        NSLog(@"归档成功=====");
    } else {
        NSLog(@"解档成功=====");
    }
}

@end
