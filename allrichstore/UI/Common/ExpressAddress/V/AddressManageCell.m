//
//  AddressManageCell.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/22.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "AddressManageCell.h"   //收货地址管理cell

#define kMargin_level      Adapted(12) //水平边距
#define kMargin_top        Adapted(12) //上边距
#define kMargin_bottom     Adapted(12) //下边距
#define kSpace_vertical    Adapted(12) //垂直间距

@interface AddressManageCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *telLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIView *btnBarView;
@property (nonatomic, strong) QButton *isDefalutBtn;
@property (nonatomic, strong) QButton *editBtn;
@property (nonatomic, strong) QButton *deleteBtn;

@end

@implementation AddressManageCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.isHaveSeleBgView = NO;
    self.contentView.backgroundColor = kWhiteColor;
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.telLabel];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.btnBarView];
    [_btnBarView addSubview:self.isDefalutBtn];
    [_btnBarView addSubview:self.editBtn];
    [_btnBarView addSubview:self.deleteBtn];
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
//        make.bottom.offset(-kMargin_bottom);
    }];
    
    [_btnBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_addressLabel.mas_bottom).offset(kSpace_vertical);
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(40);
        make.bottom.offset(0);
    }];
    
    [_isDefalutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(0);
        make.top.offset(0);
        make.bottom.offset(0);
        make.width.offset(Adapted(100));
        
    }];
    
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.offset(0);
        make.top.offset(0);
        make.bottom.offset(0);
        make.width.offset(_editBtn.minSize.width + Adapted(10));
        make.right.offset(-kMargin_level);
    }];
    
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.offset(0);
        make.top.offset(0);
        make.bottom.offset(0);
        make.width.offset(_deleteBtn.minSize.width + Adapted(10));
        make.right.equalTo(_editBtn.mas_left).offset(Adapted(0));
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

//底部放btn的bar
- (UIView *)btnBarView
{
    if (!_btnBarView)
    {
        self.btnBarView = [UIView new];
        [_btnBarView addTopLineWithHeight:0.7];
    }
    return _btnBarView;
}

//是否设置为默认收货地址按钮
- (QButton *)isDefalutBtn
{
    if (!_isDefalutBtn)
    {
        self.isDefalutBtn = [[QButton alloc] initWithFrame:CGRectZero style:QButtonStyleNormal layoutStyle:QButtonLayoutStyleLeft font:AdaptedFont(15) title:String(@"设为默认") image:Image(@"xuanze_weixuan") space:Adapted(3) margin:kMargin_level autoSize:NO];
        [_isDefalutBtn setImage:Image(@"xuanze_yixuan") forState:UIControlStateSelected];
        [_isDefalutBtn setTitleColor:QF_RedColor forState:UIControlStateSelected];
        [_isDefalutBtn addTarget:self action:@selector(handleIsDefalutBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _isDefalutBtn;
}

//编辑按钮
- (QButton *)editBtn
{
    if (!_editBtn)
    {
        self.editBtn = [[QButton alloc] initWithFrame:CGRectZero style:QButtonStyleNormal layoutStyle:QButtonLayoutStyleNone font:AdaptedFont(15) title:String(@"编辑") image:Image(@"addressEdit") space:Adapted(3) margin:kMargin_level autoSize:NO];
        [_editBtn addTarget:self action:@selector(handleEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}

//删除按钮
- (QButton *)deleteBtn
{
    if (!_deleteBtn)
    {
        self.deleteBtn = [[QButton alloc] initWithFrame:CGRectZero style:QButtonStyleNormal layoutStyle:QButtonLayoutStyleNone font:AdaptedFont(15) title:String(@"删除") image:Image(@"addressDelegate") space:Adapted(3) margin:kMargin_level autoSize:NO];
        [_deleteBtn addTarget:self action:@selector(handleDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

#pragma mark - custom method

#pragma mark - handle action
//设置为默认按钮 -- 触发事件
- (void)handleIsDefalutBtn:(UIButton *)sender
{
    [self.delegate addressManageCell:self didseletedBtn:sender actionType:ActionTypeSelect];
}

//编辑按钮 -- 触发事件
- (void)handleEditBtn:(UIButton *)sender
{
    [self.delegate addressManageCell:self didseletedBtn:sender actionType:ActionTypeEdit];
}

//删除按钮 -- 触发事件
- (void)handleDeleteBtn:(UIButton *)sender
{
    [self.delegate addressManageCell:self didseletedBtn:sender actionType:ActionTypeDelete];
}

#pragma mark - setter model
- (void)setModel:(AddressListModel *)model
{
    _model = model;
    _nameLabel.text = model.name;
    _telLabel.text = model.tel;
    NSAttributedString *addressString = [NSAttributedString attributedStringWithString:model.addressText color:QF_BlackColor font:_addressLabel.font];
    _addressLabel.attributedText = addressString;
    if (_model.isDefault)
    {
        self.isDefalutBtn.selected = YES;
    }
    else
    {
        self.isDefalutBtn.selected = NO;
    }
    
}

@end
