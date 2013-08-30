//
//  HelpDataBase.h
//  ContactInformation
//
//  Created by apple  on 12-10-31.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "DataBaseBean.h"
#import "TimeBean.h"

@interface HelpDataBase : NSObject
{
    sqlite3 *database;
}

-(void)opendatabase;

-(void)insertTotable:(DataBaseBean *)info TableName:(NSString *)tablename;
-(void)updateTotable:(DataBaseBean *)info TableName:(NSString *)tablename;
-(void)deleteTotable:(DataBaseBean *)info TableName:(NSString *)tablename;
-(void)queryTotable:(NSMutableArray *)_arr TableName:(NSString *)tablename;
//time
-(void)insertToTimeTable:(TimeBean *)time_info;
-(void)updateToTimeTable:(TimeBean *)time_info;
-(void)queryToTimeTable:(NSMutableArray *)time_arr;
@end
