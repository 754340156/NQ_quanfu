//
//  GoodGobBackTypeView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/30.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "GoodGobBackTypeView.h"

@interface GoodGobBackTypeView ()
/**  tagView */
@property(nonatomic,strong) TagBtnsView * tagView;
/**  联系人 */
@property(nonatomic,strong) UITextField * contactTF;
/**  联系方式 */
@property(nonatomic,strong) UITextField * phoneTF;
/**  submit */
@property(nonatomic,strong) UIButton * submitBtn;
/**  记录选中的type */
@property(nonatomic,strong) NSString * currentType;
@end

@implementation GoodGobBackTypeView
- (instancetype)initWithFrame:(CGRect)frame  Contact:(NSString *)contact Phone:(NSString *)phone GobackTypeArray:(NSArray *)gobackTypeArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = QFColor_CoodsClassMenuViewBg;
        [self setupWithContact:contact Phone:phone GobackTypeArray:gobackTypeArray];
        [self setLayout];
    }
    return self;
}
#pragma mark - setup
- (void)setupWithContact:(NSString *)contact Phone:(NSString *)phone GobackTypeArray:(NSArray *)gobackTypeArray
{
    UIView *backView1 = [[UIView alloc] init];
    backView1.backgroundColor = kWhiteColor;
    [self addSubview:backView1];
    
    self.tagView = [[TagBtnsView alloc] initWithFrame:CGRectMake(0, 0, kScreenW - Adapted(kMargin), 0) title:@"商品退回方式" allArray:gobackTypeArray selectedArray:@[gobackTypeArray[0]]  isMuti:NO configureBlcok:^(TagBtnsView *tagBtnsView) {
        tagBtnsView.isSameWidth = YES;
        tagBtnsView.btnTitleSeletedColor = QF_RedColor;
        tagBtnsView.btnBorderWidth = Layout_borderWidth;
        tagBtnsView.btnCornerRadius = Layout_cornerRadius;
        tagBtnsView.btnNormalBgColor = QFColor_BaseVCViewBg;
        tagBtnsView.btnSelectedBgColor = kWhiteColor;
        tagBtnsView.btnSelectedBorderColor = QF_RedColor;
        tagBtnsView.titleLabelHeight = Adapted(20);
        tagBtnsView.btnsHeight = Adapted(30);
        tagBtnsView.space_vertical_title_Btn = Adapted(kMargin);
        tagBtnsView.btnTitleFont = AdaptedFont(13);
        tagBtnsView.margin_level = Adapted(kMargin);
    } selectedBlock:^(NSArray *stringArray, NSInteger index) {
        self.currentType = stringArray[0];
    }];
    
    self.tagView.titleLabel.textColor = QF_BlackColor;
    self.tagView.titleLabel.font = Font_Mid;
    [backView1 addSubview:self.tagView];
    
    [backView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.offset(self.tagView.height + Adapted(kMargin));
    }];
    
    UIView *backView2 = [[UIView alloc] init];
    backView2.backgroundColor = kWhiteColor;
    [backView2 addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
    [self addSubview:backView2];
    [backView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView1.mas_bottom).offset(Adapted(kMargin / 2));
        make.left.right.offset(0);
        make.height.offset(Adapted(kBottomH));
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.font = Font_Mid;
    label2.textColor = QF_BlackColor;
    label2.text = @"联系人";
    [label2 sizeToFit];
    [backView2 addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(Adapted(kMargin));
        make.centerY.offset(0);
        make.width.offset(Adapted(80));
    }];
    
    self.contactTF = [[UITextField alloc] init];
    self.contactTF.textColor = QF_BlackColor;
    self.contactTF.text = contact;
    self.contactTF.font = Font_Mid;
    [backView2 addSubview:self.contactTF];
    [self.contactTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label2.mas_right).offset(Adapted(kMargin));
        make.centerY.offset(0);
        make.right.offset(Adapted(-kMargin));
    }];
    
    UIView *backView3 = [[UIView alloc] init];
    backView3.backgroundColor = kWhiteColor;
    [backView3 addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
    [self addSubview:backView3];
    [backView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView2.mas_bottom);
        make.left.right.offset(0);
        make.height.offset(Adapted(kBottomH));
    }];
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.font = Font_Mid;
    label3.textColor = QF_BlackColor;
    label3.text = @"联系方式";
    [label3 sizeToFit];
    [backView3 addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(Adapted(kMargin));
        make.centerY.offset(0);
        make.width.offset(Adapted(80));
    }];
    
    self.phoneTF = [[UITextField alloc] init];
    self.phoneTF.textColor = QF_BlackColor;
    self.phoneTF.text = phone;
    self.phoneTF.font = Font_Mid;
    [backView3 addSubview:self.phoneTF];
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label3.mas_right).offset(Adapted(kMargin));
        make.centerY.offset(0);
        make.right.offset(Adapted(-kMargin));
    }];
    
    self.submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.submitBtn.titleLabel.font = Font(18);
    [self.submitBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.submitBtn setBackgroundColor:QF_RedColor];
    [self.submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.submitBtn];
}
- (void)setLayout
{
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.offset(0);
        make.top.offset(Adapted(kMargin));
        make.right.offset(Adapted(-kMargin));
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(kBottomH);
    }];
}
#pragma mark - custom method


#pragma mark - handle action
- (void)submitAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(GoodGobBackTypeViewDelegate_clickSubmitWithPerson:Phone:type:)]) {
        [self.delegate GoodGobBackTypeViewDelegate_clickSubmitWithPerson:self.contactTF.text Phone:self.phoneTF.text type:self.currentType];
    }
}
#pragma mark - setter model

@end
