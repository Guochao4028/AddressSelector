//
//  AddressAreaModel.m
//  Shihanbainian
//
//  Created by apple on 2017/7/13.
//  Copyright © 2017年 Codeliu. All rights reserved.
//

#import "AddressAreaModel.h"



@implementation AddressAreaModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"addressId" : @"id",
             };
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"childern" : @"AddressAreaModel"};
}
@end
