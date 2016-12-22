//
//  RefundDetailApplyTypeView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/17.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "RefundDetailApplyTypeView.h"
#import "RefundDetailApplyModel.h"
#define kLabelH 20.0f
#define kButtonW 80.0f
#define kButtonH 30.0f
@interface RefundDetailApplyTypeView ()
/**  TagBtnsView. */
@property(nonatomic,strong) TagBtnsView * tagView;
@end

@implementation RefundDetailApplyTypeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        [self setup];
        [self setLayout];
    }
    return self;
}
#pragma mark - setup
- (void)setup
{

}
- (void)setLayout
{
    
}
#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model
- (void)setModel:(RefundDetailApplyModel *)model
{
    _model = model;
    
    self.tagView = [[TagBtnsView alloc] initWithFrame:CGRectMake(0, 0, kScreenW - Adapted(kMargin), 0) btnLayoutStyle:QButtonLayoutStyleNone title:@"服务类型" allArray:model.typeArray selectedArray:@[model.typeArray[0]] btnCountALine:4 normalImage:nil selectedImage:nil titleAndImageSpace:0 isMuti:NO configureBlcok:^(TagBtnsView *tagBtnsView) {
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
        if (self.clickTypeBlock) {
            self.clickTypeBlock(stringArray[0]);
        }
    }];
    self.tagView.titleLabel.textColor = QF_BlackColor;
    self.tagView.titleLabel.font = Font_Mid;
    [self addSubview:self.tagView];
    
    model.typeHeight = self.tagView.height + Adapted(kMargin);
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.offset(0);
        make.top.offset(Adapted(kMargin));
        make.right.offset(Adapted(-kMargin));
    }];

}

@end
