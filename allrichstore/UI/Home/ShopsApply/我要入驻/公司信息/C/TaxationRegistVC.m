//
//  TaxationRegistVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "TaxationRegistVC.h"
#import "ShopInformationVC.h"
#import "TaxationRegistView.h"
@interface TaxationRegistVC ()<TaxationRegistViewDelegate,UIImagePickerControllerDelegate>
/**  backView */
@property(nonatomic,strong) TaxationRegistView * backView;
/**  记录当前选中的选图片按钮 */
@property(nonatomic,strong) UIButton * selectedPhotosBtn;
@end

@implementation TaxationRegistVC

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
    
    self.backView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TaxationRegistView class]) owner:nil options:nil].lastObject;
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

#pragma mark - TaxationRegistViewDelegate
- (void)TaxationRegistViewDelegate_clickNext
{
    ShopInformationVC *VC = [[ShopInformationVC alloc] init];
    [self.navigationController pushVC:VC animated:YES];
}
- (void)TaxationRegistViewDelegate_clickPhotosWithButton:(UIButton *)button
{
    self.selectedPhotosBtn = button;
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if (!self.selectedPhotosBtn) return;
    if ([self.selectedPhotosBtn isEqual:self.backView.button1]) {
        [self.backView.button1 setImage: info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
    }else if ([self.selectedPhotosBtn isEqual:self.backView.button2])
    {
        [self.backView.button2 setImage: info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
        
    }else if ([self.selectedPhotosBtn isEqual:self.backView.button3])
    {
        [self.backView.button3 setImage: info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
        
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
