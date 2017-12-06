//
//  DBHelper.m
//  baozhifu
//
//  Created by mac on 13-8-21.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "DBHelper.h"
#import "FMDatabase.h"
#import "CommonUtil.h"

static FMDatabase *db;

@implementation DBHelper

-(id)init {
    if (self = [super init]) {
        if (db == nil) {
//            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

            NSString *documentDirectory = [paths objectAtIndex:0];
            //dbPath： 数据库路径，在Document中。
            NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"cityandcity.db"];
            db= [FMDatabase databaseWithPath:dbPath];
            if (![db open]) {
                NSLog(@"Could not open db.");
                return self;
            }
            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS version (type text, ver text)"];
            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS city (type text, code text, name text, category text, sort text)"];
            
            
            
            [db close];
        }
    }
    return self;
}

- (NSDictionary *)queryVersion {
    NSMutableDictionary *verDict = [[NSMutableDictionary alloc] initWithCapacity:5];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return verDict;
    }
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM version"];

    while ([rs next]) {
        NSString *type = [rs stringForColumn:@"type"];
        NSString *ver = [rs stringForColumn:@"ver"];
        [verDict setObject:ver forKey:type];
    }
    [rs close];
    [db close];
    return verDict;
}

- (NSMutableArray *)queryCategory {
    return [self queryData:TYPE_CATEGORY andCategory:@"0"];
}

- (NSMutableArray *)queryProject:(NSString *) categoryId {
    return [self queryData:TYPE_CATEGORY andCategory:categoryId];
}

- (NSMutableArray *)queryCity {
    return [self queryData:TYPE_CITY andCategory:@"0"];
}

- (NSMutableArray *)queryArea:(NSString *) cityId {
    return [self queryData:TYPE_CITY andCategory:cityId];
}

- (NSMutableArray *)queryMerchant:(NSString *) areaId {
    return [self queryData:TYPE_CITY andCategory:areaId];
}

- (NSMutableArray *)queryData:(NSString *)type andCategory:(NSString *)category {
    NSMutableArray *list = [[NSMutableArray alloc] init];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return list;
    }
    NSString *sql = @" SELECT * FROM city where type=? and category=?";
    FMResultSet *rs = [db executeQuery:sql, type, category];
    while ([rs next]) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:5];
        NSString *code = [rs stringForColumn:@"code"];
        [data setObject:code forKey:@"code"];
        NSString *name = [rs stringForColumn:@"name"];
        [data setObject:name forKey:@"name"];
        [list addObject:data];
    }
    [rs close];
    [db close];
    return list;
}

- (void)updateData:(NSArray *)list andType:(NSString *)type andVersion:(NSString *)ver {
    if (![db open]) {
        NSLog(@"Could not open db.");
        return;
    }
    [db beginTransaction];
    [db executeUpdate:@"DELETE FROM version WHERE type=?", type];
    [db executeUpdate:@"INSERT INTO version (type, ver) VALUES (?,?)", type, ver];
    [db executeUpdate:@"DELETE FROM city WHERE type=?", type];
    NSString *sql = @"INSERT INTO city (type, code, name, category) VALUES (?,?,?,?)";
    for (NSDictionary *data in list) {
        if ([TYPE_CITY isEqualToString:type]) {
            [db executeUpdate:sql, type, [data objectForKey:@"CityId"], [data objectForKey:@"CityName"], [data objectForKey:@"ParentId"]];
        }
        if ([TYPE_CATEGORY isEqualToString:type]) {
            [db executeUpdate:sql, type, [data objectForKey:@"ClassId"], [data objectForKey:@"ClassName"], [data objectForKey:@"ParentId"]];
        }
    }
    [db commit];
    [db close];
}



@end
