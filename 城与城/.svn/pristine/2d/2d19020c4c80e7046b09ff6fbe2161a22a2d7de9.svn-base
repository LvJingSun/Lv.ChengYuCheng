//
//  Hotel_CitylistDB.m
//  HuiHui
//
//  Created by 冯海强 on 14-12-8.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "Hotel_CitylistDB.h"
#import "FMDatabase.h"
#import "CommonUtil.h"

static FMDatabase *db;

@implementation Hotel_CitylistDB

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
            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS Hversion (CityVersion text)"];
            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS Hcity (CityId text, CityName text)"];
            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS Hhistory (CityId text, CityName text)"];
            [db close];
        }
    }
    return self;
}

- (NSString *)queryVersion {
    NSString *ver = @"";
    if (![db open]) {
        NSLog(@"Could not open db.");
    }
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM Hversion"];
    while ([rs next]) {
        ver = [rs stringForColumn:@"CityVersion"];
    }
    [rs close];
    [db close];
    return ver;
}

- (NSMutableArray *)queryCity {
    return [self queryData];
}

- (NSMutableArray *)queryHChistory {
    return [self queryHChistoryData];
}

- (NSMutableArray *)queryData {
    NSMutableArray *list = [[NSMutableArray alloc] init];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return list;
    }
    NSString *sql = @" SELECT * FROM Hcity";
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next]) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:5];
        NSString *code = [rs stringForColumn:@"CityId"];
        [data setObject:code forKey:@"CityId"];
        NSString *name = [rs stringForColumn:@"CityName"];
        [data setObject:name forKey:@"CityName"];
        [list addObject:data];
    }
    [rs close];
    [db close];
    return list;
}

- (NSMutableArray *)queryHChistoryData {
    NSMutableArray *list = [[NSMutableArray alloc] init];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return list;
    }
    NSString *sql = @" SELECT * FROM Hhistory";
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next]) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:5];
        NSString *code = [rs stringForColumn:@"CityId"];
        [data setObject:code forKey:@"CityId"];
        NSString *name = [rs stringForColumn:@"CityName"];
        [data setObject:name forKey:@"CityName"];
        [list addObject:data];
    }
    [rs close];
    [db close];
    return list;
}

- (void)updateData:(NSArray *)list andVersion:(NSString *)ver {
    if (![db open]) {
        NSLog(@"Could not open db.");
        return;
    }
    [db beginTransaction];
    [db executeUpdate:@"DELETE FROM Hversion"];
    [db executeUpdate:@"INSERT INTO Hversion (CityVersion) VALUES (?)", ver];
    [db executeUpdate:@"DELETE FROM Hcity"];
    NSString *sql = @"INSERT INTO Hcity (CityId, CityName) VALUES (?,?)";
    for (NSDictionary *data in list) {
            [db executeUpdate:sql,[data objectForKey:@"CityId"], [data objectForKey:@"CityName"]];
    }
    [db commit];
    [db close];
}

- (void)updateHChistoryData:(NSArray *)list{
    if (![db open]) {
        NSLog(@"Could not open db.");
        return;
    }
    [db beginTransaction];
    [db executeUpdate:@"DELETE FROM Hhistory"];
    NSString *sql = @"INSERT INTO Hhistory (CityId, CityName) VALUES (?,?)";
    for (NSDictionary *data in list) {
        [db executeUpdate:sql,[data objectForKey:@"CityId"], [data objectForKey:@"CityName"]];
    }
    [db commit];
    [db close];
}


@end
