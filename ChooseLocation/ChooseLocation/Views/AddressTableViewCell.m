//
//  AddressTableViewCell.m
//  ChooseLocation
//
//  Created by 郭超 on 2020/3/31.
//  Copyright © 2020 gucohao. All rights reserved.
//

#import "AddressTableViewCell.h"

#import "AddressInfoModel.h"

@interface AddressTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectFlag;

@end

@implementation AddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setItem:(AddressInfoModel *)item{
    _item = item;
    _addressLabel.text = item.cname;
     NSLog(@"item.cname > %@",item.cname);
    NSLog(@"item.isSelected > %d",item.isSelected);
    
    _addressLabel.textColor = item.isSelected ? [UIColor orangeColor] : [UIColor blackColor] ;
    _selectFlag.hidden = !item.isSelected;
}

@end
