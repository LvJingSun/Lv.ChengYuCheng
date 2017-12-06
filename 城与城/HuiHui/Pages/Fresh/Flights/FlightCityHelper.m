//
//  SearchRecordsHelper.m
//  HuiHui
//
//  Created by mac on 14-11-11.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "FlightCityHelper.h"

#import "FMDatabase.h"

#import "Configuration.h"

#import "CommonUtil.h"


static FMDatabase *db;

@implementation FlightCityHelper

- (id)init {
    if (self = [super init]) {
        if (db == nil) {
//            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

            NSString *documentDirectory = [paths objectAtIndex:0];
            
//            NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID];
            
            //dbPath： 数据库路径，在Document中。
            NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"FlightCity.db"];
            
            NSLog(@"dbPath = %@",dbPath);

            
            db = [FMDatabase databaseWithPath:dbPath];
            if (![db open]) {
                NSLog(@"Could not open db.");
                return self;
            }
           
            // 机票城市列表的数据库-表名
            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS FlightsVersion (type text, ver text)"];
            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS FlightsCity (CityID text, Code text, County text, EnglishName text, Name text)"];

            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS FlightsHotList (CityID text, Code text, County text, EnglishName text, Name text)"];

            
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
    NSString *sql = @"INSERT INTO FlightsCity (CityID, Code, County, EnglishName,Name) VALUES (?,?,?,?,?)";
        
    for (NSDictionary *data in cityList) {
        
        if ([TYPE_FLIGHTSCITY isEqualToString:type]) {
            [db executeUpdate:sql, [data objectForKey:@"CityID"], [data objectForKey:@"Code"], [data objectForKey:@"County"],[data objectForKey:@"EnglishName"],[data objectForKey:@"Name"]];
        }
        
    }
    
    
    [db commit];
    [db close];
    
}

// 读取搜索记录的数组
- (NSMutableArray *)flightCityList{
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return list;
    }
    
    NSString *sql = @"SELECT * FROM FlightsCity";
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next]) {
       
        
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:5];
        
        NSString *CityID = [rs stringForColumn:@"CityID"];
        [data setObject:CityID forKey:@"CityID"];
        
        NSString *Code = [rs stringForColumn:@"Code"];
        [data setObject:Code forKey:@"Code"];
        
        NSString *County = [rs stringForColumn:@"County"];
        [data setObject:County forKey:@"County"];
        
        NSString *EnglishName = [rs stringForColumn:@"EnglishName"];
        [data setObject:EnglishName forKey:@"EnglishName"];
        
        NSString *Name = [rs stringForColumn:@"Name"];
        [data setObject:Name forKey:@"Name"];
        
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
    NSString *sql = @"INSERT INTO FlightsHotList (CityID, Code, County, EnglishName,Name) VALUES (?,?,?,?,?)";
    
    for (NSDictionary *data in hotList) {
        
        [db executeUpdate:sql, [data objectForKey:@"CityID"], [data objectForKey:@"Code"], [data objectForKey:@"County"],[data objectForKey:@"EnglishName"],[data objectForKey:@"Name"]];
        
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
        
        NSString *CityID = [rs stringForColumn:@"CityID"];
        [data setObject:CityID forKey:@"CityID"];
        
        NSString *Code = [rs stringForColumn:@"Code"];
        [data setObject:Code forKey:@"Code"];
        
        NSString *County = [rs stringForColumn:@"County"];
        [data setObject:County forKey:@"County"];
        
        NSString *EnglishName = [rs stringForColumn:@"EnglishName"];
        [data setObject:EnglishName forKey:@"EnglishName"];
        
        NSString *Name = [rs stringForColumn:@"Name"];
        [data setObject:Name forKey:@"Name"];
        
        [list addObject:data];
    }
    
    [rs close];
    [db close];
    return list;

    
}



@end
