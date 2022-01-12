//
//  UIImage+XLAccountImage.m
//  XLAccountManager
//
//  Created by mgfjx on 2022/1/12.
//

#import "UIImage+XLAccountImage.h"
#import "XLAccountListController.h"

@implementation UIImage (XLAccountImage)

+ (UIImage *)am_imageNamed:(NSString *)name {
    return [self bm_imageNamed:name type:@"png"];//默认png
}

+ (UIImage *)bm_imageNamed:(NSString *)name type:(NSString *)type {
    NSString *path = [[NSBundle bundleForClass:[XLAccountListController class]] pathForResource:@"XLAccountManager" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    CGFloat scale = [UIScreen mainScreen].scale;
    if (scale == 2.0) {
        name = [NSString stringWithFormat:@"%@@2x", name];
    } else if (scale == 3.0) {
        name = [NSString stringWithFormat:@"%@@3x", name];
    }
    UIImage *image = [UIImage imageWithContentsOfFile:[bundle pathForResource:name ofType:type]];
    return image;
}

@end
