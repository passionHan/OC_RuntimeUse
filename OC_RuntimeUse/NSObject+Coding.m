//
//  NSObject+Coding.m
//  OC_RuntimeUse
//
//  Created by passionHan on 08/05/2017.
//  Copyright © 2017 www.hopechina.cc 中和黄埔. All rights reserved.
//

#import "NSObject+Coding.h"
#import <objc/runtime.h>
@implementation NSObject (Coding)

- (void)encode:(NSCoder *)encoder {
    Class c = [self class];
    unsigned int varCount = 0;
    Ivar *vars = class_copyIvarList(c, &varCount);
    for (int i = 0; i < varCount; i ++) {
        Ivar var = vars[i];
        const char *varName = ivar_getName(var);
        NSString *key = [NSString stringWithUTF8String:varName];
        // 忽略不需要解档的属性
        if ([[self ignoredNames] containsObject:key]) {
            continue;
        }
        id value = [self valueForKey:key];
        [encoder encodeObject:value forKey:key];
    }
    free(vars);
}

- (void)decode:(NSCoder *)decoder {
    Class c = [self class];
    unsigned int varCount = 0;
    Ivar *vars = class_copyIvarList(c, &varCount);
    for (int i = 0; i < varCount; i ++) {
        Ivar var = vars[i];
        const char *varName = ivar_getName(var);
        NSString *key = [NSString stringWithUTF8String:varName];
        // 忽略不需要解档的属性
        if ([[self ignoredNames] containsObject:key]) {
            continue;
        }
        id value = [decoder decodeObjectForKey:key];
        [self setValue:value forKey:key];
    }
    free(vars);
}

@end
