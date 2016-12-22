//
//  AddAddressVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/23.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "AddAddressVC.h"
#import "AddressEditCell.h" //地址编辑cell

#define kCellHeight LightAdapted(50)

#define kSpace_vertical     LightAdapted(8)
#define kMargin_level       Adapted(10)

//底部保存按钮的高度
#define kHeigh_confirmBtn        45

#define kTagTF              1001

@interface AddAddressVC ()

//设置为默认地址的开关
@property (nonatomic, strong) UISwitch *isDefalutSwitch;
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation AddAddressVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    self.addressModel = [AddressListModel new];
    AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
    //省市区（默认取定位的地址）
    _addressModel.addressProvince = appDelegate.province;
    _addressModel.addressCity = appDelegate.city;
    _addressModel.addressDistrict = appDelegate.district;
    self.titleArray = @[String(@"收货人"), String(@"联系电话"), String(@"所在地"), String(@"详细地址")];
    [self updateListArray];
}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    self.title = String(@"添加新地址");
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    [self.tableView registerClass:[AddressEditCell class] forCellReuseIdentifier:[AddressEditCell className]];
    self.tableView.backgroundColor = kClearColor;
    self.tableView.tableFooterView = [self tableViewFooterView];
    [self.view addSubview:_tableView];
    [self createConfirmBtn];    //创建保存按钮
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    
}

#pragma mark - lazy load
//开关
- (UISwitch *)isDefalutSwitch
{
    if (!_isDefalutSwitch)
    {
        self.isDefalutSwitch = [UISwitch new];
        [_isDefalutSwitch addTarget:self action:@selector(handleSwitch:) forControlEvents:UIControlEventValueChanged];
    }
    return _isDefalutSwitch;
}

#pragma mark - request data


#pragma mark - custom method
//更新listArray数据
- (void)updateListArray
{
    [self.listArray removeAllObjects];
    [self.listArray addObject:_addressModel.name];
    [self.listArray addObject:_addressModel.tel];
    [self.listArray addObject:_addressModel.addressPCD];
    [self.listArray addObject:_addressModel.addressDetail];
}
//表脚
- (UIView *)tableViewFooterView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, kCellHeight + kSpace_vertical)];
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, kSpace_vertical, self.tableView.width, kCellHeight)];
    whiteView.backgroundColor = kWhiteColor;
    [bgView addSubview:whiteView];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.textColor = QF_BlackColor;
    titleLabel.font = LightAdaptedFont(17);
    titleLabel.text = String(@"设置为默认收货地址");
    [whiteView addSubview:titleLabel];
    [whiteView addSubview:self.isDefalutSwitch];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(kMargin_level);
        make.width.offset(Adapted(200));
        make.top.offset(0);
        make.bottom.offset(0);
    }];
    
    [_isDefalutSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.offset(0);
        make.right.offset(-kMargin_level);
    }];
    return bgView;
}

//创建保存按钮
- (void)createConfirmBtn
{
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    confirmBtn.backgroundColor = QF_RedColor;
    confirmBtn.frame = CGRectMake(0, self.view.height - kHeigh_confirmBtn, self.view.width, kHeigh_confirmBtn);
    [confirmBtn setTitle:String(@"保存") forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(handleConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
}

//判断格式
- (BOOL)isCorrectFormat
{
    if (self.addressModel.name.length < 2)
    {
        if (self.addressModel.name.length < 1)
        {
            [self.view showToastMsg:String(@"请填写收货人姓名")];
        }
        else
        {
            [self.view showToastMsg:String(@"收货人姓名至少2个字符")];
        }
        return NO;
    }
    else if (![self.addressModel.tel isTelNumber])
    {
        if (self.addressModel.tel.length == 0)
        {
            [self.view showToastMsg:String(@"请填写联系电话")];
        }
        else
        {
            [self.view showToastMsg:String(@"请填写正确格式的联系电话")];
        }
        return NO;
    }
    else if (self.addressModel.addressPCD.length < 1)
    {
        [self.view showToastMsg:String(@"请选择所在地区")];
        return NO;
    }
    else if (self.addressModel.addressDetail.length < 5)
    {
        if (self.addressModel.addressDetail.length == 0)
        {
            [self.view showToastMsg:String(@"请填写详细地址")];
        }
        else
        {
            [self.view showToastMsg:String(@"详细地址描述信息不得少于5个字符")];
        }
        return NO;
    }
    
    return YES;
}

#pragma mark - handle action
//编辑框文字变化时
- (void)handleRightTF:(UITextField *)tf
{
    NSInteger index = tf.tag - kTagTF;
    switch (index)
    {
        case 0:
            self.addressModel.name = tf.text;
            break;
        case 1:
            self.addressModel.tel = tf.text;
            break;
        case 2:
            
            break;
        case 3:
            self.addressModel.addressDetail = tf.text;
            break;
        default:
            break;
    }
    
    [self updateListArray];
}

//设置为默认收货地址的开关
- (void)handleSwitch:(UISwitch *)sw
{
    self.addressModel.isDefault = sw.isOn;
}

//保存按钮 -- 触发事件
- (void)handleConfirmBtn:(UIButton *)sender
{
    //先验证格式
    if (![self isCorrectFormat])
    {
        return;
    }
    NSMutableArray *listArray = [Single addressListArray];
    if (_addressModel.isDefault)
    {
        //如果新地址设置为（默认地址）
        AddressListModel *model = listArray[0];
        model.isDefault = NO;
        //排在最前面
        [listArray insertObject:_addressModel atIndex:0];
    }
    else
    {
        //如果新地址不是（默认地址）
        //排在默认地址的后面
        [listArray insertObject:_addressModel atIndex:1];
    }
    
    //更新地址model
    [self.navigationController popViewControllerAnimated:YES];
    [Tools showToastMsg:String(@"保存成功")];
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
    return _listArray.count;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressEditCell *cell = [tableView dequeueReusableCellWithIdentifier:[AddressEditCell className] forIndexPath:indexPath];
    cell.addressBtn.hidden = YES;
    cell.rightTF.tag = kTagTF + indexPath.row;
    cell.titleLabel.text = _titleArray[indexPath.row];
    cell.rightTF.text = _listArray[indexPath.row];
    [cell.rightTF addTarget:self action:@selector(handleRightTF:) forControlEvents:UIControlEventEditingChanged];
    if (indexPath.row == 1)
    {
        cell.rightTF.keyboardType = UIKeyboardTypeNumberPad;
    }
    if (indexPath.row == 2)
    {
        cell.rightTF.userInteractionEnabled = NO;
        cell.addressBtn.hidden = NO;
    }
    if (indexPath.row != 3)
    {
        cell.bottomMargin = 0;
    }
    
    return cell;
}

#pragma mark - <UITableViewDelegate>
//cell被选中时触发
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2)
    {
        AddressPickerView *addressView = [[AddressPickerView alloc] initWithStyle:AddressViewTypeHaveBtn columnCount:3 block:^(Province *province, City *city, Region *region) {
            
            self.addressModel.addressProvince = province.name;
            self.addressModel.addressCity = city.name;
            self.addressModel.addressDistrict = region.name;
            [self updateListArray];
            [self.tableView reloadData];
            
        }];
        [addressView show];
    }
}

//设置cell行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
