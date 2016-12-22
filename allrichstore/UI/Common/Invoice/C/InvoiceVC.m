//
//  InvoiceVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/18.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "InvoiceVC.h"           //选择发票信息vc
#import "QFTagButton.h"         //标签Button
#import "InvoiceInfoCell.h"     //发票信息cell

//垂直间距
#define kSpace_vertical         Adapted(10)
//按钮的图片与标题的间距
#define kSpace_Btn_Image_Title   Adapted(8)
//底部确认按钮的高度
#define kHeigh_confirmBtn        45

//cell的高度
#define kCellHeight             Adapted(50)

#define kTagTF                  1001

@interface InvoiceVC ()

@property (nonatomic, strong) InvoiceModel *model;
@property (nonatomic, copy) InvoiceBlock invoiceBlock;
//发票类型选择
@property (nonatomic, strong) TagBtnsView *invoiceTypeView;
//发票抬头选择
@property (nonatomic, strong) TagBtnsView *invoiceHeaderView;
//发票内容选择
@property (nonatomic, strong) TagBtnsView *invoiceContentView;
//发票抬头输入框
@property (nonatomic, strong) UITextField *companyTF;
//不开发票的按钮
@property (nonatomic, strong) QButton *notNeedInvoiceBtn;
//包含所有信息的数组
//发票类型
@property (nonatomic, strong) NSArray *invoiceTypeAllArray;
//发票抬头
@property (nonatomic, strong) NSArray *invoiceHeaderAllArray;
//发票内容
@property (nonatomic, strong) NSArray *invoiceContentAllArray;

//选中的数组
//发票类型
@property (nonatomic, strong) NSArray *invoiceTypeSelectedArray;
//发票抬头
@property (nonatomic, strong) NSArray *invoiceHeaderSelectedArray;
//发票内容
@property (nonatomic, strong) NSArray *invoiceContentSelectedArray;


//TF数组
@property (nonatomic, strong) NSMutableArray *tfTextArray;

@end


@implementation InvoiceVC

//发票block：返回一个下单方选择好的发票信息model
- (instancetype)initWithModel:(InvoiceModel *)model invoiceBlock:(InvoiceBlock)invoiceBlock
{
    self = [super init];
    if (self)
    {
        self.model = model;
        self.invoiceBlock = invoiceBlock;
        self.invoiceTypeAllArray = @[@"普通发票", @"增值税发票"];
        self.invoiceHeaderAllArray = @[@"个人", @"单位"];
        self.invoiceContentAllArray = @[@"明细", @"电脑配件", @"耗材", @"办公用品"];
        if (model.type == InvoiceTypeNotNeed)
        {
            return self;
        }
        else if (model.type == InvoiceTypeOrdinaryPersonal)
        {
            _invoiceTypeSelectedArray = @[_invoiceTypeAllArray[0]];
            _invoiceHeaderSelectedArray = @[_invoiceHeaderAllArray[0]];
        }
        else if (model.type == InvoiceTypeOrdinaryCompany)
        {
            _invoiceTypeSelectedArray = @[_invoiceTypeAllArray[0]];
            _invoiceHeaderSelectedArray = @[_invoiceHeaderAllArray[1]];
        }
        else if (model.type == InvoiceTypeAddedTax)
        {
            _invoiceTypeSelectedArray = @[_invoiceTypeAllArray[1]];
        }
        
        if (_model.containArray.count == 0)
        {
            [_model.containArray addObject:_invoiceContentAllArray[0]];
        }
        _invoiceContentSelectedArray = _model.containArray;
        
    }
    return self;
}

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    [self.listArray addObjectsFromArray:@[@"纳税人识别码", @"注册地址", @"注册电话", @"开户银行", @"银行账户"]];
    self.tfTextArray = [NSMutableArray arrayWithArray:@[_model.identifierCode, _model.registerAddress, _model.registerTel, _model.accountBank, _model.accountNum]];
}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    self.title = @"发票信息";
    self.automaticallyAdjustsScrollViewInsets = NO;
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    self.invoiceTypeView = [[TagBtnsView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 0) title:@"发票类型" allArray:_invoiceTypeAllArray selectedArray:_invoiceTypeSelectedArray isMuti:NO configureBlcok:^(TagBtnsView *tagBtnsView) {
        
        tagBtnsView.isSameWidth = YES;
        tagBtnsView.btnTitleSeletedColor = QF_RedColor;
        tagBtnsView.btnBorderWidth = Layout_borderWidth;
        tagBtnsView.btnCornerRadius = Layout_cornerRadius;
        tagBtnsView.btnNormalBgColor = QFColor_BaseVCViewBg;
        tagBtnsView.btnSelectedBgColor = kWhiteColor;
        tagBtnsView.btnSelectedBorderColor = QF_RedColor;
    } selectedBlock:^(NSArray *stringArray, NSInteger index) {

        if (index == 0)
        {
            self.invoiceHeaderView.selectedIndex = 0;
            [self layoutWithType:InvoiceTypeOrdinaryPersonal];
            _model.type = InvoiceTypeOrdinaryPersonal;
        }
        else
        {
            _model.type = InvoiceTypeAddedTax;
            [self layoutWithType:InvoiceTypeAddedTax];
        }
        
    }];
    _invoiceTypeView.userInteractionEnabled = !(_model.type == InvoiceTypeNotNeed);
    
    [self.view addSubview:_invoiceTypeView];
    
    self.scrollView.frame = CGRectMake(0, _invoiceTypeView.bottom + kSpace_vertical, self.view.width, self.view.height - _invoiceTypeView.bottom - kHeigh_confirmBtn - kSpace_vertical);
    _scrollView.pagingEnabled = NO;
    [self.view addSubview:_scrollView];
    
    self.invoiceHeaderView = [[TagBtnsView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.width, 0) btnLayoutStyle:QButtonLayoutStyleLeft title:@"发票抬头" allArray:_invoiceHeaderAllArray selectedArray:_invoiceHeaderSelectedArray btnCountALine:3 normalImage:Image(@"weixuanze_yuan") selectedImage:Image(@"xuanze_yuan") titleAndImageSpace:Adapted(10) isMuti:NO configureBlcok:^(TagBtnsView *tagBtnsView) {
        
        tagBtnsView.btnTitleNormalColor = QF_BlackColor;
        tagBtnsView.btnTitleSeletedColor = QF_BlackColor;
        
    } selectedBlock:^(NSArray *stringArray, NSInteger index) {
        
        if (index == 0)
        {
            [self layoutWithType:InvoiceTypeOrdinaryPersonal];
            _model.type = InvoiceTypeOrdinaryPersonal;
        }
        else
        {
            [self layoutWithType:InvoiceTypeOrdinaryCompany];
            _model.type = InvoiceTypeOrdinaryCompany;
        }
    }];
    _invoiceHeaderView.userInteractionEnabled = !(_model.type == InvoiceTypeNotNeed);

    //添加公司抬头的输入框
    self.companyTF = [[UITextField alloc] initWithFrame:CGRectMake(_invoiceHeaderView.margin_level, _invoiceHeaderView.justHeight - Adapted(5), _invoiceHeaderView.width - 2 * _invoiceHeaderView.margin_level, Adapted(40))];
    _companyTF.hidden = YES;
    _companyTF.backgroundColor = kWhiteColor;
    _companyTF.borderStyle = UITextBorderStyleRoundedRect;
    _companyTF.textColor = kDarkGrayColor;
    _companyTF.font = AdaptedFont(17);
    _companyTF.placeholder = @"请填写发票的抬头";
    _companyTF.text = _model.header;
    [_companyTF addTarget:self action:@selector(handleHeaderTF:) forControlEvents:UIControlEventEditingChanged];
    [_invoiceHeaderView addSubview:_companyTF];
    [_scrollView addSubview:_invoiceHeaderView];
    
    //创建tableview
    self.tableView.backgroundColor = kClearColor;
    self.tableView.frame = CGRectMake(0, _invoiceHeaderView.bottom + kSpace_vertical, _scrollView.width, 5 * kCellHeight + kSpace_vertical);
    _tableView.scrollEnabled = NO;
    [_tableView registerClass:[InvoiceInfoCell class] forCellReuseIdentifier:[InvoiceInfoCell className]];
    [_scrollView addSubview:_tableView];
    
    self.invoiceContentView = [[TagBtnsView alloc] initWithFrame:CGRectMake(0, _tableView.bottom, _scrollView.width, 0) btnLayoutStyle:QButtonLayoutStyleLeft title:@"发票内容" allArray:_invoiceContentAllArray selectedArray:_invoiceContentSelectedArray btnCountALine:3 normalImage:Image(@"weixuanze_yuan") selectedImage:Image(@"xuanze_yuan") titleAndImageSpace:Adapted(10) isMuti:YES configureBlcok:^(TagBtnsView *tagBtnsView) {
        
        tagBtnsView.btnTitleNormalColor = QF_BlackColor;
        tagBtnsView.btnTitleSeletedColor = QF_BlackColor;
        
    } selectedBlock:^(NSArray *stringArray, NSInteger index) {
        
        NSLog(@"%ld", stringArray.count);
        [_model.containArray removeAllObjects];
        [_model.containArray addObjectsFromArray:stringArray];
        
    }];
    _invoiceContentView.userInteractionEnabled = !(_model.type == InvoiceTypeNotNeed);
    [_scrollView addSubview:_invoiceContentView];
    
    //添加不开发票的按钮
    self.notNeedInvoiceBtn = [[QButton alloc] initWithFrame:CGRectMake(_invoiceContentView.margin_level, _invoiceContentView.bottom , _scrollView.width - 2 * _invoiceContentView.margin_level, _invoiceContentView.btnsHeight) style:QButtonStyleNormal layoutStyle:QButtonLayoutStyleLeft font:_invoiceContentView.btnTitleFont title:@"不开发票" image:Image(@"weixuanze_yuan") space:Adapted(10) margin:0 autoSize:NO];
    [_notNeedInvoiceBtn setImage:Image(@"xuanze_yuan") forState:UIControlStateSelected];
    [_notNeedInvoiceBtn addTarget:self action:@selector(handleNotNeedInvoiceBtn:) forControlEvents:UIControlEventTouchUpInside];
    _notNeedInvoiceBtn.selected = (_model.type == InvoiceTypeNotNeed);
    [_scrollView addSubview:_notNeedInvoiceBtn];
    
    
    
    if (_notNeedInvoiceBtn.bottom > _scrollView.height)
    {
        _scrollView.contentSize = CGSizeMake(_scrollView.width, _notNeedInvoiceBtn.bottom + Adapted(12));
    }
    
    [self createConfirmBtn];    //创建确认按钮
    
    [self layoutWithType:self.model.type];
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    
}

#pragma mark - lazy


#pragma mark - override
- (void)setInvoiceTypeSelectedArray:(NSArray *)invoiceTypeSelectedArray
{
    _invoiceTypeSelectedArray = invoiceTypeSelectedArray;
    _invoiceTypeView.selectedStringArr = invoiceTypeSelectedArray;
}

- (void)setInvoiceHeaderSelectedArray:(NSArray *)invoiceHeaderSelectedArray
{
    _invoiceHeaderSelectedArray = invoiceHeaderSelectedArray;
    _invoiceHeaderView.selectedStringArr = invoiceHeaderSelectedArray;
}

- (void)setInvoiceContentSelectedArray:(NSArray *)invoiceContentSelectedArray
{
    _invoiceContentSelectedArray = invoiceContentSelectedArray;
    _invoiceContentView.selectedStringArr = invoiceContentSelectedArray;
}

#pragma mark - request data
//请求列表数据 (替换重写)
- (void)requestListDataAnimation:(BOOL)animated
{
//    NSDictionary *parameters = @{@"":@"", @"":@""};
//    WS(weakSelf)
//    [self POST:self.listUrl parameters:parameters success:^(NSDictionary *dic) {
//        
//    } fail:^(NSError *error) {
//        
//        
//    } sendView:nil animSuperView:self.view animated:YES];
}

#pragma mark - custom method
//布局视图
- (void)layoutWithType:(InvoiceType)type
{
    if (type == InvoiceTypeOrdinaryPersonal)
    {
        _companyTF.hidden = YES;
        _companyTF.origin = CGPointMake(_invoiceHeaderView.margin_level, _invoiceHeaderView.justHeight - Adapted(5));
        _invoiceHeaderView.height = _invoiceHeaderView.justHeight;
        _tableView.origin = CGPointMake(0, _invoiceHeaderView.bottom + kSpace_vertical);
        _tableView.height = 0;
        _invoiceContentView.origin = CGPointMake(0,_tableView.bottom);
    }
    else if (type == InvoiceTypeOrdinaryCompany)
    {
        _companyTF.hidden = NO;
        _companyTF.origin = CGPointMake(_invoiceHeaderView.margin_level, _invoiceHeaderView.justHeight - Adapted(5));
        _invoiceHeaderView.height = _invoiceHeaderView.justHeight + Adapted(45);
        _tableView.origin = CGPointMake(0, _invoiceHeaderView.bottom + kSpace_vertical);
        _tableView.height = 0;
        _invoiceContentView.origin = CGPointMake(0, _tableView.bottom);
    }
    else if (type == InvoiceTypeAddedTax)
    {
        _companyTF.hidden = NO;
        _companyTF.origin = CGPointMake(_invoiceHeaderView.margin_level, _invoiceHeaderView.justHeight - _companyTF.height - _invoiceHeaderView.margin_bottom);
        _invoiceHeaderView.height = _invoiceHeaderView.justHeight;
        _tableView.origin = CGPointMake(0, _invoiceHeaderView.bottom + kSpace_vertical);
        _tableView.height = kCellHeight * 5.0 + kSpace_vertical;
        _invoiceContentView.origin = CGPointMake(0, _tableView.bottom);
    }
    else
    {
        
    }
    
    _notNeedInvoiceBtn.top = _invoiceContentView.bottom + kSpace_vertical;
    if (_notNeedInvoiceBtn.bottom > _scrollView.height)
    {
        _scrollView.contentSize = CGSizeMake(_scrollView.width, _notNeedInvoiceBtn.bottom + Adapted(12));
    }
    else
    {
        _scrollView.contentSize = _scrollView.size;
    }
    [_scrollView scrollsToTop];
}

//创建确认按钮
- (void)createConfirmBtn
{
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    confirmBtn.backgroundColor = QF_RedColor;
    confirmBtn.frame = CGRectMake(0, self.view.height - kHeigh_confirmBtn, self.view.width, kHeigh_confirmBtn);
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(handleConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
}

//单选btn
- (void)handleSigleBtn:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

#pragma mark - handle action
//确认按钮 -- 触发事件
- (void)handleConfirmBtn:(UIButton *)sender
{
    _invoiceBlock(_model);
    [self.navigationController popViewControllerAnimated:YES];
}

//不开发票按钮的 -- 触发事件
- (void)handleNotNeedInvoiceBtn:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected)
    {
        _model.type = InvoiceTypeNotNeed;
        [_model.containArray removeAllObjects];
        self.invoiceTypeView.userInteractionEnabled = NO;
        self.invoiceHeaderView.userInteractionEnabled = NO;
        self.invoiceContentView.userInteractionEnabled = NO;
        self.invoiceTypeSelectedArray = nil;
        self.invoiceHeaderSelectedArray = nil;
        self.invoiceContentSelectedArray = nil;
    }
    else
    {
        self.invoiceTypeView.userInteractionEnabled = YES;
        self.invoiceHeaderView.userInteractionEnabled = YES;
        self.invoiceContentView.userInteractionEnabled = YES;
        _model.type = InvoiceTypeOrdinaryPersonal;
        [_model.containArray addObject:_invoiceContentAllArray[0]];
        self.invoiceTypeSelectedArray = @[_invoiceTypeAllArray[0]];
        self.invoiceHeaderSelectedArray = @[_invoiceHeaderAllArray[0]];
        self.invoiceContentSelectedArray = @[_invoiceContentAllArray[0]];
        [_model.containArray removeAllObjects];
    }
    
    [self layoutWithType:InvoiceTypeOrdinaryPersonal];
}

//发票的抬头
- (void)handleHeaderTF:(UITextField *)tf
{
    _model.header = tf.text;
}

//增值税信息的输入框
- (void)handleAddedTaxInfoTF:(UITextField *)tf
{
    NSInteger index = tf.tag - kTagTF;
    switch (index)
    {
        case 0:
            _model.identifierCode = tf.text;
            break;
        case 1:
            _model.registerAddress = tf.text;
            break;
        case 2:
            _model.registerTel = tf.text;
            break;
        case 3:
            _model.accountBank = tf.text;
            break;
        case 4:
            _model.accountNum = tf.text;
            break;
        default:
            break;
    }
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
    return 5;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InvoiceInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:[InvoiceInfoCell className] forIndexPath:indexPath];
    cell.rightTF.tag = kTagTF + indexPath.row;
    cell.titleLabel.text = _listArray[indexPath.row];
    cell.rightTF.placeholder = [NSString stringWithFormat:@"请输入%@", _listArray[indexPath.row]];
    cell.rightTF.text = _tfTextArray[indexPath.row];
    if ((indexPath.row == 0) || (indexPath.row == 2) || (indexPath.row == 4))
    {
        cell.rightTF.keyboardType = UIKeyboardTypeNumberPad;
    }
    [cell.rightTF addTarget:self action:@selector(handleAddedTaxInfoTF:) forControlEvents:UIControlEventEditingChanged];
    if (indexPath.row != 4)
    {
        cell.bottomMargin = 0;
    }
    return cell;
}

#pragma mark - <UITableViewDelegate>
//cell被选中时触发
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
