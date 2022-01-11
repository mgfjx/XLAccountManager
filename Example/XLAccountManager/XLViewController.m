//
//  XLViewController.m
//  XLAccountManager
//
//  Created by xxl on 01/11/2022.
//  Copyright (c) 2022 xxl. All rights reserved.
//

#import "XLViewController.h"
//#import <XLAccountManager.h>
#import <XLAccountManager/XLAccountManager.h>

@interface XLViewController ()

@end

@implementation XLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)showAccounts:(UIButton *)sender {
    
    XLAccountListController *vc = [[XLAccountListController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
    vc.selectedAccountCallback = ^(NSString * _Nonnull account, NSString * _Nonnull password) {
        NSLog(@"account: %@, password: %@", account, password);
    };
    
}

@end
