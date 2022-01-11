//
//  XLArchive.m
//  Unity
//
//  Created by mgfjx on 2017/3/21.
//  Copyright © 2017年 XXL. All rights reserved.
//

#import "XLArchiveObj.h"
#import <objc/runtime.h>

@implementation XLArchiveObj
//继承的属性无法获取
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    unsigned int outCount;
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar var = ivars[i];
        const char *name = ivar_getName(var);
        NSString *key = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        @try {
            id value = object_getIvar(self, var);
            [aCoder encodeObject:value forKey:key];
        }@catch (NSException *e) {
            NSLog(@"%@", e);
        }@finally {
            
        }
    }
    free(ivars);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        unsigned int outCount;
        Ivar *ivars = class_copyIvarList([self class], &outCount);
        for (int i = 0; i < outCount; i++) {
            Ivar var = ivars[i];
            const char *name = ivar_getName(var);
            NSString *key = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            id value = [aDecoder decodeObjectForKey:key];
            if (value) {
                [self setValue:value forKey:key];
            }
        }
        free(ivars);
    }
    return self;
}

@end
