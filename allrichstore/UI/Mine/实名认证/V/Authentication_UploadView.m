//
//  Authentication_UploadView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/9.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "Authentication_UploadView.h"
#define kPhotoBtnH 215.0f
#define kBacKViewH 550.0f
#define kLabelH 20.0f

@interface Authentication_UploadView ()
/**  titleLabel */
@property(nonatomic,strong) UILabel * titleLabel;
/**  backView */
@property(nonatomic,strong) UIView * backView;
/**  backeView2 */
@property(nonatomic,strong) UIView * backView2;
/**  确认上传 */
@property(nonatomic,strong) UIButton * sureButton;
@end

@implementation Authentication_UploadView

- (instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupWithSuperView:superView];
        [self setLayout];
    }
    return self;
}
#pragma mark - setup
- (void)setupWithSuperView:(UIView *)superView
{
    self.backView = [[UIView alloc] init];
    self.backView.backgroundColor = kWhiteColor;
    [self addSubview:self.backView];
    
    self.backView2 = [[UIView alloc] init];
    self.backView2.backgroundColor = kWhiteColor;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ruleAction)];
    [self.backView2 addGestureRecognizer:tap];
    [self addSubview:self.backView2];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = Font_Mid;
    self.titleLabel.textColor =QF_BlackColor;
    [self.titleLabel sizeToFit];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.backView addSubview:self.titleLabel];
    
    self.frontButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.frontButton setImage:Image(@"shangchuantupian") forState:UIControlStateNormal];
    [self.frontButton addTarget:self action:@selector(photosAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.frontButton];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setImage:Image(@"shangchuantupian") forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(photosAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.backButton];
    
    self.sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sureButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.sureButton setBackgroundImage:[UIImage imageWithColor:kRedColor] forState:UIControlStateNormal];
    [self.sureButton setBackgroundImage:[UIImage imageWithColor:kGrayColor] forState:UIControlStateDisabled];
    [self.sureButton setTitle:String(@"确认上传") forState:UIControlStateNormal];
    [superView addSubview:self.sureButton];
}
- (void)setLayout
{
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(kScreenW);
        make.left.right.top.offset(0);
        make.height.offset(Adapted(kBacKViewH));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_top).offset(Adapted(kMargin));
        make.centerX.equalTo(self.backView.mas_centerX);
        make.height.offset(Adapted(kLabelH));
    }];
    
    [self.frontButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(Adapted(kMargin));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(Adapted(kMargin));
        make.right.equalTo(self.backView.mas_right).offset(Adapted(-kMargin));
        make.height.offset(Adapted(kPhotoBtnH));
    }];
    
    UILabel *label1 = [[UILabel alloc] init];
    [self setLabelWithLabel:label1 Text:String(@"上传身份证正面")];
    [self.backView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView.mas_centerX);
        make.top.equalTo(self.frontButton.mas_bottom).offset(Adapted(kMargin));
        make.height.offset(Adapted(kLabelH));
    }];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(Adapted(kMargin));
        make.top.equalTo(label1.mas_bottom).offset(Adapted(kMargin));
        make.right.equalTo(self.backView.mas_right).offset(Adapted(-kMargin));
        make.height.offset(Adapted(kPhotoBtnH));
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    [self setLabelWithLabel:label2 Text:String(@"上传身份证反面")];
    [self.backView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView.mas_centerX);
        make.top.equalTo(self.backButton.mas_bottom).offset(Adapted(kMargin));
        make.height.offset(Adapted(kLabelH));
    }];
    
    UILabel *label3 =[[UILabel alloc] init];
    [self setLabelWithLabel:label3 Text:String(@"请拍摄身份证原件")];
    [self.backView2 addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView2.mas_centerY);
        make.left.offset(Adapted(kMargin));
        make.width.offset(Adapted(130));
    }];
    
    UILabel *label4 =[[UILabel alloc] init];
    label4.textAlignment = NSTextAlignmentRight;
    label4.text = String(@"查看照片要求 >");
    label4.font = Font_Min;
    [label4 sizeToFit];
    label4.textColor = QF_GrayColor;
    [self.backView2 addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView2.mas_centerY);
        make.right.offset(Adapted(-kMargin));
    }];
    
    [self.backView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_bottom).offset(Adapted(kMargin));
        make.left.right.offset(0);
        make.bottom.offset(Adapted(-kMargin * 2));
        make.height.offset(kBottomH);
    }];
    
    
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(kBottomH);
    }];
}
#pragma mark - custom method
- (void)setLabelWithLabel:(UILabel *)label Text:(NSString *)text
{
    label.text = text;
    label.font = Font_Mid;
    [label sizeToFit];
    label.textColor = kBlackColor;
}
- (BOOL)judgeWithButton:(UIButton *)sender image:(UIImage *)image
{
    if ([sender.currentImage isEqual:image]) {
        [Tools showToastMsg:String(@"请上传完整照片")];
        return NO;
    }
    return YES;
}
#pragma mark - handle action
//点击上传图片
- (void)photosAction:(UIButton *)sender
{
    if (self.Au_delegate && [self.Au_delegate respondsToSelector:@selector(Authentication_UploadViewDelegate_clickPhotosBtnWithButton:)]) {
        [self.Au_delegate Authentication_UploadViewDelegate_clickPhotosBtnWithButton:sender];
    }
}
//点击查看拍照要求
- (void)ruleAction
{
    
}
//点击确认上传
- (void)sureAction
{
    if (![self judgeWithButton:self.frontButton image:Image(@"shangchuantupian")]) return;
    if (![self judgeWithButton:self.backButton image:Image(@"shangchuantupian")]) return;
    if (self.Au_delegate && [self.Au_delegate respondsToSelector:@selector(Authentication_UploadViewDelegate_clickSureButton)]) {
        [self.Au_delegate Authentication_UploadViewDelegate_clickSureButton];
    }
}
#pragma mark - setter model
- (void)setName:(NSString *)name
{
    _name = name;
    self.titleLabel.text = [NSString stringWithFormat:String(@"请上传%@的身份证正反面"),name];
}
@end
