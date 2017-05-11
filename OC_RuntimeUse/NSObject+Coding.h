//
//  NSObject+Coding.h
//  OC_RuntimeUse
//
//  Created by passionHan on 08/05/2017.
//  Copyright © 2017 www.hopechina.cc 中和黄埔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Coding)

- (void)decode:(NSCoder *)decoder;

- (void)encode:(NSCoder *)encoder;

@end
