//
//  GoodsDetailChooseView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/17.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "GoodsDetailChooseView.h"
#import "DKFilterView.h"
#import "ChooseModel.h"
#import "PPNumberButton.h"
#define kImageViewSize CGSizeMake(Adapted(130), Adapted(100))

#define kSureBtnH 45.0f
@interface GoodsDetailChooseView ()<DKFilterViewDelegate>
/**  image */
@property(nonatomic,strong) UIImageView * goodImageV;
/**  title */
@property(nonatomic,strong) UILabel * titleLabel;
/**  单选框 */
@property(nonatomic,strong) DKFilterView * filterView;
/**  确定按钮 */
@property(nonatomic,strong) UIButton * sureButton;


/**  按钮模型 */
@property (nonatomic,strong) DKFilterModel *clickModel;
/**  记录的model */
@property(nonatomic,strong) ChooseModel * model;
/**  记录选中的model传出 */
@property(nonatomic,strong) NSMutableArray <ChooseModelProperty *>* modelArray;
/**  加减控件 */
@property(nonatomic,strong) PPNumberButton * numberBtn;
@end

@implementation GoodsDetailChooseView
- (void)setChooseModelWithModel:(ChooseModel *)model
{
    self.model= model;
    [self setupWithModelArray:model.property];
    [self setLayout];
}
#pragma mark - setup
- (void)setupWithModelArray:(NSArray <ChooseModelProperty *>*)modelArray
{
    self.goodImageV  = [[UIImageView alloc] init];
    [self.goodImageV sd_setImageWithURL:[NSURL URLWithString:self.model.goodimage[0].g_imgurl] placeholderImage:Image_PlaceHolder_Banner];
    [self addSubview:self.goodImageV];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = Font_Mid;
    self.titleLabel.textColor = QF_BlackColor;
    self.titleLabel.numberOfLines = 0;
    [self.titleLabel sizeToFit];
    self.titleLabel.text = self.model.title;
    [self addSubview:self.titleLabel];
    
    self.filterView = [[DKFilterView alloc] initWithFrame:self.bounds];
    self.filterView.delegate = self;
    [self addSubview:self.filterView];
    NSMutableArray * filterModels = [NSMutableArray array];
    for (ChooseModelProperty *model in modelArray) {
        DKFilterModel *filterModel = [[DKFilterModel alloc] initElement:model.buttonsArray ofType:DK_SELECTION_SINGLE];
        filterModel.title = model.gpv_property;
        filterModel.style = DKFilterViewDefault;
        [filterModels addObject:filterModel];
    }
    [self.filterView setFilterModels:filterModels];

    self.sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sureButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sureButton setBackgroundColor:QF_RedColor];
    [self addSubview:self.sureButton];
    
    self.numberBtn = [PPNumberButton numberButtonWithFrame:CGRectZero];
    self.numberBtn.backgroundColor = QFColor_CoodsClassMenuViewBg;
    self.numberBtn.increaseTitle = @"+";
    self.numberBtn.decreaseTitle = @"-";
    self.numberBtn.buttonTitleFont = Adapted(14);
    self.numberBtn.inputFieldFont = Adapted(11);
    self.numberBtn.minValue = 1;
#warning 库存没给
//    self.numberBtn.maxValue =
    self.numberBtn.numberBlock = ^(NSString *num){
        NSLog(@"%@",num);
    };
    [self addSubview:self.numberBtn];

}
- (void)setLayout
{
    [self.goodImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(Adapted(-kMargin * 3));
        make.left.offset(Adapted(kMargin));
        make.size.mas_offset(kImageViewSize);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodImageV.mas_right).offset(Adapted(kMargin));
        make.top.offset(Adapted(kMargin));
        make.right.offset(Adapted(-kMargin));
    }];
    
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(Adapted(kSureBtnH));
    }];
    
    UILabel *numbertitle = [[UILabel alloc] init];
    numbertitle.text = @"购买数量";
    numbertitle.textColor = QF_BlackColor;
    numbertitle.font = Font_Mid;
    [numbertitle sizeToFit];
    [self addSubview:numbertitle];
    [numbertitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.sureButton.mas_top).offset(Adapted(-30));
        make.left.equalTo(self.goodImageV.mas_left);
        make.height.offset(Adapted(30));
    }];
    
    [self.numberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(Adapted(-kMargin));
        make.top.equalTo(numbertitle.mas_top);
        make.size.mas_offset(CGSizeMake(Adapted(110), Adapted(30)));
    }];
    
    [self.filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodImageV.mas_bottom).offset(Adapted(kMargin));
        make.left.equalTo(self.goodImageV.mas_left);
        make.bottom.equalTo(numbertitle.mas_top);
        make.right.offset(Adapted(kMargin));
    }];
}
#pragma mark - custom method

#pragma mark - handle action
- (void)sureAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(GoodsDetailChooseViewDelegate_clickSureActionWithArray:)]) {
        [self.delegate GoodsDetailChooseViewDelegate_clickSureActionWithArray:self.modelArray];
    }
}
#pragma mark - DKFilterViewDelegate
- (void)didClickAtModel:(DKFilterModel *)data
{
    WS(weakSelf)
    if (self.modelArray.count) {
         [self.modelArray enumerateObjectsUsingBlock:^(ChooseModelProperty * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
             if ([data.title isEqualToString:obj.gpv_property]) {
                 obj.buttonsArray = @[data.clickedButtonText];
             }else
             {
                 ChooseModelProperty *model = [[ChooseModelProperty alloc] init];
                 model.gpv_property = data.title;
                 model.buttonsArray =@[data.clickedButtonText];
                 [weakSelf.modelArray addObject:model];
             }
         }];
    }else
    {
        ChooseModelProperty *model = [[ChooseModelProperty alloc] init];
        model.gpv_property = data.title;
        model.buttonsArray = @[data.clickedButtonText];
        [self.modelArray addObject:model];
    }
}
#pragma mark - setter model
- (ChooseModel *)model
{
    if (!_model) {
        _model = [ChooseModel new];
    }
    return _model;
}
#pragma mark - lazy
- (NSMutableArray<ChooseModelProperty *> *)modelArray
{
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return  _modelArray;
}
@end
