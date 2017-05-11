//
//  UserInfo.m
//  OC_RuntimeUse
//
//  Created by passionHan on 05/05/2017.
//  Copyright © 2017 www.hopechina.cc 中和黄埔. All rights reserved.
//

#import "UserInfo.h"
#import <objc/runtime.h>
#import "NSObject+Coding.h"

#define ArchiverPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"UserInfo.data"]

@implementation UserInfo

+ (UserInfo *)sharedUserInfo {
    static UserInfo *user;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        user = [NSKeyedUnarchiver unarchiveObjectWithFile: ArchiverPath];
        if (user == nil) {
            user = [[UserInfo alloc] init];
        }
    });
    
    return user;
}

- (void)save {
    [NSKeyedArchiver archiveRootObject:self toFile:ArchiverPath];
}

//解档
//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    if (self = [super init]) {
//        unsigned int varCount = 0;
//        Ivar *vars = class_copyIvarList([self class], &varCount);
//        for (int i = 0; i < varCount; i ++) {
//            Ivar var = vars[i];
//            const char *varName = ivar_getName(var);
//            NSString *key = [NSString stringWithUTF8String:varName];
//            id value = [aDecoder decodeObjectForKey:key];
//            [self setValue:value forKey:key];
//        }
//        free(vars);
//    }
//    return self;
//}
//
////归档
//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    unsigned int varCount = 0;
//    Ivar *vars = class_copyIvarList([self class], &varCount);
//    for (int i = 0; i < varCount; i ++) {
//        Ivar var = vars[i];
//        const char *varName = ivar_getName(var);
//        NSString *key = [NSString stringWithUTF8String:varName];
//        id value = [self valueForKey:key];
//        [aCoder encodeObject:value forKey:key];
//    }
//    free(vars);
//}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        [self decode:aDecoder];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [self encode:aCoder];
}

@end
