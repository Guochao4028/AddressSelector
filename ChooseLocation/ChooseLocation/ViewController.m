//
//  ViewController.m
//  ChooseLocation
//
//  Created by 郭超 on 2020/3/31.
//  Copyright © 2020 gucohao. All rights reserved.
//

#import "ViewController.h"

#import <MJExtension/MJExtension.h>

#import "ChooseLocationView.h"

#import "AddressInfoModel.h"

@interface ViewController ()

@property(nonatomic, strong)NSArray *dataArray;
@property (nonatomic,strong)UIView  *cover;
@property (nonatomic,strong)ChooseLocationView *chooseLocationView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self.view addSubview:self.cover];
}

-(void)initData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"area_list" ofType:@"txt"];
    NSString *content = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
       
    NSArray *array = [self jsonStringToKeyValues:content];
    
    self.dataArray  = [AddressInfoModel mj_objectArrayWithKeyValuesArray:array];
}

- (id)jsonStringToKeyValues:(NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = nil;
    if (JSONData) {
        responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil];
    }
    
    return responseJSON;
}

#pragma mark - action

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.cover.hidden = !self.cover.hidden;
    [self.chooseLocationView setDataArray:self.dataArray];
    self.chooseLocationView.hidden = self.cover.hidden;
    CGFloat y = 0;
    if (self.cover.hidden == YES) {
        y = [UIScreen mainScreen].bounds.size.height + 350;
    }else{
       y = [UIScreen mainScreen].bounds.size.height - 350;
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.chooseLocationView.frame =CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, 350);
    }];
    
}

#pragma mark - getter / setter

- (UIView *)cover{

    if (!_cover) {
        _cover = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _cover.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        [_cover addSubview:self.chooseLocationView];
        _cover.hidden = YES;
    }
    return _cover;
}

- (ChooseLocationView *)chooseLocationView{
    
    if (_chooseLocationView == nil) {
       _chooseLocationView = [[ChooseLocationView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 350, [UIScreen mainScreen].bounds.size.width, 350)];
        
        [_chooseLocationView setBackgroundColor:[UIColor whiteColor]];
      
    }
    return _chooseLocationView;
}


@end
