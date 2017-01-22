//
//  JGCreateBusOppController.m
//  EFFLOG
//
//  Created by stkcctv on 17/1/4.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "JGCreateBusOppController.h"
#import "JGBusOppFirstViewCell.h"
#import "JGProjectAllUserModel.h"
#import "UIView+JGExtension.h"
#import "NSString+JGExtension.h"

//尺寸
#define kDeviceHight [UIScreen mainScreen].bounds.size.height
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width


@interface JGCreateBusOppController () <UITableViewDelegate, UITableViewDataSource,JGBusOppFirstViewDelegate> {
    NSString *_indexPath; //标记是那一部分（参与人/管理人）
    NSString *_timeStr;  //标记时间选择
    int _myIndex;
    CGSize _indexSize;
//    int x ;
//    int i;
}
    
    @property (nonatomic, strong)UIView *navView;
    @property (nonatomic, strong)UITableView *tableView;
    @property (nonatomic, strong)UIView *firstFootV;
    @property (nonatomic, strong)UIView *secondFootV;
    @property (nonatomic, strong)UIView *thirdFootV;
    
    @property (nonatomic, copy)NSString *firstStr1;
    @property (nonatomic, copy)NSString *firstStr2;
    @property (nonatomic, copy)NSString *firstStr3;
    @property (nonatomic, strong)UIButton *beginTimeBtn;
    @property (nonatomic, strong)UIButton *endTimeBtn;
//    @property (nonatomic, strong)UITextView *tex;

    @property (nonatomic, strong)NSMutableArray *secondPathData;
    @property (nonatomic, strong)NSMutableArray *thirdPathData;
    //记录添加Person时所选择的行
    @property (nonatomic, strong)NSArray *selectedIndexPaths;
    //记录添加Person时所选择的行
    @property (nonatomic, strong)NSArray *thirdSelectedIndexPaths;
    //保存所有用户模型
    @property (nonatomic, strong) NSMutableArray *allUserArrM;
    //保存所有用户名字
    @property (nonatomic, strong) NSMutableArray *allNameArrM;
    @end

static NSString * const JGTableViewCellId = @"JGTableViewCellId";
static NSString * const JGBusOppFirstViewCellId = @"JGBusOppFirstViewCellId";
@implementation JGCreateBusOppController
    
- (NSMutableArray *)allNameArrM {
    if (!_allNameArrM) {
        _allNameArrM = [NSMutableArray array];
    }
    return _allNameArrM;
}
    
- (NSMutableArray *)allUserArrM {
    if (!_allUserArrM) {
        _allUserArrM = [NSMutableArray array];
    }
    return _allUserArrM;
}
    
    
- (NSArray *)secondPathData {
    
    if (!_secondPathData) {
        
        _secondPathData = [NSMutableArray array];
        //        [_secondPathData addObject:[JGCommonTools getUserDefaultsWithKey:@"NAME"]];
        [_secondPathData addObject:@"郭军"];
    }
    return _secondPathData;
}
    
- (NSMutableArray *)thirdPathData {
    
    if (!_thirdPathData) {
        _thirdPathData = [NSMutableArray array];
        //        [_thirdPathData addObject:[JGCommonTools getUserDefaultsWithKey:@"NAME"]];
        [_thirdPathData addObject:@"郭军"];
    }
    return _thirdPathData;
}
    
- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navView.bottom, kDeviceWidth, kDeviceHight - self.navView.height) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:JGTableViewCellId];
        //        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JGBusOppFirstViewCell class]) bundle:nil] forCellReuseIdentifier:JGBusOppFirstViewCellId];
    }
    return _tableView;
}
    
    
- (UIView *)firstFootV {
    
    if (!_firstFootV) {
        
        _firstFootV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 70)];
        //        _firstFootV.backgroundColor = [UIColor redColor];
        UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
        titleLbl.text = @"商机期限";
        titleLbl.textAlignment = NSTextAlignmentCenter;
        titleLbl.font = [UIFont systemFontOfSize:14];
        titleLbl.textColor = [UIColor lightGrayColor];
        [_firstFootV addSubview:titleLbl];
        
        NSString *currentTimeStr = [[NSString getCurrentData] substringWithRange:NSMakeRange(0, 16)];
        
        UILabel *beginTimeLbl = [[UILabel alloc] initWithFrame:CGRectMake(titleLbl.right + 5, 0, 70, 30)];
        beginTimeLbl.text = @"开始时间";
        beginTimeLbl.textAlignment = NSTextAlignmentCenter;
        beginTimeLbl.font = [UIFont systemFontOfSize:14];
        beginTimeLbl.textColor = [UIColor lightGrayColor];
        [_firstFootV addSubview:beginTimeLbl];
        
        UIButton *beginTimeBtn = [[UIButton alloc] initWithFrame:CGRectMake(beginTimeLbl.right, beginTimeLbl.y, 200, beginTimeLbl.height)];
        self.beginTimeBtn = beginTimeBtn;
        //设置UIButton字体居左显示
        beginTimeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //设置button的title就距左边10个像素的距离。
        beginTimeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [beginTimeBtn setTitle:currentTimeStr forState:UIControlStateNormal];
        [beginTimeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [beginTimeBtn addTarget:self action:@selector(beginTimeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_firstFootV addSubview:beginTimeBtn];
        
        UILabel *endTimeLbl = [[UILabel alloc] initWithFrame:CGRectMake(titleLbl.right + 5, beginTimeLbl.bottom + 5, 70, 30)];
        endTimeLbl.text = @"结束时间";
        endTimeLbl.textAlignment = NSTextAlignmentCenter;
        endTimeLbl.font = [UIFont systemFontOfSize:14];
        endTimeLbl.textColor = [UIColor lightGrayColor];
        [_firstFootV addSubview:endTimeLbl];
        
        UIButton *endTimeBtn = [[UIButton alloc] initWithFrame:CGRectMake(endTimeLbl.right, endTimeLbl.y, 200, endTimeLbl.height)];
        self.endTimeBtn = endTimeBtn;
        //设置UIButton字体居左显示
        endTimeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //设置button的title就距左边10个像素的距离。
        endTimeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [endTimeBtn setTitle:currentTimeStr forState:UIControlStateNormal];
        [endTimeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [endTimeBtn addTarget:self action:@selector(endTimeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_firstFootV addSubview:endTimeBtn];
    }
    return _firstFootV;
}
    
#pragma mark - 开始/结束时间选择按钮点击了 -
- (void)beginTimeBtnClick {
    
    [self.view endEditing:YES];

    
   }
    
- (void)endTimeBtnClick {
    
    [self.view endEditing:YES];
    

    
}
    
    

- (UIView *)secondFootV {
    
    if (!_secondFootV) {
        
        _secondFootV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 50)];
        
        //        _secondFootV.backgroundColor = [UIColor redColor];
        
        UIButton *removeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 100, _secondFootV.height - 20)];
        [removeBtn setTitle:@"删除" forState:UIControlStateNormal];
        removeBtn.backgroundColor = [UIColor lightGrayColor];
        [removeBtn addTarget:self action:@selector(secondRemoveBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_secondFootV addSubview:removeBtn];
        
        UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(removeBtn.right + 10, 10, 100, _secondFootV.height - 20)];
        [addBtn setTitle:@"添加" forState:UIControlStateNormal];
        addBtn.backgroundColor = [UIColor lightGrayColor];
        [addBtn addTarget:self action:@selector(secondAddBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_secondFootV addSubview:addBtn];
        
        
    }
    return _secondFootV;
}
    
- (void)secondAddBtnClick {
    
   
}
    
- (void)secondRemoveBtnClick {
    
  
}
    
- (UIView *)thirdFootV {
    
    if (!_thirdFootV) {
        
        _thirdFootV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 50)];
        
        //        _secondFootV.backgroundColor = [UIColor redColor];
        
        UIButton *removeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 100, _thirdFootV.height - 20)];
        [removeBtn setTitle:@"删除" forState:UIControlStateNormal];
        removeBtn.backgroundColor = [UIColor lightGrayColor];
        [removeBtn addTarget:self action:@selector(thirdRemoveBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_thirdFootV addSubview:removeBtn];
        
        UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(removeBtn.right + 10, 10, 100, _thirdFootV.height - 20)];
        [addBtn setTitle:@"添加" forState:UIControlStateNormal];
        addBtn.backgroundColor = [UIColor lightGrayColor];
        [addBtn addTarget:self action:@selector(thirdAddBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_thirdFootV addSubview:addBtn];
        
    }
    return _thirdFootV;
}
    
- (void)thirdAddBtnClick {
    
}
    
- (void)thirdRemoveBtnClick {
    
    
}
    
    
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //创建导航栏
    [self createNav];
    //创建Table
    [self.view addSubview:self.tableView];
    //加载所有用户数据
    [self loadAllUserData];
}
    
    
#pragma mark - 加载所有用户数据 -
- (void)loadAllUserData {
    
  
    
    
}
    

    
    //设置状态栏的颜色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
    
#pragma mark - 创建导航栏 -
- (void)createNav {
    
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 64)];
    //    navView.backgroundColor = JGRGBColor(254, 254, 254);
    self.navView = navView;
    navView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:navView];
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 20, 50, 44)];
    //    leftBtn.backgroundColor = [UIColor greenColor];
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:leftBtn];
    
    UILabel *TitleLbl = [[UILabel alloc] init];
    TitleLbl.text = @"新建商机";
    TitleLbl.textColor = [UIColor whiteColor];
    TitleLbl.font = [UIFont systemFontOfSize:18];
    [TitleLbl sizeToFit];
    TitleLbl.center = CGPointMake(kDeviceWidth * 0.5, 40);
    [navView addSubview:TitleLbl];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth - 55, 20, 50, 44)];
    //    rightBtn.backgroundColor = [UIColor greenColor];
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:rightBtn];
    
}
    
    
- (void)leftBtnClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
    
- (void)rightBtnClick {
    
    
    NSMutableString *User_IDStr = [NSMutableString string]; //参与人
    NSMutableString *User_IDMStr = [NSMutableString string]; //管理员
    
    for (NSString *ss in self.secondPathData) {
        for (JGProjectAllUserModel *model in self.allUserArrM) {
            if ([ss isEqualToString:model.NAME]) {
                [User_IDStr appendString:[NSString stringWithFormat:@"%@&-&",model.USER_ID]];
                break;
            }
        }
    }
    
    for (NSString *ss in self.thirdPathData) {
        for (JGProjectAllUserModel *model in self.allUserArrM) {
            if ([ss isEqualToString:model.NAME]) {
                [User_IDMStr appendString:[NSString stringWithFormat:@"%@&-&",model.USER_ID]];
                break;
            }
        }
    }
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"BUSS_NAME"] = self.firstStr1;
    parameters[@"BUSS_RESOURCE"] = self.firstStr2;
    parameters[@"BUSS_INFO"] = self.firstStr3;
    parameters[@"BEGIN_TIME"] = self.beginTimeBtn.currentTitle;
    parameters[@"END_TIME"] = self.endTimeBtn.currentTitle;
    parameters[@"BUSS_JOIN"] = User_IDStr;
    parameters[@"BUSS_MANA"] = User_IDMStr;
    parameters[@"BUSS_TIME"] = [[NSString getCurrentData] substringWithRange:NSMakeRange(0, 16)];
  
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
    
    
#pragma mark - UITableViewDataSource -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 3;
    }else if(section == 1){
        return self.secondPathData.count;
    }else {
        return self.thirdPathData.count;
    }
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        JGBusOppFirstViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JGBusOppFirstViewCellId forIndexPath:indexPath];
        cell.JGBusOppFirstViewDelegate = self;
        
        if (indexPath.row == 0) {
            cell.titleLbl.text = @"商机名称";
        }else if (indexPath.row == 1) {
            cell.titleLbl.text = @"商机来源";
        }else if (indexPath.row == 2) {
            cell.titleLbl.text = @"商机描述";
//            if (_myIndex == 1) {
//                [cell.contentTextV becomeFirstResponder];
//            }
        }
        return cell;
    }else if (indexPath.section == 1){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JGTableViewCellId forIndexPath:indexPath];
        cell.textLabel.text = [self.secondPathData objectAtIndex:indexPath.row];
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JGTableViewCellId forIndexPath:indexPath];
        
        cell.textLabel.text = [self.thirdPathData objectAtIndex:indexPath.row];
        
        return cell;
    }
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}
    
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 30)];
    lbl.backgroundColor = [UIColor lightGrayColor];
    
    if (section == 1) {
        
        lbl.text = @"  商机参与人:";
        lbl.textColor = [UIColor blackColor];
        lbl.height =  30.0;
        return lbl;
    }else if (section == 2){
        
        lbl.text = @"  商机管理人:";
        lbl.textColor = [UIColor blackColor];
        lbl.height =  30.0 ;
        return lbl;
    }else {
        return nil;
    }
}
    
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.firstFootV;
    }else if (section == 1){
        return self.secondFootV;
    }else {
        return self.thirdFootV;
    }
}
    
    
    
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        return 30.0;
    }else if (section == 2) {
        return 30.0;
    }else {
        return 0.01;
    }
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 0) {
        return 70;
    }else if (section == 1) {
        return 50;
    }else {
        return 50;
    }
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 2) {
        
        CGSize calculateSize = [self sizeForLblContent:self.firstStr3 fixMaxWidth:kDeviceWidth - 73 andFondSize:16];
        if (calculateSize.height >=200) return 200;
        return calculateSize.height > 20 ? (calculateSize.height +  30) : 50;
    }
    return  50;
}
    
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.tableView endEditing:YES];
}
    CGSize hhh;
#pragma mark - JGBusOppFirstViewDelegate -
- (void)JGBusOppFirstViewTextViewDidChange:(NSString *)Str andTableViewCell:(JGBusOppFirstViewCell *)cell{
    _myIndex = 0;
    if ([cell.titleLbl.text isEqualToString:@"商机名称"]) {
        self.firstStr1 = Str;
    }else if ([cell.titleLbl.text isEqualToString:@"商机来源"]) {
        self.firstStr2 = Str;
    }else if ([cell.titleLbl.text isEqualToString:@"商机描述"]) {
        self.firstStr3 = Str;
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }

}
    
    
#pragma mark - JGProjectAddPersonVCDelegate -
- (void)ProjectAddPersonGetPersonData:(NSArray *)dataArr selectedIndexPaths:(NSArray *)selectedIndexPaths {
    
       [self.tableView reloadData];
}
    
#pragma mark - JGProjectRemovePersonVCDelegate -
- (void)JGProjectRemovePersonGetPersonData:(NSArray *)dataArr {
    
       [self.tableView reloadData];
}


// 通过给定文字和字体大小在指定的最大宽度下，计算文字实际所占的尺寸
- (CGSize)sizeForLblContent:(NSString *)strContent fixMaxWidth:(CGFloat)w andFondSize:(int)fontSize{
    // 先获取文字的属性，特别是影响文字所占尺寸相关的
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    // 把该属性放到字典中
    NSDictionary *dicAttr = [[NSDictionary alloc] initWithObjectsAndKeys:font,NSFontAttributeName, nil];
    // 通过字符串的计算文字所占尺寸方法获取尺寸
    CGSize size = [strContent boundingRectWithSize:CGSizeMake(w, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dicAttr context:nil].size;
    
    return size;
}

    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
    
    
    @end
