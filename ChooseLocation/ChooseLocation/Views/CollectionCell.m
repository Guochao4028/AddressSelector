//
//  CollectionCell.m
//  ChooseLocation
//
//  Created by 郭超 on 2020/3/31.
//  Copyright © 2020 HY. All rights reserved.
//

#import "CollectionCell.h"

@interface CollectionCell ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation CollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setModel:(NSMutableDictionary *)model{
    
    NSLog(@"model : %@", model);
    
    NSString *title = model[@"title"];
    
    
    
    [self.button setTitle:title forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor colorWithRed:43/255.0 green:43/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [self.button sizeToFit];
     
    [self.button addTarget:self action:@selector(topBarItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)topBarItemClick:(UIButton *)sender{
    
}

@end
