//
//  SceneryCityHelper.m
//  HuiHui
//
//  Created by mac on 15-1-20.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "SceneryCityHelper.h"

#import "FMDatabase.h"

#import "Configuration.h"

#import "CommonUtil.h"


static FMDatabase *db;

@implementation SceneryCityHelper

- (id)init {
    
    if (self = [super init]) {
        if (db == nil) {
//            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

            NSString *documentDirectory = [paths objectAtIndex:0];
                        
            //dbPath： 数据库路径，在Document中。
            NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"SceneryCity.db"];
            
            NSLog(@"dbPath = %@",dbPath);
            
            
            db = [FMDatabase databaseWithPath:dbPath];
            if (![db open]) {
                NSLog(@"Could not open db.");
                return self;
            }
            
            // 机票城市列表的数据库-表名
            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS FlightsVersion (type text, ver text)"];
            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS FlightsCity (Name text, EnName text, PrefixLetter text, ParentId text, cId text)"];
            
            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS FlightsHotList (Name text, EnName text, PrefixLetter text, ParentId text, cId text)"];
            
            [db close];
            
            
        }
    }
    return self;
}

// 刷新机票里的城市列表
- (void)updateDataFlight:(NSArray *)cityList andType:(NSString *)type andVersion:(NSString *)ver{
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        return;
    }
    [db beginTransaction];
    [db executeUpdate:@"DELETE FROM FlightsVersion WHERE type=?", type];
    [db executeUpdate:@"INSERT INTO FlightsVersion (type, ver) VALUES (?,?)", type, ver];
    [db executeUpdate:@"DELETE FROM FlightsCity"];
    NSString *sql = @"INSERT INTO FlightsCity (Name, EnName, PrefixLetter, ParentId, cId) VALUES (?,?,?,?,?)";
    
   
    
    for (NSDictionary *data in cityList) {
        
        if ([TYPE_SCENERYCITY isEqualToString:type]) {
            [db executeUpdate:sql, [data objectForKey:@"Name"], [data objectForKey:@"EnName"], [data objectForKey:@"PrefixLetter"],[data objectForKey:@"ParentId"],[data objectForKey:@"cId"]];
        }
        
    }
    
    
    [db commit];
    [db close];
    
}

// 读取搜索记录的数组
- (NSMutableArray *)sceneryCityList{
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return list;
    }
    
    NSString *sql = @"SELECT * FROM FlightsCity";
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next]) {
        
        
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:5];
        
        NSString *Name = [rs stringForColumn:@"Name"];
        [data setObject:Name forKey:@"Name"];
        
        NSString *EnName = [rs stringForColumn:@"EnName"];
        [data setObject:EnName forKey:@"EnName"];
        
        NSString *PrefixLetter = [rs stringForColumn:@"PrefixLetter"];
        [data setObject:PrefixLetter forKey:@"PrefixLetter"];
        
        NSString *ParentId = [rs stringForColumn:@"ParentId"];
        [data setObject:ParentId forKey:@"ParentId"];
        
        NSString *cId = [rs stringForColumn:@"cId"];
        [data setObject:cId forKey:@"cId"];
        
        [list addObject:data];
        
    }
    
    [rs close];
    [db close];
    return list;
    
}


// 获取版本信息
- (NSDictionary *)version {
    NSMutableDictionary *verDict = [[NSMutableDictionary alloc] initWithCapacity:5];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return verDict;
    }
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM FlightsVersion"];
    
    while ([rs next]) {
        NSString *type = [rs stringForColumn:@"type"];
        NSString *ver = [rs stringForColumn:@"ver"];
        [verDict setObject:ver forKey:type];
    }
    [rs close];
    [db close];
    return verDict;
}



// 存储历史搜索的城市
- (void)UPdateHotData:(NSMutableArray *)hotList{
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        return;
    }
    [db beginTransaction];
    [db executeUpdate:@"DELETE FROM FlightsHotList"];
    NSString *sql = @"INSERT INTO FlightsHotList (Name, EnName, PrefixLetter, ParentId,cId) VALUES (?,?,?,?,?)";
    
    for (NSDictionary *data in hotList) {
        
        [db executeUpdate:sql, [data objectForKey:@"Name"], [data objectForKey:@"EnName"], [data objectForKey:@"PrefixLetter"],[data objectForKey:@"ParentId"],[data objectForKey:@"cId"]];
        
    }
    
    
    
    
    
    
    [db commit];
    [db close];
    
    
}

- (NSMutableArray *)hotList{
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return list;
    }
    
    NSString *sql = @"SELECT * FROM FlightsHotList";
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next]) {
        
        
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:5];
        
        NSString *Name = [rs stringForColumn:@"Name"];
        [data setObject:Name forKey:@"Name"];
        
        NSString *EnName = [rs stringForColumn:@"EnName"];
        [data setObject:EnName forKey:@"EnName"];
        
        NSString *PrefixLetter = [rs stringForColumn:@"PrefixLetter"];
        [data setObject:PrefixLetter forKey:@"PrefixLetter"];
        
        NSString *ParentId = [rs stringForColumn:@"ParentId"];
        [data setObject:ParentId forKey:@"ParentId"];
        
        NSString *cId = [rs stringForColumn:@"cId"];
        [data setObject:cId forKey:@"cId"];
        
        [list addObject:data];
    }
    
    [rs close];
    [db close];
    return list;
    
    
}




@end
