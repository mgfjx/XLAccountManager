//
//  XLAccountListController.m
//  F5iOS
//
//  Created by mgfjx on 2022/1/10.
//  Copyright © 2022 mgfjx. All rights reserved.
//

#import "XLAccountListController.h"
#import "XLAccountListCell.h"
#import "XLArchiveObj.h"
#import "UIView+xllayout.h"
#import "UIImage+XLAccountImage.h"

/* ------------------------------------------------ */
//创建测试账号对象
@interface AccountObj : XLArchiveObj
@property (nonatomic, strong) NSString *account ;
@property (nonatomic, strong) NSString *password ;
@property (nonatomic, strong) NSString *desc ; //描述
+ (instancetype)account:(NSString *)account password:(NSString *)password desc:(NSString *)desc ;
@end
@implementation AccountObj
+ (instancetype)account:(NSString *)account password:(NSString *)password desc:(NSString *)desc {
    AccountObj *obj = [[AccountObj alloc] init];
    obj.account = account;
    obj.password = password;
    obj.desc = desc;
    return obj;
}
@end
/* ------------------------------------------------ */

@interface XLAccountListController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<AccountObj *> *dataArray ;
@property (nonatomic, strong) UITableView *tableView ;

@end

@implementation XLAccountListController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [self getAccountObjs].mutableCopy;
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (!self.dataArray.count) {
        self.dataArray = [self getTestAccount].mutableCopy;
    }
    
    [self initViews];
}

- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addAccount {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Account Information" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        UITextField *descTextField = alertController.textFields.firstObject;
        UITextField *userNameTextField = [alertController.textFields objectAtIndex:1];
        UITextField *passwordTextField = alertController.textFields.lastObject;
        NSString *account = userNameTextField.text;
        NSString *password = passwordTextField.text;
        NSString *desc = descTextField.text;
        if (account.length == 0 || password.length == 0 || desc.length == 0) {
//            [PublicDialogManager showText:@"賬號、密碼、描述都不能為空" inView:self.view duration:1];
        } else {
            [self addAndSaveAccount:account password:password desc:desc];
        }
    }]];
    
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Account Description";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Account";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Password";
    }];
    
    [self presentViewController:alertController animated:true completion:nil];
    
}

- (void)initViews {
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView activateConstraints:@[
        bgView.topAnchor.equalTo(self.view.topAnchor).offset(0),
        bgView.leftAnchor.equalTo(self.view.leftAnchor).offset(0),
        bgView.rightAnchor.equalTo(self.view.rightAnchor).offset(0),
        bgView.heightAnchor.equalToValue(44),
    ]];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithRed:0.949 green:0.949 blue:0.969 alpha:1.000];
    [bgView addSubview:line];
    [line activateConstraints:@[
        line.heightAnchor.equalToValue(1),
        line.leftAnchor.equalTo(bgView.leftAnchor).offset(0),
        line.rightAnchor.equalTo(bgView.rightAnchor).offset(0),
        line.bottomAnchor.equalTo(bgView.bottomAnchor).offset(0),
    ]];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    titleLabel.text = @"Accounts";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:titleLabel];
    [titleLabel activateConstraints:@[
        titleLabel.topAnchor.equalTo(bgView.topAnchor).offset(0),
        titleLabel.leftAnchor.equalTo(bgView.leftAnchor).offset(0),
        titleLabel.rightAnchor.equalTo(bgView.rightAnchor).offset(0),
        titleLabel.bottomAnchor.equalTo(bgView.bottomAnchor).offset(0),
    ]];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:[UIImage am_imageNamed:@"add"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addAccount) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:addBtn];
    [addBtn sizeToFit];
    [addBtn activateConstraints:@[
        addBtn.centerYAnchor.equalTo(titleLabel.centerYAnchor),
        addBtn.rightAnchor.equalTo(bgView.rightAnchor).offset(-10),
    ]];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage am_imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:closeBtn];
    [closeBtn sizeToFit];
    [closeBtn activateConstraints:@[
        closeBtn.centerYAnchor.equalTo(titleLabel.centerYAnchor),
        closeBtn.leftAnchor.equalTo(bgView.leftAnchor).offset(10),
    ]];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [table registerNib:[UINib nibWithNibName:NSStringFromClass([XLAccountListCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([XLAccountListCell class])];
    [table registerClass:[XLAccountListCell class]forCellReuseIdentifier:NSStringFromClass([XLAccountListCell class])];
    [self.view addSubview:table];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.backgroundColor = [UIColor colorWithRed:0.949 green:0.949 blue:0.969 alpha:1.000];
    self.tableView = table;
    
    [table activateConstraints:@[
        table.topAnchor.equalTo(bgView.bottomAnchor).offset(0),
        table.leftAnchor.equalTo(self.view.leftAnchor).offset(0),
        table.rightAnchor.equalTo(self.view.rightAnchor).offset(0),
        table.bottomAnchor.equalTo(self.view.bottomAnchor).offset(0),
    ]];
    
}

- (NSArray<AccountObj *> *)getTestAccount {
    return  @[
    ];
}

- (void)addAndSaveAccount:(NSString *)account password:(NSString *)password desc:(NSString *)desc {
    AccountObj *obj = [AccountObj account:account password:password desc:desc];
    [self.dataArray addObject:obj];
    [self.tableView reloadData];
    [self saveDataToLocal];
}

- (void)saveDataToLocal {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.dataArray];
    [data writeToFile:[self savePath] atomically:YES];
}

- (NSString *)savePath {
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [NSString stringWithFormat:@"%@/Accounts", documentPath];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        BOOL success = [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
        NSLog(@"%d", success);
    }
    return filePath;
}

- (NSArray<AccountObj *> *)getAccountObjs {
    NSData *data = [[NSData alloc] initWithContentsOfFile:[self savePath]];
    NSArray *dataArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return dataArray;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellReuse = NSStringFromClass([XLAccountListCell class]);
    XLAccountListCell *cell = (XLAccountListCell *)[tableView dequeueReusableCellWithIdentifier:cellReuse];
    
    if (indexPath.row % 2 == 0) {
//        cell.backgroundColor = [UIColor colorWithRed:0.980 green:0.980 blue:0.980 alpha:1.000];
    } else {
//        cell.backgroundColor = [UIColor whiteColor];
    }
    
    AccountObj *obj = self.dataArray[indexPath.section];
    cell.titleLabel.text = obj.desc;
    cell.accountLabel.text = obj.account;
    cell.passwordLabel.text = obj.password;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    AccountObj *obj = self.dataArray[indexPath.section];
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.selectedAccountCallback) {
            self.selectedAccountCallback(obj.account, obj.password);
        }
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"刪除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataArray removeObjectAtIndex:indexPath.section];
        [tableView reloadData];
        [self saveDataToLocal];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

@end
