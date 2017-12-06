//
//  SearchRecordsHelper.m
//  HuiHui
//
//  Created by mac on 14-11-11.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "SearchRecordsHelper.h"

#import "FMDatabase.h"

#import "Configuration.h"


static FMDatabase *db;

@implementation SearchRecordsHelper

- (id)init {
    if (self = [super init]) {
        if (db == nil) {
//            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

            NSString *documentDirectory = [paths objectAtIndex:0];
                        
            //dbPath： 数据库路径，在Document中。
            NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"searchRecords.db"];
            
            db = [FMDatabase databaseWithPath:dbPath];
            if (![db open]) {
                NSLog(@"Could not open db.");
                return self;
            }
            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS searchRecords (searchName text)"];
            
            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS CategoryList (name text,code text)"];

            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS ClassList (name text,code text)"];
            
            [db close];
            
            
        }
    }
    return self;
}

// 刷新搜索记录
- (void)upDateSearch:(NSArray *)upDateSearch{
    
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        return;
    }
    [db beginTransaction];
    //    [db executeUpdate:@"DELETE FROM version WHERE type=?", type];
    //    [db executeUpdate:@"INSERT INTO version (type, ver) VALUES (?,?)", type, ver];
    
    [db executeUpdate:@"DELETE FROM searchRecords"];
    
    NSString *sql = @"INSERT INTO searchRecords (searchName) VALUES (?)";
    
    if ( upDateSearch.count != 0 ) {
        
        for (NSString *string in upDateSearch) {
            
            [db executeUpdate:sql, string];
            
        }
    }
    
    [db commit];
    [db close];
    
}

// 读取搜索记录的数组
- (NSMutableArray *)searchRecordList {
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return list;
    }
    
    NSString *sql = @" SELECT * FROM searchRecords";
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next]) {
//        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:5];
        
        NSString *searchName = [rs stringForColumn:@"searchName"];
//        [data setObject:searchName forKey:@"searchName"];
        
        
        [list addObject:searchName];
    }
    
    [rs close];
    [db close];
    return list;
}

// 删除数据库中的数据
- (BOOL)deleteSearchList{
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

	NSString *documentDir = [paths objectAtIndex:0];
	
	NSString *dbPath = [[NSString alloc] initWithFormat:@"%@/searchRecords.db",documentDir];
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        NSLog(@"数据打开失败");
        
    }
    
    NSString *deleteString = @"delete from searchRecords";
    
    BOOL worked = [db executeUpdate:deleteString];
    
    [db close];
    
    return worked;

    
}



// 分类里显示的数据进行保存数据
- (void)updatecategoryList:(NSArray *)contactList{
    if (![db open]) {
        NSLog(@"Could not open db.");
        return;
    }
    [db beginTransaction];
    //    [db executeUpdate:@"DELETE FROM version WHERE type=?", type];
    //    [db executeUpdate:@"INSERT INTO version (type, ver) VALUES (?,?)", type, ver];
    
    [db executeUpdate:@"DELETE FROM CategoryList"];
    
    NSString *sql = @"INSERT INTO CategoryList (name, code) VALUES (?,?)";
    
    for (NSDictionary *data in contactList) {
        
        [db executeUpdate:sql, [data objectForKey:@"name"], [data objectForKey:@"code"]];
        
    }
    [db commit];
    [db close];
    
}

- (NSMutableArray *)categoryList {
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return list;
    }
    
    NSString *sql = @" SELECT * FROM CategoryList";
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next]) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:5];
        
        NSString *name = [rs stringForColumn:@"name"];
        [data setObject:name forKey:@"name"];
        
        NSString *code = [rs stringForColumn:@"code"];
        [data setObject:code forKey:@"code"];
        
        [list addObject:data];
    }
    
    [rs close];
    [db close];
    return list;
}


// 分类里显示的数据进行保存数据-未选择的分类进行保存
- (void)updateUncategoryList:(NSArray *)contactList{
    if (![db open]) {
        NSLog(@"Could not open db.");
        return;
    }
    [db beginTransaction];
    //    [db executeUpdate:@"DELETE FROM version WHERE type=?", type];
    //    [db executeUpdate:@"INSERT INTO version (type, ver) VALUES (?,?)", type, ver];
    
    [db executeUpdate:@"DELETE FROM ClassList"];
    
    NSString *sql = @"INSERT INTO ClassList (name, code) VALUES (?,?)";
    
    for (NSDictionary *data in contactList) {
        
        [db executeUpdate:sql, [data objectForKey:@"name"], [data objectForKey:@"code"]];
        
    }
    [db commit];
    [db close];
    
}

- (NSMutableArray *)UncategoryList {
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return list;
    }
    
    NSString *sql = @" SELECT * FROM ClassList";
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next]) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:5];
        
        NSString *name = [rs stringForColumn:@"name"];
        [data setObject:name forKey:@"name"];
        
        NSString *code = [rs stringForColumn:@"code"];
        [data setObject:code forKey:@"code"];
        
        [list addObject:data];
    }
    
    [rs close];
    [db close];
    return list;
}




@end
