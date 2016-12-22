//
//  Mine_MainCell.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/7.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseTableViewCell.h"
@class UserModel;
@interface Mine_MainCell : BaseTableViewCell
/**  图标 */
@property(nonatomic,copy) NSString * icon;
/**  标题 */
@property(nonatomic,copy) NSString * title;
/**  副标题 */
@property(nonatomic,copy) NSString * attestation;
@end
