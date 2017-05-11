//
//  UserInfo.h
//  OC_RuntimeUse
//
//  Created by passionHan on 05/05/2017.
//  Copyright © 2017 www.hopechina.cc 中和黄埔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject <NSCoding>

+ (UserInfo *)sharedUserInfo;

- (void)save;

@property (nonatomic, copy) NSString *name;


@end
