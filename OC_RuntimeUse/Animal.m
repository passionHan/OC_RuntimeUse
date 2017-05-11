//
//  Animal.m
//  OC_RuntimeUse
//
//  Created by passionHan on 04/05/2017.
//  Copyright © 2017 www.hopechina.cc 中和黄埔. All rights reserved.
//

#import "Animal.h"
#import <objc/runtime.h>
@implementation Animal {
    NSString *hhh;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        unsigned int varCount = 0;
        Ivar *vars = class_copyIvarList([self class], &varCount);
        for (int i = 0; i < varCount; i ++) {
            Ivar var = vars[i];
            const char *varName = ivar_getName(var);
            NSString *key = [NSString stringWithUTF8String:varName];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(vars);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int varCount = 0;
    Ivar *vars = class_copyIvarList([self class], &varCount);
    for (int i = 0; i < varCount; i ++) {
        Ivar var = vars[i];
        const char *varName = ivar_getName(var);
        NSString *key = [NSString stringWithUTF8String:varName];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(vars);
}

- (void)printDogIvars {
    unsigned int varCount = 0;
    Class c = NSClassFromString(@"Dog");
    while (c && c != [NSObject class]) {
        Ivar *vars = class_copyIvarList(c, &varCount);
        // class_copyPropertyList 获得是当前类的所有属性，不包括成员变量hhh
        
        for (int i = 0; i < varCount; i ++) {
            Ivar var = vars[i];
            //获得成员变量的名字
            const char *varName = ivar_getName(var); //“_type”,"hhh"
            //获得成员变量的类型
            const char *varType = ivar_getTypeEncoding(var);//"NSString"
            NSLog(@"varName = %s,varType = %s", varName, varType);
        }
        c = [c superclass];
        free(vars);
    }
}

- (void)dymicCreateDogClass {
    const char *className = "Dog";
    
    Class Dog = object_getClass(NSClassFromString([NSString stringWithUTF8String:className]));
    if (!Dog) {
        //动态创建一个继承自Animal的Dog类
        Dog = objc_allocateClassPair([Animal class], className, 0);
        //给创建的Dog类添加成员变量
        if (class_addIvar(Dog, "header", sizeof(NSString *), 0, "@")) {
            NSLog(@"success");
        }
        class_addMethod(Dog, @selector(printDogIvarsValue), (IMP)printDogIvarsValue, "");
        //注册到运行时环境
        objc_registerClassPair(Dog);
    }
    
    id smallDog = [[Dog alloc] init];
//    //给变量赋值
    [smallDog setValue:@"smallHeader" forKey:@"header"];
    
    [smallDog printDogIvarsValue];
}

//这个方法实际上没有调用，但是必须实现这个方法，才能调用下面的方法
- (void)printDogIvarsValue {
    
}

//调用这个方法，self和_cmd 参数是必须的，在之后也可以随便添加参数
static void printDogIvarsValue(id self, SEL _cmd) {
    Ivar var = class_getInstanceVariable([self class], "header");
    
    id value = object_getIvar(self, var);
    
    NSLog(@"动态创建的Dog类的成员变量header的值==%@", value);
}

@end
