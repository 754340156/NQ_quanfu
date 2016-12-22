//
//  ConpanyInformationView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/28.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ConpanyInformationView.h"

@interface ConpanyInformationView ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
#pragma mark - 按钮
//普通执照
@property (weak, nonatomic) IBOutlet QButton *normalLicenseBtn;
//三证合一
@property (weak, nonatomic) IBOutlet QButton *ThreeInOneBtn;
//成立日期
@property (weak, nonatomic) IBOutlet UIButton *createTimeBtn;
//营业期限
@property (weak, nonatomic) IBOutlet UIButton *businessTimeBtn;
//大陆身份证
@property (weak, nonatomic) IBOutlet QButton *mainlandIDBtn;
//非大陆身份证
@property (weak, nonatomic) IBOutlet QButton *noMainlandIDBtn;
//组织机构代码证有效期
@property (weak, nonatomic) IBOutlet UIButton *institutionalTimeBtn;
//下一步
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

#pragma mark - 输入框
//公司名称
@property (weak, nonatomic) IBOutlet UITextField *conpanyNameTF;
//营业执照注册号
@property (weak, nonatomic) IBOutlet UITextField *registNumTF;
//法定代表人姓名
@property (weak, nonatomic) IBOutlet UITextField *representativeTF;
//营业执照详细地址
@property (weak, nonatomic) IBOutlet UITextField *licenseAddressTF;
//注册资金
@property (weak, nonatomic) IBOutlet UITextField *registMoneyTF;
//公司详细地址
@property (weak, nonatomic) IBOutlet UITextField *conpanyAddressTF;
//公司电话
@property (weak, nonatomic) IBOutlet UITextField *conpanyPhoneTF;
//紧急联系人
@property (weak, nonatomic) IBOutlet UITextField *contactTF;
//紧急联系人手机
@property (weak, nonatomic) IBOutlet UITextField *contactPhoneTF;
//法人身份证号
@property (weak, nonatomic) IBOutlet UITextField *IDCardTF;
//组织机构代码
@property (weak, nonatomic) IBOutlet UITextField *institutionalTF;
#pragma mark - 时间显示label
//成立日期
@property (weak, nonatomic) IBOutlet UILabel *CreateTimeLabel;
//营业期限
@property (weak, nonatomic) IBOutlet UILabel *BusinessTimeLabel;
//组织机构代码证有效期
@property (weak, nonatomic) IBOutlet UILabel *institutionalTimeLabel;

@end


@implementation ConpanyInformationView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
    [self setLayout];
}

#pragma mark - setup
- (void)setup
{
    self.scrollView.backgroundColor = QFColor_CoodsClassMenuViewBg;
    self.nextButton.backgroundColor = QF_RedColor;
    //设置按钮图片文字
    [self setButtonImage];
}
- (void)setLayout
{
    
}
#pragma mark - custom method
- (void)setButtonImage
{
    [self setQButtonWithButton:self.normalLicenseBtn Title:@"普通执照"];
    [self setQButtonWithButton:self.ThreeInOneBtn Title:@"三证合一"];
    self.ThreeInOneBtn.selected = YES;
    [self setQButtonWithButton:self.mainlandIDBtn Title:@"大陆身份证"];
    [self setQButtonWithButton:self.noMainlandIDBtn Title:@"非大陆证件"];
    self.noMainlandIDBtn.selected = YES;
    [self.createTimeBtn setImage:Image(@"rili") forState:UIControlStateNormal];
    [self.businessTimeBtn setImage:Image(@"rili") forState:UIControlStateNormal];
    [self.institutionalTimeBtn setImage:Image(@"rili") forState:UIControlStateNormal];
    [self.licenseBtn setImage:Image(@"shangchuantupian") forState:UIControlStateNormal];
    [self.openAccountBtn setImage:Image(@"shangchuantupian") forState:UIControlStateNormal];
    [self.institutionalBtn setImage:Image(@"shangchuantupian") forState:UIControlStateNormal];
}
- (void)setQButtonWithButton:(QButton *)button Title:(NSString *)title
{
    button.space = 10.0f;
    [button setImage:Image(@"weixuanze_yuan") forState:UIControlStateNormal];
    [button setImage:Image(@"xuanze_yuan") forState:UIControlStateSelected];
    [button setTitleColor:QF_BlackColor forState:UIControlStateNormal];
    [button setTitleColor:QF_BlackColor forState:UIControlStateSelected];
    button.style = QButtonStyleNormal;
    [button setTitle:title forState:UIControlStateNormal];
}
#pragma mark - handle action
//下一步
- (IBAction)NextAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ConpanyInformationViewDelegate_clickNext)]) {
        [self.delegate ConpanyInformationViewDelegate_clickNext];
    }
}
- (IBAction)NormalAction:(QButton *)sender
{
    self.ThreeInOneBtn.selected = NO;
    self.normalLicenseBtn.selected = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(ConpanyInformationViewDelegate_clickTypeWithLicenseType:IDType:)]) {
        [self.delegate ConpanyInformationViewDelegate_clickTypeWithLicenseType:LicenseTypeNormalLicense IDType:0];
    }
}
- (IBAction)ThreeInOneBtnAction:(QButton *)sender
{
    self.normalLicenseBtn.selected = NO;
    self.ThreeInOneBtn.selected = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(ConpanyInformationViewDelegate_clickTypeWithLicenseType:IDType:)]) {
        [self.delegate ConpanyInformationViewDelegate_clickTypeWithLicenseType:LicenseTypeThreeInOne IDType:0];
    }
}
//成立日期
- (IBAction)CreateTimeAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ConpanyInformationViewDelegate_clickTimeWithLabel:)]) {
        [self.delegate ConpanyInformationViewDelegate_clickTimeWithLabel:self.CreateTimeLabel];
    }
}
//营业期限
- (IBAction)TimeLimitAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ConpanyInformationViewDelegate_clickTimeWithLabel:)]) {
        [self.delegate ConpanyInformationViewDelegate_clickTimeWithLabel:self.BusinessTimeLabel];
    }
}
- (IBAction)MainlandIDAction:(QButton *)sender
{
    self.noMainlandIDBtn.selected = NO;
    self.mainlandIDBtn.selected = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(ConpanyInformationViewDelegate_clickTypeWithLicenseType:IDType:)]) {
        [self.delegate ConpanyInformationViewDelegate_clickTypeWithLicenseType:0 IDType:IDTypeMainland];
    }
}
- (IBAction)NoMainlandIDAction:(QButton *)sender
{
    self.mainlandIDBtn.selected = NO;
    self.noMainlandIDBtn.selected = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(ConpanyInformationViewDelegate_clickTypeWithLicenseType:IDType:)]) {
        [self.delegate ConpanyInformationViewDelegate_clickTypeWithLicenseType:0 IDType:IDTypeNoMainland];
    }
}
//上传照片
- (IBAction)PhotosAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ConpanyInformationViewDelegate_clickPhotosWithButton:)]) {
        [self.delegate ConpanyInformationViewDelegate_clickPhotosWithButton:sender];
    }
}
//组织机构代码证有效期
- (IBAction)ExpiryDateAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ConpanyInformationViewDelegate_clickTimeWithLabel:)]) {
        [self.delegate ConpanyInformationViewDelegate_clickTimeWithLabel:self.institutionalTimeLabel];
    }
}


#pragma mark - setter model


@end
