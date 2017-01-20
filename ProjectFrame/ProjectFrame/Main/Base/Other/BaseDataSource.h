//
//  BaseDataSource.h
//  ProjectFrame
//
//  Created by tsc on 17/1/16.
//  Copyright © 2017年 DMS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^TableViewCellConfigureBlock)(id cell, id item, NSIndexPath *indexPath);


@interface BaseDataSource : NSObject<UITableViewDataSource>

/*只有一个cell的情况下使用**/
@property (nonatomic, strong) NSArray *items;

/*只有一个cell的情况下使用**/
- (instancetype)initWithItems:(NSArray *)items
               cellIdentifier:(NSString *)identifier
           configureCellBlock:(TableViewCellConfigureBlock)cellBlock;

/*多个cell的情况下使用**/
@property (nonatomic, strong) NSArray <NSArray *> *dataSourceArray;


/*多个cell的情况下使用**/
- (instancetype)initWithItemsArray:(NSArray <NSArray *>*)itemsArray
                   identifierArray:(NSArray <NSString *>*)identifierArray
                configureCellBlock:(TableViewCellConfigureBlock)cellBlock;



@end
