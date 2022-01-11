//
//  XLAccountListCell.m
//  F5iOS
//
//  Created by mgfjx on 2022/1/10.
//  Copyright © 2022 mgfjx. All rights reserved.
//

#import "XLAccountListCell.h"
#import "UIView+xllayout.h"

@implementation XLAccountListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews {
    
    UIView *bgView = self.contentView;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    [bgView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    [titleLabel activateConstraints:@[
        titleLabel.topAnchor.equalTo(bgView.topAnchor).offset(8),
        titleLabel.leftAnchor.equalTo(bgView.leftAnchor).offset(18),
    ]];
    
    UILabel *accountLabel = [[UILabel alloc] init];
    accountLabel.textColor = [UIColor colorWithRed:0.682 green:0.682 blue:0.699 alpha:1.000];
    accountLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    [bgView addSubview:accountLabel];
    self.accountLabel = accountLabel;
    [accountLabel activateConstraints:@[
        accountLabel.topAnchor.equalTo(titleLabel.bottomAnchor).offset(5),
        accountLabel.leftAnchor.equalTo(titleLabel.leftAnchor),
    ]];
    
    UILabel *passwordLabel = [[UILabel alloc] init];
    passwordLabel.textColor = [UIColor colorWithRed:0.682 green:0.682 blue:0.699 alpha:1.000];
    passwordLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    [bgView addSubview:passwordLabel];
    self.passwordLabel = passwordLabel;
    [passwordLabel activateConstraints:@[
        passwordLabel.topAnchor.equalTo(accountLabel.bottomAnchor).offset(5),
        passwordLabel.leftAnchor.equalTo(accountLabel.leftAnchor),
    ]];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithRed:0.882 green:0.882 blue:0.882 alpha:1.000];
    [bgView addSubview:line];
    [line activateConstraints:@[
        line.heightAnchor.equalToValue(1),
        line.leftAnchor.equalTo(bgView.leftAnchor).offset(0),
        line.rightAnchor.equalTo(bgView.rightAnchor).offset(0),
        line.bottomAnchor.equalTo(bgView.bottomAnchor).offset(0),
    ]];
    
}

@end
