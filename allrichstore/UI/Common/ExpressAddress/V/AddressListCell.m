//
//  AddressListCell.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/22.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "AddressListCell.h"     //我的收货地址列表cell

#define kMargin_level      Adapted(12) //水平边距
#define kMargin_top        Adapted(12) //上边距
#define kMargin_bottom     Adapted(12) //下边距
#define kSpace_vertical    Adapted(12) //垂直间距

@interface AddressListCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *telLabel;
@property (nonatomic, strong) UILabel *addressLabel;

@end

@implementation AddressListCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.bottomMargin = 0;
    self.isHaveSeleBgView = NO;
    self.contentView.backgroundColor = kWhiteColor;
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.telLabel];
    [self.contentView addSubview:self.addressLabel];
}

//布局子视图
- (void)layoutViews
{
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(kMargin_level);
        make.width.offset(Adapted(120));
        make.top.offset(kMargin_top);
        make.height.offset([_nameLabel getHeight]);
    }];
    
    [_telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-kMargin_level);
        make.left.equalTo(_nameLabel.mas_right).offset(Adapted(10));
        make.top.offset(kMargin_top);
        make.height.offset([_telLabel getHeight]);
    }];
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_nameLabel.mas_bottom).offset(kSpace_vertical);
        make.left.offset(kMargin_level);
        make.right.offset(-kMargin_level);
        make.bottom.offset(-kMargin_bottom);
    }];
}

#pragma mark - lazy
//收货人姓名label
- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        self.nameLabel = [UILabel new];
        _nameLabel.textColor = QF_BlackColor;
        _nameLabel.font = AdaptedFont(17);
    }
    return _nameLabel;
}

//收货人联系电话label
- (UILabel *)telLabel
{
    if (!_telLabel)
    {
        self.telLabel = [UILabel new];
        _telLabel.textColor = QF_BlackColor;
        _telLabel.font = AdaptedFont(17);
        _telLabel.textAlignment = NSTextAlignmentRight;
    }
    return _telLabel;
}

//收货地址label
- (UILabel *)addressLabel
{
    if (!_addressLabel)
    {
        self.addressLabel = [UILabel new];
        _addressLabel.textColor = QF_BlackColor;
        _addressLabel.font = AdaptedFont(16);
        _addressLabel.numberOfLines = 0;
    }
    return _addressLabel;
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model
- (void)setModel:(AddressListModel *)model
{
    _model = model;
    _nameLabel.text = model.name;
    _telLabel.text = model.tel;
    NSMutableAttributedString *muAddressString = [NSMutableAttributedString new];
    NSAttributedString *addressString = [NSAttributedString attributedStringWithString:model.addressText color:QF_BlackColor font:_addressLabel.font];
    if (_model.isDefault)
    {
        NSAttributedString *headerString = [NSAttributedString attributedStringWithString:String(@"[默认地址]") color:QF_RedColor font:_addressLabel.font];
        [muAddressString appendAttributedString:headerString];
        
    }
    
    [muAddressString appendAttributedString:addressString];
    _addressLabel.attributedText = muAddressString;
}


@end
