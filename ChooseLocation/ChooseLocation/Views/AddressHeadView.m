//
//  AddressHeadView.m
//  ChooseLocation
//
//  Created by 郭超 on 2020/3/31.
//  Copyright © 2020 gucohao. All rights reserved.
//

#import "AddressHeadView.h"

#import "CollectionCell.h"

static NSString *const kCollectionCellIdentifier = @"CollectionCell";

@interface AddressHeadView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong)UICollectionView *collectionView;

@property(nonatomic, strong)UIView * underLine;

@end

@implementation AddressHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCellIdentifier forIndexPath:indexPath];
    cell.model = [self.dataArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CGSizeMake(100, 30);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma mark - getter / setter
-(UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 12;
        layout.minimumInteritemSpacing = 0;
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        CGFloat width = CGRectGetWidth(self.bounds);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, width, 30) collectionViewLayout:layout];
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CollectionCell class]) bundle:nil] forCellWithReuseIdentifier:kCollectionCellIdentifier];
    }
    return _collectionView;
}

-(UIView *)underLine{
    
    if (_underLine == nil) {
        _underLine = [[UIView alloc]initWithFrame:CGRectMake(0, 31, 17, 3)];
        [_underLine setBackgroundColor:[UIColor redColor]];
    }
    return _underLine;

}

-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self.collectionView reloadData];
}

@end
