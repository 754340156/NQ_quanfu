//
//  ConpanyInformationView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/28.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,LicenseType)
{
    LicenseTypeThreeInOne = 101,//三证合一
    LicenseTypeNormalLicense = 102,//普通执照
};
typedef NS_ENUM(NSUInteger,IDType)
{
    IDTypeMainland = 101,//大陆证件
    IDTypeNoMainland = 102,//非大陆证件
};
@protocol ConpanyInformationViewDelegate <NSObject>
/**  点击下一步 */
- (void)ConpanyInformationViewDelegate_clickNext;
/**  点击选照片 */
- (void)ConpanyInformationViewDelegate_clickPhotosWithButton:(UIButton *)button;
/**  点击选日期 */
- (void)ConpanyInformationViewDelegate_clickTimeWithLabel:(UILabel *)label;
/**  点击执照类型和证件类型 */
- (void)ConpanyInformationViewDelegate_clickTypeWithLicenseType:(LicenseType)licenseType IDType:(IDType)IDType;
@end

@interface ConpanyInformationView : UIView
/**  代理*/
@property (nonatomic,weak) id <ConpanyInformationViewDelegate> delegate;
//上传证件照片正面
@property (weak, nonatomic) IBOutlet UIButton *frontBtn;
//上传证件照片背面
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
//企业营业执照电子版
@property (weak, nonatomic) IBOutlet UIButton *licenseBtn;
//银行开户许可证电子版
@property (weak, nonatomic) IBOutlet UIButton *openAccountBtn;
//组织机构代码证电子版
@property (weak, nonatomic) IBOutlet UIButton *institutionalBtn;
@end
