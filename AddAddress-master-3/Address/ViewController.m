//
//  ViewController.m
//  Address
//
//  Created by 刘浩浩 on 2017/7/29.
//  Copyright © 2017年 CodingFire. All rights reserved.
//

#import "ViewController.h"
#import "AddressModel.h"
#import "AddressAreaModel.h"
 
#import "MJExtension.h"

@interface ViewController ()
{
    AreaView *areaView;
    NSInteger areaIndex;
    NSMutableArray *area_dataArray1;
    NSMutableArray *area_dataArray2;
    NSMutableArray *area_dataArray3;
    NSMutableArray *area_dataArray4;
    UILabel *areaLabel;
}

@property(nonatomic, strong)NSArray *dataList;

@property(nonatomic, strong)NSIndexPath *countriesIndexPath;
@property(nonatomic, strong)NSIndexPath *provinceIndexPath;
@property(nonatomic, strong)NSIndexPath *cityIndexPath;

@end
CG_INLINE CGRect CGRectMakes(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    float secretNum = [[UIScreen mainScreen] bounds].size.width / 375;
    rect.origin.x = x*secretNum; rect.origin.y = y*secretNum;
    rect.size.width = width*secretNum; rect.size.height = height*secretNum;
    
    return rect;
}
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    areaIndex = 0;
    area_dataArray1 = [[NSMutableArray alloc]init];
    area_dataArray2 = [[NSMutableArray alloc]init];
    area_dataArray3 = [[NSMutableArray alloc]init];
    area_dataArray4 = [[NSMutableArray alloc]init];
    
    areaLabel = [[UILabel alloc]initWithFrame:self.view.bounds];
    areaLabel.numberOfLines = 0;
    areaLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:areaLabel];
    
    [self initData];
    
}

-(void)initData{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"area_list" ofType:@"txt"];
    NSString *content = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
       
    NSArray *array = [self jsonStringToKeyValues:content];
    
    NSArray *modelArray  = [AddressAreaModel mj_objectArrayWithKeyValuesArray:array];
    
    for (AddressAreaModel *model in modelArray) {
        NSArray *tem = [model.childern lastObject];
        model.childern = tem;
    }
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    for(int i=0;i<26;i++){
        NSString *firstCharactor = [NSString stringWithFormat:@"%c",'A'+i];
        
        if ([firstCharactor isEqualToString:@"O"] ||[firstCharactor isEqualToString:@"U"]||[firstCharactor isEqualToString:@"V"]||[firstCharactor isEqualToString:@"Q"]||[firstCharactor isEqualToString:@"I"]) {
            continue;
        }
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:firstCharactor forKey:@"firstLetter"];
        [dataArray addObject:dic];
    }
    
    
    for (NSMutableDictionary *dic in dataArray) {
        NSString *firstLetter = dic[@"firstLetter"];
        
        NSMutableArray *subArray = [NSMutableArray array];
        
        for (AddressAreaModel *model in modelArray) {
            
            NSString *firstCharactor = [self firstCharactor:model.cname];
            if ([firstCharactor isEqualToString:firstLetter] == YES) {
                [subArray addObject:model];
            }
        }
        
        [dic setValue:subArray forKey:@"subArray"];
    }
    
    self.dataList = dataArray;
    
}

-(NSString *)firstCharactor:(NSString *)aString{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return [pinYin substringToIndex:1];
}

- (id)jsonStringToKeyValues:(NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = nil;
    if (JSONData) {
        responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil];
    }
    
    return responseJSON;
}

#pragma mark - AreaSelectDelegate
- (void)selectIndex:(NSInteger)index selectID:(NSString *)areaID
{
    areaIndex = index;
    switch (areaIndex) {
        case 1:
            [area_dataArray2 removeAllObjects];
            break;
        case 2:
            [area_dataArray3 removeAllObjects];
            break;
        case 4:
            [area_dataArray4 removeAllObjects];
        break;
        default:
            break;
    }
    [self requestAllAreaName];
}

- (void)getSelectAddressInfor:(NSString *)addressInfor
{
    areaLabel.text = addressInfor;
}

- (void)selectIndex:(NSInteger)index selectID:(NSString *)areaID selectLoction:(NSIndexPath *)loction
{
    areaIndex = index;
    
    if (index == 1) {
        self.countriesIndexPath = loction;
    }else if (index == 2) {
        self.provinceIndexPath = loction;
    }else if (index == 3) {
        self.cityIndexPath = loction;
    }
    switch (areaIndex) {
        case 1:
            [area_dataArray2 removeAllObjects];
            break;
        case 2:
            [area_dataArray3 removeAllObjects];
            break;
        case 4:
            [area_dataArray4 removeAllObjects];
        break;
        default:
            break;
    }
    [self requestAllAreaName];
}


#pragma mark - requestAllAreaName
- (void)requestAllAreaName{
    if (!areaView) {
        areaView = [[AreaView alloc]initWithFrame:CGRectMakes(0, 0, 375, 667)];
        areaView.hidden = YES;
        areaView.address_delegate = self;
        [[UIApplication sharedApplication].keyWindow addSubview:areaView];
    }
//    NSString *path = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%ld",areaIndex + 1] ofType:@"plist"];
//    NSMutableDictionary *plistDic=[NSMutableDictionary dictionaryWithContentsOfFile:path];
//
//    for (NSDictionary *sh_dic in plistDic[@"data"][@"sh_items"]) {
//        AddressAreaModel *addressAreaModel = [[AddressAreaModel alloc]init];
//        [addressAreaModel setValuesForKeysWithDictionary:sh_dic];
//        switch (areaIndex) {
//            case 0:
//                [area_dataArray1 addObject:addressAreaModel];
//                break;
//            case 1:
//                [area_dataArray2 addObject:addressAreaModel];
//                break;
//            case 2:
//                [area_dataArray3 addObject:addressAreaModel];
//                break;
//            default:
//                break;
//        }
//    }
    switch (areaIndex) {
        case 0:
        {
            [areaView showAreaView];
            [areaView setCountriesArray:[NSMutableArray arrayWithArray:self.dataList]];
        }
            break;
        case 1:{
            
            NSInteger section = self.countriesIndexPath.section;
            NSInteger row = self.countriesIndexPath.row;
            NSDictionary *dic = self.dataList[section];
            NSArray *array = dic[@"subArray"];
            AddressAreaModel *model = array[row];
            if (model.childern.count > 0) {
                [areaView setProvinceArray:[NSMutableArray arrayWithArray:model.childern]];
            }else{
                [areaView hidenAreaView];
            }
        }
            
            break;
        case 2:{
            NSInteger section = self.countriesIndexPath.section;
            NSInteger row = self.countriesIndexPath.row;
            NSDictionary *dic = self.dataList[section];
            NSArray *array = dic[@"subArray"];
            AddressAreaModel *model = array[row];
            AddressAreaModel *provinceModel = model.childern[self.provinceIndexPath.row];
            
            NSArray *a = [provinceModel.childern lastObject];
            if (a.count > 0) {
                [areaView setCityArray:[NSMutableArray arrayWithArray:a]];
            }else{
                [areaView hidenAreaView];
            }
        }
//            [areaView setCityArray:area_dataArray2];
            break;
        case 3:{
            NSInteger section = self.countriesIndexPath.section;
            NSInteger row = self.countriesIndexPath.row;
            NSDictionary *dic = self.dataList[section];
            NSArray *array = dic[@"subArray"];
            AddressAreaModel *model = array[row];
            AddressAreaModel *provinceModel = model.childern[self.provinceIndexPath.row];
            NSArray *provinceArray = [provinceModel.childern lastObject];
            AddressAreaModel *cityModel = provinceArray[self.cityIndexPath.row];
            NSArray *cityArray = [cityModel.childern lastObject];
            if (cityArray.count > 0) {
                [areaView setRegionsArray:[NSMutableArray arrayWithArray:cityArray]];
            }else{
                [areaView hidenAreaView];
            }
        }
//            [areaView setRegionsArray:area_dataArray3];
            break;
        default:
            break;
    }

}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!areaView) {
        [self requestAllAreaName];
    }
    else
        [areaView showAreaView];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
