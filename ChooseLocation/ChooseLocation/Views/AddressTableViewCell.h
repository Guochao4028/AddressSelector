//
//  AddressTableViewCell.h
//  ChooseLocation
//
//  Created by 郭超 on 2020/3/31.
//  Copyright © 2020 gucohao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class AddressInfoModel;
@interface AddressTableViewCell : UITableViewCell
@property (nonatomic,strong) AddressInfoModel * item;
@end

NS_ASSUME_NONNULL_END
