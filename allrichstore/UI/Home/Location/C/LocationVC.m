//
//  LocationVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/7.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "LocationVC.h"
#import "AddressCell.h"
#import "HomeVC.h"

#define kCellHeight 50

#define kImageW_H  20

#define kMargin_Left    Adapted(12) //组头标题左边距
#define kMargin_Right   Adapted(12) //组头✅右边距

#define kSelfViewBgColor    [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0]

@interface LocationVC ()

//当前城市 (此处的strong不要改成copy)
@property (nonatomic, strong) NSString *selectedAddressString;
//展示当前城市的label
@property (nonatomic, strong) UILabel *selectedAddressLabel;

@end

static NSString *identiferCell = @"AddressCell";

@implementation LocationVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    self.selectedAddressString = [Single locStr];
    NSArray *locArray = [Tools readFromSandBox:LocationArrayKey];
    [self.listArray addObjectsFromArray:locArray];
    [_listArray insetFirstEachString:_selectedAddressString];
}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    
    self.title = String(@"定位");
    //添加左侧取消按钮
    [self addLeftTitle:String(@"取消") action:@selector(handleCancel)];
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    
    [self.view addSubview:self.tableView];
    _tableView.backgroundColor = kSelfViewBgColor;
    [_tableView registerClass:[AddressCell class] forCellReuseIdentifier:identiferCell];
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    
}

#pragma mark - lazy
- (UILabel *)selectedAddressLabel
{
    if (!_selectedAddressLabel)
    {
        self.selectedAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMargin_Left, 0, 160, kCellHeight)];
        _selectedAddressLabel.font = Font(16);
        _selectedAddressLabel.textColor = BaseColor_Cell_TitleLabel_Text;
    }
    return _selectedAddressLabel;
}

#pragma mark - request data
//请求列表数据 (替换重写)
- (void)requestListDataAnimation:(BOOL)animated
{
    
}

#pragma mark - custom method


#pragma mark - handle action
//取消
- (void)handleCancel
{
    [self dismissVCAnimated:YES completion:nil];
}

#pragma mark - <UITableViewDataSource>
//设置组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//设置每组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.listArray.count - 1;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identiferCell forIndexPath:indexPath];
    cell.titleLabel.text = self.listArray[indexPath.row + 1];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *superView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, kCellHeight + 30 + 6)];
    superView.backgroundColor = kSelfViewBgColor;
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMargin_Left, 0, superView.width - kMargin_Left, 30)];
    topLabel.text = String(@"当前选择");
    topLabel.textColor = kDarkGrayColor;
    topLabel.font = Font(13);
    [superView addSubview:topLabel];
    
    UIView *bottomWhiteView = [[UIView alloc] initWithFrame:CGRectMake(0, topLabel.bottom, superView.width, kCellHeight)];
    bottomWhiteView.backgroundColor = kWhiteColor;
    [superView addSubview:bottomWhiteView];
    
    self.selectedAddressLabel.text = self.listArray[0];
    [bottomWhiteView addSubview:_selectedAddressLabel];
    
    UIImageView *rightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(bottomWhiteView.width - kMargin_Right - kImageW_H, (bottomWhiteView.height - kImageW_H) / 2.0, kImageW_H, kImageW_H)];
    rightImgView.image = Image(@"xuanze_yixuan");
    [bottomWhiteView addSubview:rightImgView];
    
    return superView;
}

#pragma mark - <UITableViewDelegate>
//cell被选中时触发
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.listArray insetFirstEachString:_listArray[indexPath.row + 1]];
    
    [Single setLoc:_listArray[0]];
    [Tools writeToSandBox:_listArray key:LocationArrayKey];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView layoutIfNeeded];    //立即刷新
    
    //短暂停顿，再返回首页（让用户看到选择的地址已经切换为当前选择地址）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //定位地址改变 首页刷新数据
        [self.homeVC.refreshHeader beginRefreshing];
        
        [self dismissVCAnimated:YES completion:^{
          
        }];
    }); 
}

//设置cell行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kCellHeight + 30 + 6;
}

#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
