//
//  XLAccountListCell.m
//  F5iOS
//
//  Created by mgfjx on 2022/1/10.
//  Copyright © 2022 mgfjx. All rights reserved.
//

#import "XLAccountListCell.h"
#import "UIView+xllayout.h"
#import "UIImage+XLAccountImage.h"

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
    titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    [bgView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    [titleLabel activateConstraints:@[
        titleLabel.topAnchor.equalTo(bgView.topAnchor).offset(8),
        titleLabel.leftAnchor.equalTo(bgView.leftAnchor).offset(18),
    ]];
    
    __weak __typeof(&*self) weakSelf  = self;
    UIView *accountView = [self createImgLabelView:@"account" callback:^(UILabel *label) {
        weakSelf.accountLabel = label;
    }];
    [bgView addSubview:accountView];
    [accountView activateConstraints:@[
        accountView.topAnchor.equalTo(titleLabel.bottomAnchor).offset(5),
        accountView.leftAnchor.equalTo(titleLabel.leftAnchor),
        accountView.rightAnchor.equalTo(bgView.rightAnchor).offset(-5),
        accountView.heightAnchor.equalToValue(18),
    ]];
    
    UIView *passwordView = [self createImgLabelView:@"password" callback:^(UILabel *label) {
        weakSelf.passwordLabel = label;
    }];
    [bgView addSubview:passwordView];
    [passwordView activateConstraints:@[
        passwordView.topAnchor.equalTo(accountView.bottomAnchor).offset(5),
        passwordView.leftAnchor.equalTo(accountView.leftAnchor),
        passwordView.rightAnchor.equalTo(bgView.rightAnchor).offset(-5),
        passwordView.heightAnchor.equalToValue(18),
    ]];
    
    UIView *line = [[UIView alloc] init];
//    line.backgroundColor = [UIColor colorWithRed:0.882 green:0.882 blue:0.882 alpha:1.000];
    [bgView addSubview:line];
    [line activateConstraints:@[
        line.heightAnchor.equalToValue(0.5),
        line.leftAnchor.equalTo(bgView.leftAnchor).offset(0),
        line.rightAnchor.equalTo(bgView.rightAnchor).offset(0),
        line.bottomAnchor.equalTo(bgView.bottomAnchor).offset(0),
    ]];
    
}

- (UIView *)createImgLabelView:(NSString *)imageName callback:(void (^)(UILabel *label))callback {
    UIView *bgView = [[UIView alloc] init];

    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage am_imageNamed:imageName];
    [bgView addSubview:imageView];
    [imageView activateConstraints:@[
        imageView.topAnchor.equalTo(bgView.topAnchor).offset(2),
        imageView.bottomAnchor.equalTo(bgView.bottomAnchor).offset(-2),
        imageView.leftAnchor.equalTo(bgView.leftAnchor).offset(0),
        imageView.widthAnchor.equalTo(imageView.heightAnchor),
    ]];
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    label.text = @"账号：缪海华";
    [bgView addSubview:label];
    [label activateConstraints:@[
        label.centerYAnchor.equalTo(imageView.centerYAnchor).offset(0),
        label.leftAnchor.equalTo(imageView.rightAnchor).offset(5),
        label.rightAnchor.equalTo(bgView.rightAnchor),
    ]];
    
    callback(label);
    
    return bgView;
}

@end
