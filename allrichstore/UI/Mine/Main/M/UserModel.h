//
//  UserModel.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/7.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"

@interface UserModel : BaseModel<NSCoding, NSCopying>
///**  userid */
//@property(nonatomic,copy) NSString *  ID;
/**  用户真实姓名 */
@property(nonatomic,copy) NSString * uRealname;
/**  昵称 */
@property(nonatomic,copy) NSString * uNickname;
/**  登陆账号 */
@property(nonatomic,copy) NSString * uSername;
/**  密码 */
@property(nonatomic,copy) NSString * uPassword;
/**  性别 1:男 2:女 */
@property(nonatomic,copy) NSString * uSex;
/**  用户头像 */
@property(nonatomic,copy) NSString * uHeadimage;
/**  身份证号 */
@property(nonatomic,copy) NSString * uIdcard;
/**  电话 */
@property(nonatomic,copy) NSString * uPhone;
/**  邮箱 */
@property(nonatomic,copy) NSString * uEmail;
/**  经验值 */
@property(nonatomic,copy) NSString * uExperience;
/**  会员等级 */
@property(nonatomic,copy) NSString * uLevelId;
/**  会员的积分 */
@property(nonatomic,copy) NSString * uIntegral;
/**  会员qq */
@property(nonatomic,copy) NSString * uQq;
/**  会员微信 */
@property(nonatomic,copy) NSString * uWechat;
/**  年龄 */
@property(nonatomic,copy) NSString * uAge;
/**  婚姻状态 1:未婚 2:已婚 */
@property(nonatomic,copy) NSString * uMarriage;
/**  生日 */
@property(nonatomic,copy) NSString * uBirthday;
/**  会员余额 */
@property(nonatomic,copy) NSString * uMoney;
/**  月收入 */
@property(nonatomic,copy) NSString * uMonthpay;
/**  教育程度 */
@property(nonatomic,copy) NSString * uEducation;
/**  所属行业 */
@property(nonatomic,copy) NSString * uProfession;
/**  关联地址表 */
@property(nonatomic,copy) NSString * uAddressId;
///**  <#注释#> */
//@property(nonatomic,copy) NSString * u_coupon_id;
/**  状态（0：正常，1：删除，2：冻结） */
@property(nonatomic,copy) NSString * uStatus;
/**  创建时间 */
@property(nonatomic,copy) NSString * uCreatetime;
/**  用户环信ID */
@property(nonatomic,copy) NSString * uHxid;
/**  用户极光ID */
@property(nonatomic,copy) NSString * uJgid;

@end

