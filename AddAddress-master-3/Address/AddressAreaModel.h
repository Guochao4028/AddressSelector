//
//  AddressAreaModel.h
//  Shihanbainian
//
//  Created by apple on 2017/7/13.
//  Copyright © 2017年 Codeliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressAreaModel : NSObject
//@property(nonatomic,strong)NSString *sh_id;
//@property(nonatomic,strong)NSString *sh_name;
//@property(nonatomic,strong)NSString *sh_parentid;


@property(nonatomic, copy)NSString *addressId;

@property(nonatomic, copy)NSString *cname;

@property(nonatomic, copy)NSString *name;

@property(nonatomic, copy)NSString *pinyinName;

@property(nonatomic, copy)NSArray *childern;

@end
