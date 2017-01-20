//
//  BaseDataSource.m
//  ProjectFrame
//
//  Created by tsc on 17/1/16.
//  Copyright © 2017年 DMS. All rights reserved.
//

#import "BaseDataSource.h"

@interface BaseDataSource ()

@property (nonatomic, copy) NSString *identifier;

@property (nonatomic, copy) TableViewCellConfigureBlock cellBlock;

@property (nonatomic, strong) NSArray *identifierArray;

@property (nonatomic, strong) NSArray *breakpoint;

@end


@implementation BaseDataSource

- (instancetype)initWithItems:(NSArray *)items
               cellIdentifier:(NSString *)identifier
           configureCellBlock:(TableViewCellConfigureBlock)cellBlock {
    
    if (self = [super init]) {
        self.items = items;
        self.identifier = identifier;
        self.cellBlock = cellBlock;
    }
    
    return self;
}


- (instancetype)initWithItemsArray:(NSArray <NSArray *>*)itemsArray
                   identifierArray:(NSArray <NSString *>*)identifierArray
                configureCellBlock:(TableViewCellConfigureBlock)cellBlock {
    
    if (self = [super init]) {
        
        self.identifierArray = identifierArray;
        
        self.cellBlock = cellBlock;
        
        self.dataSourceArray = itemsArray;
        
    }
    
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return self.items[(NSUInteger) indexPath.row];
}

- (void)setDataSourceArray:(NSArray<NSArray *> *)dataSourceArray {
    
    _dataSourceArray = dataSourceArray;
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithObject:@"0"];
    
    NSMutableArray *itemsArray = [NSMutableArray array];
    
    __block NSInteger sum = 0;
    
    for (NSInteger i = 0 ; i < _dataSourceArray.count; i ++) {
        sum += _dataSourceArray[i].count;
        
        [tempArray addObject:[NSString stringWithFormat:@"%ld",sum]];
        
        [itemsArray addObjectsFromArray:_dataSourceArray[i]];
        NSLog(@"%@---idx:%ld",tempArray,i);
    }
    
    //妈蛋，这个遍历有缓存，导致breakpoint数据不正确
    //    [_dataSourceArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(NSArray * obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //
    //        sum += obj.count;
    //
    //        [tempArray addObject:[NSString stringWithFormat:@"%ld",sum]];
    //
    //        [itemsArray addObjectsFromArray:obj];
    //        NSLog(@"%@---idx:%ld",tempArray,idx);
    //
    //    }];
    
    self.breakpoint = [NSArray arrayWithArray:tempArray];
    
    self.items = [NSArray arrayWithArray:itemsArray];
}

#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __block NSInteger index;
    
    [self.breakpoint enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (indexPath.row < [obj integerValue]) {
            
            *stop = YES;
        }
        
        index = idx;
        
    }];
    
    if (self.identifierArray.count != 0) {
        
        self.identifier = self.identifierArray[index - 1];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.identifier
                                                            forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    id item = [self itemAtIndexPath:indexPath];
    
    self.cellBlock(cell, item, indexPath);
    
    return cell;
}

@end
