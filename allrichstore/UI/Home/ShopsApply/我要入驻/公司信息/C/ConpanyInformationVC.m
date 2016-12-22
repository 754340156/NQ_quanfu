//
//  ConpanyInformationVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/28.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ConpanyInformationVC.h"
#import "TaxationRegistVC.h"
#import "ConpanyInformationView.h"
#import "ShopsApplyCalendarVC.h"
@interface ConpanyInformationVC ()<ConpanyInformationViewDelegate,UIImagePickerControllerDelegate>
/**  view */
@property(nonatomic,strong) ConpanyInformationView * backView;
/**  记录当前选中的选图片按钮 */
@property(nonatomic,strong) UIButton * selectedPhotosBtn;
@end

@implementation ConpanyInformationVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    self.automaticallyAdjustsScrollViewInsets = NO;

}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
  
    self.backView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ConpanyInformationView class]) owner:nil options:nil].lastObject;
    self.backView.frame = kCommentRect;
    self.backView.delegate = self;
    [self.view addSubview: self.backView];
    
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    
}

#pragma mark - request data
//请求列表数据 (替换重写)
- (void)requestListDataAnimation:(BOOL)animated
{
    NSDictionary *parameters = @{@"":@"", @"":@""};
    WS(weakSelf)
    [self POST:self.listUrl parameters:parameters success:^(NSDictionary *dic) {
        
    } fail:^(NSError *error) {
        
        
    } sendView:nil animSuperView:self.view animated:YES];
}

#pragma mark - custom method


#pragma mark - handle action

#pragma mark - ConpanyInformationViewDelegate
//下一步
- (void)ConpanyInformationViewDelegate_clickNext
{
    TaxationRegistVC * VC = [[TaxationRegistVC alloc] init];
    [self.navigationController pushVC:VC animated:YES];
}
//单选按钮
- (void)ConpanyInformationViewDelegate_clickTypeWithLicenseType:(LicenseType)licenseType IDType:(IDType)IDType
{
    
}
//选照片
- (void)ConpanyInformationViewDelegate_clickPhotosWithButton:(UIButton *)button
{
    self.selectedPhotosBtn = button;
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}
//选日期
- (void)ConpanyInformationViewDelegate_clickTimeWithLabel:(UILabel *)label
{
    ShopsApplyCalendarVC * calendarVC = [[ShopsApplyCalendarVC alloc] init];
    calendarVC.dateBlock = ^(NSDate * selectedDate)
    {
        label.text = [[NSString stringWithFormat:@"%@",selectedDate] substringToIndex:10];
    };
    BaseNC *nc = [[BaseNC alloc] initWithBackBtnStyleRootViewController:calendarVC];
    [self presentVC:nc animated:YES completion:nil];
}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if (!self.selectedPhotosBtn) return;
    if ([self.selectedPhotosBtn isEqual:self.backView.frontBtn]) {
        [self.backView.frontBtn setImage: info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
    }else if ([self.selectedPhotosBtn isEqual:self.backView.backBtn])
    {
        [self.backView.backBtn setImage: info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
        
    }else if ([self.selectedPhotosBtn isEqual:self.backView.licenseBtn])
    {
        [self.backView.licenseBtn setImage: info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
        
    }else if ([self.selectedPhotosBtn isEqual:self.backView.openAccountBtn])
    {
        [self.backView.openAccountBtn setImage: info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
        
    }else if ([self.selectedPhotosBtn isEqual:self.backView.institutionalBtn])
    {
        [self.backView.institutionalBtn setImage: info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
    }
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
