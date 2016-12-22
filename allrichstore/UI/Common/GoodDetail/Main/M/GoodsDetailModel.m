//
//  GoodsDetailModel.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/1.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "GoodsDetailModel.h"
@implementation GoodsDetailModel
- (CGFloat)active_height
{
    return self.coupon.count * Adapted(GD_ActiveViewH);
}
- (CGFloat)evaluative_height
{
    CGFloat height  = 0.0f;
    for (GoodsDetailEvaluativeModel *model in self.comment ) {
        height += model.evaluative_height;
    }
    height += Adapted(GD_EvaluativeHeaderH);
    return height;
}
- (CGFloat)store_height
{
    return self.shop.count * Adapted(GD_StoreViewH);
}
+ (NSDictionary *)objectClassInArray{
    return @{
             @"image":@"GoodsDetailImageModel",
             @"coupon" : @"GoodsDetailActiveModel",
             @"comment" : @"GoodsDetailEvaluativeModel",
             @"shop":@"GoodsDetailStoreModel",
             @"property":@"GoodsDetailChooseModel",
             };
}
@end
@implementation GoodsDetailActiveModel


@end
@implementation GoodsDetailEvaluativeModel

- (CGFloat)evaluative_height
{
    CGFloat  commentHeight = [UILabel getHeightWithFont:Font_Mid Width:kScreenW - Adapted(20) text:self.c_content];
    if (self.commentimage.count) {
        //有图片
        return  6 * Adapted(kMargin) + Adapted(GD_EvaluativeIconH) + Adapted(GD_EvaluativeStarH) + Adapted(GD_EvaluativePicH) + Adapted(GD_EvaluativeColorH) + commentHeight;
    }else
    {
        //没图片
        return 5 * Adapted(kMargin) + Adapted(GD_EvaluativeIconH) + Adapted(GD_EvaluativeStarH)+ Adapted(GD_EvaluativeColorH) + commentHeight;
    }
}
+ (NSDictionary *)objectClassInArray{
    return @{
             @"commentimage":@"GoodsDetailImageModel"
             };
}
@end
@implementation GoodsDetailStoreModel


@end

@implementation GoodsDetailImageModel


@end

@implementation GoodsDetailChooseModel


@end
