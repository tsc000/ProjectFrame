//
//  BaseDataBaseModel.m
//  ProjectFrame
//
//  Created by tsc on 17/1/20.
//  Copyright © 2017年 DMS. All rights reserved.
//

#import "BaseDataBaseModel.h"

@implementation BaseDataBaseModel

+ (void)initDataBase:(NSString *)dataBaseName dataSheets:(NSArray *)sheets operation:(void (^)(FMDatabase *db)) block{
    
    [FCModel closeDatabase];
    
    NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite3",dataBaseName]];
    NSLog(@"DB path: %@", dbPath);
    
    [FCModel openDatabaseAtPath:dbPath withDatabaseInitializer:NULL schemaBuilder:^(FMDatabase *db, int *schemaVersion) {
        [db setCrashOnErrors:YES];
        
        // Log every query (useful to learn what FCModel is doing or analyze performance)
        // db.traceExecution = YES;
        
        [db beginTransaction];
        
        void (^failedAt)(int statement) = ^(int statement) {
            // int lastErrorCode = db.lastErrorCode;
            // NSString *lastErrorMessage = db.lastErrorMessage;
            // [db rollback];
            // NSAssert3(0, @"Migration statement %d failed, code %d: %@", statement, lastErrorCode, lastErrorMessage);
        };
        
        if (*schemaVersion < 1) {
            NSString *sql = [self.class getDatabaseSQL:sheets];
            if (![db executeStatements:sql]) failedAt(1);
            
            *schemaVersion = 1;
        }
        
        [db commit];

    }];
    
//    [BaseDataBaseModel openDatabaseAtPath:dbPath withSchemaBuilder:^(FMDatabase *db, int *schemaVersion) {
//        
//        
//    }];
//    
}

# pragma mark - database
+ (NSString *)getDatabaseSQL:(NSArray *)sheets
{
    NSMutableString *mString = [NSMutableString string];
    
    [sheets enumerateObjectsUsingBlock:^(NSString *sheetName, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:sheetName
                                                         ofType:@"sql"];
        NSString *content = [NSString stringWithContentsOfFile:path
                                                      encoding:NSUTF8StringEncoding
                                                         error:NULL];
        
        [mString appendString:content];
    }];

    return mString;
}


@end
