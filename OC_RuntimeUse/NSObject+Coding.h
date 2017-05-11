//
//  NSObject+Coding.h
//  OC_RuntimeUse
//
//  Created by passionHan on 08/05/2017.
//  Copyright © 2017 www.hopechina.cc 中和黄埔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Coding)

- (NSArray *)ignoredNames;

- (void)decode:(NSCoder *)decoder;

- (void)encode:(NSCoder *)encoder;

@end
