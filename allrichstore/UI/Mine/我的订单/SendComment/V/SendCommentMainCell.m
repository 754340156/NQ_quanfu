//
//  SendCommentMainCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/14.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "SendCommentMainCell.h"
#import "SendCommentStarView.h"
#import "SendCommentModel.h"

@interface SendCommentMainCell ()<ButtonsViewDelegate>
/**  商品图 */
@property(nonatomic,strong) UIImageView * iconImageV;
/**  发表评论 */
@property(nonatomic,strong) UITextView * commentTextV;
/**  评级等级 */
@property(nonatomic,strong) ButtonsView * buttonView;
/**  星星等级 */
@property(nonatomic,strong) SendCommentStarView * starView;
/**  记录当前点击的星等 */
@property(nonatomic,assign) NSInteger count;
/**  评论切图 */
@property(nonatomic,strong) NSArray * buttonSImageArray;
/**  评论选中切图 */
@property(nonatomic,strong) NSArray * buttonSeletedImageArray;
@end

@implementation SendCommentMainCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.iconImageV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconImageV];
    
    self.commentTextV = [[UITextView alloc] init];
    self.commentTextV.font = Font_Mid;
    [self.contentView addSubview:self.commentTextV];
    
    self.buttonView = [[ButtonsView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, Adapted(kButtonViewH)) btnTitles:@[String(@"好评"),String(@"中评"),String(@"差评")] titleColor:QF_GrayColor selectedColor:QF_RedColor titleFont:Font_Min];
    
    self.buttonView.backgroundColor = kWhiteColor;
    self.buttonView.delegate = self;
    for (NSInteger i = 0 ; i < self.buttonView.btns.count; i++) {
        QButton *button  = self.buttonView.btns[i];
        button.style = QButtonStyleImageTop;
        button.space = 2.0f;
        if (i)[button addLeftLineWithColor:Home_ListCell_Line_Color width:ListCell_Line_W_H style:LineLayoutStyleInside];
        [button setImage:Image(self.buttonSImageArray[i]) forState:UIControlStateNormal];
        [button setImage:Image(self.buttonSeletedImageArray[i]) forState:UIControlStateSelected];
    }
    [self.buttonView addTopLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
    [self.buttonView addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
    [self.contentView addSubview:self.buttonView];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = Adapted(kMargin);
    flowLayout.minimumInteritemSpacing = Adapted(kMargin);
    flowLayout.itemSize = CGSizeMake(Adapted(kItemWidth), Adapted(kItemHeight));
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = kWhiteColor;
    self.collectionView.bounces = NO;
    [self.contentView addSubview:self.collectionView];
    
    self.starView = [SendCommentStarView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
        if (self.clickStarBlock) {
             self.clickStarBlock(count);
        }
    }];
    self.starView.spacing = 0.2;
    [self.contentView addSubview:self.starView];
}
//布局子视图
- (void)layoutViews
{
    [self.iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(kImageSize);
        make.top.left.offset(Adapted(kMargin));
    }];
    
    [self.commentTextV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageV.mas_top);
        make.left.equalTo(self.iconImageV.mas_right).offset(Adapted(kMargin));
        make.right.offset(Adapted(-kMargin));
        make.bottom.equalTo(self.iconImageV.mas_bottom);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageV.mas_left);
        make.top.equalTo(self.iconImageV.mas_bottom).offset(Adapted(kMargin));
        make.size.mas_offset(CGSizeMake(Adapted(kItemWidth * singleLineCount + kMargin * (singleLineCount - 1)), Adapted(kItemHeight)));
    }];
    
    [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom).offset(Adapted(kMargin));
        make.left.right.offset(0);
        make.height.offset(Adapted(kButtonViewH));
    }];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.font = Font_Mid;
    titleLabel.textColor = QF_BlackColor;
    titleLabel.text = String(@"商品评价");
    [titleLabel sizeToFit];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(Adapted(kMargin));
        make.top.equalTo(self.buttonView.mas_bottom).offset(Adapted(kMargin));
        make.height.offset(Adapted(kStarViewH));
    }];
    
    [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.buttonView.mas_bottom);
        make.left.equalTo(titleLabel.mas_right).offset(Adapted(kMargin));
        make.size.mas_offset(CGSizeMake(Adapted(130), Adapted(kStarViewH + 2* kMargin)));
        make.bottom.offset(0);
    }];
}
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}
#pragma mark - custom method

#pragma mark - handle action
#pragma mark - ButtonsViewDelegate
- (void)btsView:(ButtonsView *)btnView IsClicked:(UIButton *)btn atIndex:(NSInteger)index isRepeatTouch:(BOOL)isRepeatTouch
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(SendCommentMainCellDelegate_clickButtonViewWithSendCommentMainCell:Index:)]) {
        [self.delegate SendCommentMainCellDelegate_clickButtonViewWithSendCommentMainCell:self Index:index];
    }
}
#pragma mark - setter model
- (void)setModel:(SendCommentShopModel *)model
{
    _model = model;
    self.iconImageV.image = ImageStr(model.cover);
#warning 重用没解决
    [self btsView:self.buttonView IsClicked:nil atIndex:model.evaluateLevel isRepeatTouch:YES];
    self.starView.starCount = model.evaluateStarLevel;
}
#pragma mark - lazy
- (NSArray *)buttonSImageArray
{
    if (!_buttonSImageArray) {
        _buttonSImageArray  = @[@"haoping copy",@"zhongping copy",@"chaping copy"];
    }
    return _buttonSImageArray;
}
- (NSArray *)buttonSeletedImageArray
{
    if (!_buttonSeletedImageArray) {
        _buttonSeletedImageArray  = @[@"haoping",@"zhongping",@"chaping"];
    }
    return _buttonSeletedImageArray;
}
@end
