//
//  Animal.h
//  OC_RuntimeUse
//
//  Created by passionHan on 04/05/2017.
//  Copyright © 2017 www.hopechina.cc 中和黄埔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animal : NSObject <NSCoding>

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *name;

- (void)dymicCreateDogClass;

- (void)printDogIvars;


@end
