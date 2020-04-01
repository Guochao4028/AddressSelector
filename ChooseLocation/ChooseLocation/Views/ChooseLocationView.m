//
//  ChooseLocationView.m
//  ChooseLocation
//
//  Created by 郭超 on 2020/3/31.
//  Copyright © 2020 gucohao. All rights reserved.
//

#import "ChooseLocationView.h"
#import "AddressHeadView.h"
#import "AddressTableViewCell.h"
#import "AddressInfoModel.h"

static  CGFloat  const  kHYTopViewHeight = 40; //顶部视图的高度
static  CGFloat  const  kHYTopTabbarHeight = 34; //地址标签栏的高度

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ChooseLocationView ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) AddressHeadView * topTabbar;
@property (nonatomic, strong) UIScrollView * contentView;

@property(nonatomic, strong)NSMutableArray *tableViews;

@property(nonatomic, strong)NSArray *firstArray;

@property (nonatomic,strong) NSMutableArray * topTabbarItems;

@property(nonatomic, assign)BOOL isOther;//记录多余按钮

@property(nonatomic, assign)BOOL isWai;//是否选了国外

@property(nonatomic, strong)NSArray *cityDataSouce;//市数据

@property(nonatomic, strong)NSArray *districtDataSouce;//区数据


@end

@implementation ChooseLocationView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self initUI];
    }
    return self;
}

#pragma mark - methods

- (void)initUI{
    
    [self addSubview:self.topTabbar];
    [self addSubview:self.contentView];
    //创建tableiView
    [self addTableView];
    
    [self addItem:@"请选择"];
}

-(void)initData{
    NSMutableArray *data = [NSMutableArray array];
    AddressInfoModel *item = [[AddressInfoModel alloc]init];
    item.cname = @"国内";
    item.isSelected = NO;
    [data addObject:item];
    
    AddressInfoModel *item1 = [[AddressInfoModel alloc]init];
    item1.cname = @"海外";
    item1.isSelected = NO;
    [data addObject:item1];
    
    self.firstArray = [NSArray arrayWithArray:data];
}

#pragma mark - 创建tableiView
- (void)addTableView{
    
    CGFloat width = CGRectGetWidth(self.bounds);
    UITableView * tabbleView = [[UITableView alloc]initWithFrame:CGRectMake(self.tableViews.count * ScreenWidth, 0, ScreenWidth, width)];
    [self.contentView addSubview:tabbleView];
    [self.tableViews addObject:tabbleView];
    tabbleView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabbleView.delegate = self;
    tabbleView.dataSource = self;
    tabbleView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    [tabbleView registerNib:[UINib nibWithNibName:@"AddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"AddressTableViewCell"];
}

-(void)addItem:(NSString *)title{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setValue:@"0" forKey:@"tag"];
    [dic setValue:title forKey:@"title"];
    [dic setValue:@"0" forKey:@"selected"];
    
    [self.topTabbarItems addObject:dic];
    [self sorting];
   
}

-(void)updataHeadViewData:(NSString *)title loction:(NSInteger)loc{
    NSMutableDictionary *dic = [self.topTabbarItems objectAtIndex:loc];
    [dic  setValue:title forKey:@"title"];
    
    NSMutableDictionary *dic1 = [self.topTabbarItems lastObject];
    [dic1  setValue:@"1" forKey:@"tag"];
    [self sorting];
    self.isOther  = YES;
}


/// 数组排序
-(void)sorting{
    NSArray *temp = [self.topTabbarItems sortedArrayWithOptions:NSSortStable usingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSMutableDictionary *dic1 = (NSMutableDictionary *)obj1;
        NSMutableDictionary *dic2 = (NSMutableDictionary *)obj2;
        NSInteger tag1 = [dic1[@"tag"] integerValue];
        NSInteger tag2 = [dic2[@"tag"] integerValue];
        if (tag1 > tag2) {
            return NSOrderedDescending;
        }else if (tag2 == tag1){
            return NSOrderedSame;
        }else{
            return NSOrderedAscending;
        }
    }];
    [self.topTabbarItems removeAllObjects];
    
    [self.topTabbarItems addObjectsFromArray:temp];
    
    [self.topTabbar setDataArray:self.topTabbarItems];
}

- (void)scrollToNextItem{
    NSInteger index = self.contentView.contentOffset.x / ScreenWidth;
    
    if (self.tableViews.count == 1) {
        UITableView *tableView = [self.tableViews lastObject];
        
        if (self.isWai == NO) {
            
            for (AddressInfoModel *item in self.dataArray) {
                
                if ([item.cname isEqualToString:@"中国"] == YES) {
                    NSArray *itemArray = item.childern;
                    
                    self.firstArray = [itemArray lastObject];
                    
                }
            }
            
            for (AddressInfoModel *item  in self.firstArray) {
                
                item.isSelected = NO;
            }
            
        }else{
            //国外
            NSLog(@"国外");
            
        }
        [tableView reloadData];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            self.contentView.contentSize = (CGSize){self.tableViews.count * ScreenWidth,0};
            CGPoint offset = self.contentView.contentOffset;
            self.contentView.contentOffset = CGPointMake(offset.x + ScreenWidth, offset.y);
//            [self changeUnderLineFrame: [self.topTabbar.subviews lastObject]];
        }];
    }
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self.tableViews indexOfObject:tableView] == 0) {
        return self.firstArray.count;
    }else if ([self.tableViews indexOfObject:tableView] == 1) {
        return self.cityDataSouce.count;
    }else if ([self.tableViews indexOfObject:tableView] == 2) {
        return self.districtDataSouce.count;
    }
    
    
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    AddressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AddressTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    AddressInfoModel * item;
    if([self.tableViews indexOfObject:tableView] == 0){
        item = self.firstArray[indexPath.row];
    }else if ([self.tableViews indexOfObject:tableView] == 1){
        item = self.cityDataSouce[indexPath.row];
    }else if ([self.tableViews indexOfObject:tableView] == 2) {
        item = self.districtDataSouce[indexPath.row];
    }
    cell.item = item;
    return cell;
}

#pragma mark - TableViewDelegate


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([self.tableViews indexOfObject:tableView] == 0){
        //选择 国内 海外
        //取得本层数据
        AddressInfoModel * provinceItem = self.firstArray[indexPath.row];
        NSString *name = provinceItem.cname;
        //1.1 判断是否是第一次选择,不是,则重新选择
        NSIndexPath * indexPath0 = [tableView indexPathForSelectedRow];
        
        if ([indexPath0 compare:indexPath] == NSOrderedSame && indexPath0){
            NSLog(@"[indexPath0 compare:indexPath] == NSOrderedSame");
        }
        
        if (self.isOther == NO) {
            NSString *str= [name isEqualToString:@"国内"] == YES ? @"海外" : @"国内";
            self.isWai = [name isEqualToString:@"海外"];
            [self addItem:str];
            [self updataHeadViewData:name loction:0];
            NSLog(@"str : %@", str);
            NSLog(@"name : %@", name);
            
            [self scrollToNextItem];
            
        }else{
        
            NSArray *cityArray = provinceItem.childern;
            
            self.cityDataSouce = [cityArray lastObject];
            
            [self updataHeadViewData:name loction:0];
            [self addItem:@"请选择"];
            
            [self addTableView];
            
            [self scrollToNextItem];
            
        }
        
    }else if([self.tableViews indexOfObject:tableView] == 1){
        //选择 城市
        //取得本层数据
        AddressInfoModel * provinceItem = self.cityDataSouce[indexPath.row];
        NSString *name = provinceItem.cname;
        //1.1 判断是否是第一次选择,不是,则重新选择
        NSIndexPath * indexPath0 = [tableView indexPathForSelectedRow];
        
        if ([indexPath0 compare:indexPath] == NSOrderedSame && indexPath0){
            NSLog(@"[indexPath0 compare:indexPath] == NSOrderedSame");
        }
        NSArray *districtArray = [provinceItem.childern lastObject];
        
        if (districtArray.count > 0) {
            self.districtDataSouce = districtArray;
            [self updataHeadViewData:name loction:1];
            [self addItem:@"请选择"];
            [self addTableView];
            [self scrollToNextItem];
        }else{
            [self removeFromSuperview];
        }
    }else if([self.tableViews indexOfObject:tableView] == 2){
        //选择 区
        //取得本层数据
        AddressInfoModel * provinceItem = self.districtDataSouce[indexPath.row];
        NSString *name = provinceItem.cname;
        //1.1 判断是否是第一次选择,不是,则重新选择
        NSIndexPath * indexPath0 = [tableView indexPathForSelectedRow];
        
        if ([indexPath0 compare:indexPath] == NSOrderedSame && indexPath0){
            NSLog(@"[indexPath0 compare:indexPath] == NSOrderedSame");
        }
        NSArray *districtArray = [provinceItem.childern lastObject];
        
        if (districtArray.count > 0) {
            self.districtDataSouce = districtArray;
            [self updataHeadViewData:name loction:1];
            [self addItem:@"请选择"];
            [self addTableView];
            [self scrollToNextItem];
        }else{
            [self removeFromSuperview];
        }
    }
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddressInfoModel * item;
     if([self.tableViews indexOfObject:tableView] == 0){
         for (AddressInfoModel * model in self.firstArray) {
             model.isSelected = NO;
         }
        item = self.firstArray[indexPath.row];
    }else if([self.tableViews indexOfObject:tableView] == 1){
        for (AddressInfoModel * model in self.cityDataSouce) {
                    model.isSelected = NO;
                }
        item = self.cityDataSouce[indexPath.row];
    }else if ([self.tableViews indexOfObject:tableView] == 2) {
        for (AddressInfoModel * model in self.districtDataSouce) {
            model.isSelected = NO;
        }
        item = self.districtDataSouce[indexPath.row];
    }
    item.isSelected = YES;
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddressInfoModel * item;
     if([self.tableViews indexOfObject:tableView] == 0){
           item = self.firstArray[indexPath.row];
    }else if([self.tableViews indexOfObject:tableView] == 1){
        item = self.cityDataSouce[indexPath.row];
    }else if ([self.tableViews indexOfObject:tableView] == 2) {
        item = self.districtDataSouce[indexPath.row];
    }
    item.isSelected = NO;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

}

#pragma mark - setter / getter
-(AddressHeadView *)topTabbar{
    
    if (_topTabbar == nil) {
        _topTabbar = [[AddressHeadView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, kHYTopViewHeight)];
        
        [_topTabbar setBackgroundColor:[UIColor yellowColor]];
    }
    return _topTabbar;

}


-(UIScrollView *)contentView{
    
    if (_contentView == nil) {
        CGFloat height = CGRectGetHeight(self.bounds);
        _contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topTabbar.frame), self.frame.size.width, height - kHYTopTabbarHeight)];
        
        [_contentView setBackgroundColor:[UIColor purpleColor]];
        _contentView.contentSize = CGSizeMake(ScreenWidth, 0);
        _contentView.pagingEnabled = YES;
        _contentView.delegate = self;
        
    }
    return _contentView;

}

- (NSMutableArray *)tableViews{
    
    if (_tableViews == nil) {
        _tableViews = [NSMutableArray array];
    }
    return _tableViews;
}

- (NSMutableArray *)topTabbarItems{
    if (_topTabbarItems == nil) {
        _topTabbarItems = [NSMutableArray array];
    }
    return _topTabbarItems;
}


@end
