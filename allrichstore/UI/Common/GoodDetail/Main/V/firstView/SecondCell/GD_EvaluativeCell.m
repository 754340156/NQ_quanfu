//
//  GD_EvaluativeCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/1.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "GD_EvaluativeCell.h"
#import "GoodsDetailModel.h"
#import "SendCommentStarView.h"
@interface GD_EvaluativeCell ()
/**  头像 */
@property(nonatomic,strong) UIImageView * iconImageV;
/**  昵称 */
@property(nonatomic,strong) UILabel * nickNameL;
/**  星等 */
@property(nonatomic,strong) SendCommentStarView * starView;
/**  评论 */
@property(nonatomic,strong) UILabel * commentLabel;
/**  评论带的三幅图 */
@property(nonatomic,strong) UIImageView * commentImageV1;
@property(nonatomic,strong) UIImageView * commentImageV2;
@property(nonatomic,strong) UIImageView * commentImageV3;
/**  颜色 */
@property(nonatomic,strong) UILabel * colorLabel;
/**  尺寸 */
@property(nonatomic,strong) UILabel * sizeLabel;
/**  点赞 */
@property(nonatomic,strong) QButton * likeButton;
/**  二级评论 */
@property(nonatomic,strong) QButton * secondCommentBtn;
@end


@implementation GD_EvaluativeCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.iconImageV = [[UIImageView alloc] init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickIconAction)];
    [self.iconImageV addGestureRecognizer:tap];
    [self.contentView addSubview:self.iconImageV];
    
    [self.timeLabel sizeToFit];
    self.timeLabel.textColor = QF_GrayColor;
    self.timeLabel.font = Font_Min;
    [self.contentView addSubview:self.timeLabel];
    
    self.nickNameL = [[UILabel alloc] init];
    [self.nickNameL sizeToFit];
    self.nickNameL.textColor = QF_BlackColor;
    self.nickNameL.font = Font_Mid;
    [self.contentView addSubview:self.nickNameL];
    
    self.starView = [SendCommentStarView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
        
    }];
    self.starView.spacing = 0.2;
    self.starView.tapEnabled = NO;
    [self.contentView addSubview:self.starView];
    
    self.commentLabel = [[UILabel alloc] init];
    self.commentLabel.font = Font_Mid;
    self.commentLabel.numberOfLines = 0;
    self.commentLabel.textColor = QF_BlackColor;
    [self.contentView addSubview:self.commentLabel];
    
    self.commentImageV1 = [[UIImageView alloc] init];
    [self.contentView addSubview:self.commentImageV1];
    
    self.commentImageV2 = [[UIImageView alloc] init];
    [self.contentView addSubview:self.commentImageV2];
    
    self.commentImageV3 = [[UIImageView alloc] init];
    [self.contentView addSubview:self.commentImageV3];
    
    self.colorLabel = [[UILabel alloc] init];
    self.colorLabel.textColor = QF_GrayColor;
    self.colorLabel.font = Font_Min;
    [self.contentView addSubview:self.colorLabel];
    
    self.sizeLabel = [[UILabel alloc] init];
    self.sizeLabel.font = Font_Min;
    self.sizeLabel.textColor = QF_GrayColor;
    [self.contentView addSubview:self.sizeLabel];
    
    self.likeButton = [[QButton alloc] initWithFrame:CGRectMake(0, 0, Adapted(50), Adapted(20)) style:QButtonStyleNormal font:Font_Min title:@"6" image:Image(@"dianzan") space:2 autoSize:NO];
    [self.likeButton setImage:Image(@"dianzan") forState:UIControlStateNormal];
    [self.likeButton setTitleColor:QF_GrayColor forState:UIControlStateNormal];
    [self.likeButton addTarget:self action:@selector(likeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.likeButton];
    
    self.secondCommentBtn = [[QButton alloc] initWithFrame:CGRectMake(0, 0, Adapted(50), Adapted(20)) style:QButtonStyleNormal font:Font_Min title:@"6" image:Image(@"pinglun") space:2 autoSize:NO];
    [self.secondCommentBtn setImage:Image(@"pinglun") forState:UIControlStateNormal];
    [self.secondCommentBtn setTitleColor:QF_GrayColor forState:UIControlStateNormal];
    [self.secondCommentBtn addTarget:self action:@selector(secondCommentAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.secondCommentBtn];

    [self.contentView addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
}

//布局子视图
- (void)layoutViews
{
    [self.iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(Adapted(kMargin));
        make.left.offset(Adapted(kMargin));
        make.size.mas_offset(CGSizeMake(Adapted(GD_EvaluativeIconH), Adapted(GD_EvaluativeIconH)));
    }];
    
    [self.nickNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageV.mas_right).offset(Adapted(kMargin));
        make.centerY.equalTo(self.iconImageV.mas_centerY);
        make.height.offset(Adapted(25));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nickNameL.mas_centerY);
        make.height.offset(Adapted(20));
        make.right.offset(Adapted(-kMargin));
    }];
    
    [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageV.mas_left);
        make.top.equalTo(self.iconImageV.mas_bottom);
        make.size.mas_offset(CGSizeMake(Adapted(130), Adapted(GD_EvaluativeStarH + kMargin * 2)));
    }];
    
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageV.mas_left);
        make.right.equalTo(self.timeLabel.mas_right);
        make.top.equalTo(self.starView.mas_bottom);
    }];
    
    CGFloat width = (kScreenW - Adapted(4 * GD_EvaluativeStarH)) / 3;
    CGFloat height = Adapted(GD_EvaluativePicH);
    [self.commentImageV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageV.mas_left);
        make.top.equalTo(self.commentLabel.mas_bottom).offset(Adapted(kMargin));
        make.size.mas_offset(CGSizeMake(width, height));
    }];
    
    [self.commentImageV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.commentImageV1.mas_right).offset(kMargin);
        make.top.equalTo(self.commentLabel.mas_bottom).offset(kMargin);
        make.size.mas_offset(CGSizeMake(width, height));
    }];
    
    [self.commentImageV3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.commentImageV2.mas_right).offset(Adapted(kMargin));
        make.top.equalTo(self.commentLabel.mas_bottom).offset(Adapted(kMargin));
        make.size.mas_offset(CGSizeMake(width, height));
    }];
    
    [self.colorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageV.mas_left);
        make.top.equalTo(self.commentImageV1.mas_bottom).offset(Adapted(kMargin));
        make.size.mas_offset(CGSizeMake(Adapted(70), Adapted(GD_EvaluativeColorH)));
        make.bottom.offset(Adapted(-kMargin));
    }];
    
    [self.sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.colorLabel.mas_right).offset(Adapted(kMargin));
        make.top.equalTo(self.colorLabel.mas_top);
        make.size.mas_offset(CGSizeMake(Adapted(70), Adapted(GD_EvaluativeColorH)));
    }];
    
    [self.secondCommentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(Adapted(-kMargin));
        make.centerY.equalTo(self.sizeLabel.mas_centerY);
        make.size.mas_offset(CGSizeMake(Adapted(50), Adapted(20)));
    }];
    
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.secondCommentBtn.mas_left).offset(Adapted(-kMargin));
        make.centerY.equalTo(self.sizeLabel.mas_centerY);
        make.size.mas_offset(CGSizeMake(Adapted(50), Adapted(20)));
    }];
}

#pragma mark - custom method
- (void)setImageWithPicArr:(NSArray <GoodsDetailImageModel*>*)picArr
{
    [self.commentImageV1 sd_setImageWithURL:[NSURL URLWithString:picArr[0].url] placeholderImage:Image_PlaceHolder_Banner] ;
    [self.commentImageV2 sd_setImageWithURL:[NSURL URLWithString:picArr[1].url] placeholderImage:Image_PlaceHolder_Banner];
    [self.commentImageV3 sd_setImageWithURL:[NSURL URLWithString:picArr[2].url] placeholderImage:Image_PlaceHolder_Banner];
}
#pragma mark - handle action
//点击头像
- (void)clickIconAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(GD_EvaluativeCellDelegate_clickIconWithModel:)]) {
        [self.delegate GD_EvaluativeCellDelegate_clickIconWithModel:self.model];
    }
}
//点赞
- (void)likeAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(GD_EvaluativeCellDelegate_clickLike)]) {
        [self.delegate GD_EvaluativeCellDelegate_clickLike];
    }
}
//二级评论
- (void)secondCommentAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(GD_EvaluativeCellDelegate_clickSecondComment)]) {
        [self.delegate GD_EvaluativeCellDelegate_clickSecondComment];
    }
}
#pragma mark - setter model
- (void)setModel:(GoodsDetailEvaluativeModel *)model
{
    _model = model;

    [self.iconImageV sd_setImageWithURL:[NSURL URLWithString:model.u_headimage] placeholderImage: Image_PlaceHolder_Photo];
    self.nickNameL.text = model.u_nickname;
    self.timeLabel.text = [NSString StringDateWithDate:model.c_createtime]  ;
    self.starView.starCount = model.c_fame.integerValue;
    self.commentLabel.text = model.c_content;
    !model.commentimage.count ? :[self setImageWithPicArr:model.commentimage];
#warning 属性暂时不展示
//    self.colorLabel.text = [NSString stringWithFormat:@"%@",model.color];
//    self.sizeLabel.text = [NSString stringWithFormat:@"%@",model.size];
    [self.likeButton setTitle:model.c_likenumber forState:UIControlStateNormal];
    [self.secondCommentBtn setTitle:model.c_replynumber forState:UIControlStateNormal];
}

@end
