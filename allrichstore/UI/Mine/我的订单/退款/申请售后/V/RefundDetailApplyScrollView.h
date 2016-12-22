//
//  RefundDetailApplyScrollView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/17.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefundDetailApplyHeaderView.h"//头部图片
#import "RefundDetailApplyTypeView.h"//服务类型
#import "RefundDetailApplyCountView.h"//申请数量
#import "RefundDetailApplyDescriptionView.h"//问题描述
#import "RefundDetailApplyPhotosView.h"//上传照片
@class RefundDetailApplyModel;
@interface RefundDetailApplyScrollView : UIScrollView
/**  头部图片 */
@property(nonatomic,strong) RefundDetailApplyHeaderView * headerView;
/**  服务类型 */
@property(nonatomic,strong) RefundDetailApplyTypeView * typeView;
/**  申请数量 */
@property(nonatomic,strong) RefundDetailApplyCountView * countView;
/**  问题描述 */
@property(nonatomic,strong) RefundDetailApplyDescriptionView * descriptionView;
/**  上传照片 */
@property(nonatomic,strong) RefundDetailApplyPhotosView * photosView;
/**  model */
@property(nonatomic,strong) RefundDetailApplyModel* model;
@end
