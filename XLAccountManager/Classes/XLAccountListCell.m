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
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editBtn setImage:[UIImage am_imageNamed:@"edit"] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:editBtn];
    [editBtn sizeToFit];
    [editBtn activateConstraints:@[
        editBtn.centerYAnchor.equalTo(bgView.centerYAnchor),
        editBtn.rightAnchor.equalTo(bgView.rightAnchor).offset(-20),
        editBtn.widthAnchor.equalToValue(25),
        editBtn.heightAnchor.equalTo(editBtn.widthAnchor),
    ]];
    
    __weak __typeof(&*self) weakSelf  = self;
    UIView *accountView = [self createImgLabelView:@"account" callback:^(UILabel *label) {
        weakSelf.accountLabel = label;
    }];
    [bgView addSubview:accountView];
    [accountView activateConstraints:@[
        accountView.topAnchor.equalTo(titleLabel.bottomAnchor).offset(5),
        accountView.leftAnchor.equalTo(titleLabel.leftAnchor),
        accountView.rightAnchor.equalTo(editBtn.leftAnchor).offset(-5),
        accountView.heightAnchor.equalToValue(18),
    ]];
    
    UIView *passwordView = [self createImgLabelView:@"password" callback:^(UILabel *label) {
        weakSelf.passwordLabel = label;
    }];
    [bgView addSubview:passwordView];
    [passwordView activateConstraints:@[
        passwordView.topAnchor.equalTo(accountView.bottomAnchor).offset(5),
        passwordView.leftAnchor.equalTo(accountView.leftAnchor),
        passwordView.rightAnchor.equalTo(editBtn.leftAnchor).offset(-5),
        passwordView.heightAnchor.equalToValue(18),
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

- (void)editBtnClicked {
    if (self.editCallback) {
        self.editCallback();
    }
}

@end
