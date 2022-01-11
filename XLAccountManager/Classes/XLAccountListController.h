//
//  XLAccountListController.h
//  F5iOS
//
//  Created by mgfjx on 2022/1/10.
//  Copyright © 2022 mgfjx. All rights reserved.
//

//#import "BaseViewController.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLAccountListController : UIViewController

@property (nonatomic, copy) void (^selectedAccountCallback)(NSString *account, NSString *password) ;

@end

NS_ASSUME_NONNULL_END
