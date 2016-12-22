//
//  Authentication_UploadVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/9.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "Authentication_UploadVC.h"
#import "Authentication_SuccessVC.h"
#import "Authentication_UploadView.h"
@interface Authentication_UploadVC ()<Authentication_UploadViewDelegate,UIImagePickerControllerDelegate>
/**  homeView */
@property(nonatomic,strong) Authentication_UploadView * uploadView;
/**  记录当前选中的button */
@property(nonatomic,strong) UIButton * selectedBtn;
@end

@implementation Authentication_UploadVC

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
    self.uploadView = [[Authentication_UploadView alloc] initWithFrame:CGRectMake(0, TopBarHeight, kScreenW, kScreenH - TopBarHeight - kBottomH) superView:self.view];
    self.uploadView.name = @"*爽";
    self.uploadView.Au_delegate = self;
    [self.view addSubview:self.uploadView];
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
#pragma mark - Authentication_UploadViewDelegate
//确认上传
- (void)Authentication_UploadViewDelegate_clickSureButton
{
    Authentication_SuccessVC *successVC = [[Authentication_SuccessVC alloc] init];
    [self.navigationController pushVC:successVC animated:YES];
}
//点击选照片
- (void)Authentication_UploadViewDelegate_clickPhotosBtnWithButton:(UIButton *)sender
{
    self.selectedBtn = sender;
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if (!self.selectedBtn) return;
    if ([self.selectedBtn isEqual:self.uploadView.frontButton]) {
        [self.uploadView.frontButton setImage: info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
    }else if ([self.selectedBtn isEqual:self.uploadView.backButton])
    {
        [self.uploadView.backButton setImage: info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
        
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
