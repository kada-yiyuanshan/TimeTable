//
//  HelpDataBase.m
//  ContactInformation
//
//  Created by apple  on 12-10-31.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "HelpDataBase.h"
#import "DataBaseBean.h"

#define DB_NAME @"CourseTable.sqlite"

@implementation HelpDataBase

- (id)init
{
    self = [super init];
    if (self) {
        [self opendatabase];
    }
    return self;
}
- (NSString *)dataFilePath
{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:DB_NAME];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (!success) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DB_NAME];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:
                   writableDBPath error:&error];
        if (!success) {
           
        }
    }
    return writableDBPath;
}
-(void)opendatabase
{
        int open=sqlite3_open([self.dataFilePath UTF8String], &database);
        //NSLog(@"open=%d",open);
        if ( open!= SQLITE_OK) {
             sqlite3_close(database);
            NSLog(@"open database error! ");
        }
}

-(void)insertTotable:(DataBaseBean *)info TableName:(NSString *)tablename
{  
    char *error;
    NSString *insertsql=[NSString stringWithFormat:@"insert into %@ (CourseName,Teacher,ClassRoom) VALUES ('%@','%@','%@')",tablename,info.courseName,info.teacherName,info.className];
    int insert=sqlite3_exec(database, [insertsql UTF8String], NULL, NULL, &error);
        //NSLog(@"insert=%d",insert);
       // NSLog(@"error=%s",error);
        if (insert!=SQLITE_OK) {
           NSLog(@"insert data error !");
        sqlite3_close(database);
            
        }
        else
        {
            //NSLog(@"insert data OK !");
        }
    
}

- (void)updateTotable:(DataBaseBean *)info TableName:(NSString *)tablename
{
    char *error;
	NSString *sql = [NSString stringWithFormat:@"update %@ set CourseName= '%@',Teacher= '%@',ClassRoom= '%@' where id = %d",tablename,info.courseName,info.teacherName,info.className,info._id];
    int updata=sqlite3_exec(database, [sql UTF8String], NULL, NULL, &error) ;
	if (updata!= SQLITE_OK) {
        NSLog(@"update error");
		sqlite3_close(database);
	}
	
}

-(void)deleteTotable:(DataBaseBean *)info TableName:(NSString *)tablename
{
    char *szError = 0;
    NSString *sql = [[NSString alloc] initWithFormat:@"delete from %@ where id = %d;",tablename,info._id];
   // NSLog(@"info.UserId=%d",info._id);
    int result = sqlite3_exec(database, [sql UTF8String], 0, 0, &szError);
    if (result != SQLITE_OK) {
        NSLog(@"delete data error!");
        sqlite3_close(database);
    }
    else{
        //NSLog(@"delete data OK!");
    }
   // [sql release];
    
}

-(void)queryTotable:(NSMutableArray *)_arr TableName:(NSString *)tablename
{
    sqlite3_stmt *statement=nil;
    NSString *sql = [[NSString alloc] initWithFormat:@"select * from %@;",tablename] ;
    int get=sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil);
   // NSLog(@"get=%d",get);
    if (get==SQLITE_OK){
        while (sqlite3_step(statement)==SQLITE_ROW)
		{
            NSInteger _id=sqlite3_column_int(statement, 0);
			NSString *coursename=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 1) encoding:NSUTF8StringEncoding];
            NSString *teachername=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 2) encoding:NSUTF8StringEncoding];
            NSString *classname=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 3) encoding:NSUTF8StringEncoding];
            DataBaseBean *databasebean=[[DataBaseBean alloc] initCourseInfo:_id CourseName:coursename TeacherName:teachername ClassName:classname];
            [_arr addObject:databasebean];
            
            [coursename release];
            [teachername release];
            [classname release];
            
		}
		sqlite3_finalize(statement);
        statement = nil;
       
    } else
    {
        sqlite3_close(database);
    }
    [sql release];
}

-(void)insertToTimeTable:(TimeBean *)time_info
{
    char *error;
    
    NSString *insertsql=[NSString stringWithFormat:@"insert into Time (Time) VALUES ('%@')",time_info.time];
    int insert=sqlite3_exec(database, [insertsql UTF8String], NULL, NULL, &error);
    //NSLog(@"insert=%d",insert);
    // NSLog(@"error=%s",error);
    if (insert!=SQLITE_OK) {
        NSLog(@"insert data error !");
        sqlite3_close(database);
        
    }
    else
    {
        //NSLog(@"insert data OK !");
    }

}
-(void)updateToTimeTable:(TimeBean *)time_info
{
    char *error;
    NSString *sql=[NSString stringWithFormat:@"update Time set Time= '%@' where id = %d",time_info.time,time_info.time_ID];
    int updata=sqlite3_exec(database, [sql UTF8String], NULL, NULL, &error) ;
	if (updata!= SQLITE_OK) {
        NSLog(@"update error");
		sqlite3_close(database);
	}
}
-(void)queryToTimeTable:(NSMutableArray *)time_arr
{
    sqlite3_stmt *statement=nil;
    NSString *sql = @"select * from Time;";
    int get=sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil);
    // NSLog(@"get=%d",get);
    if (get==SQLITE_OK){
        while (sqlite3_step(statement)==SQLITE_ROW)
		{
            NSInteger time_id=sqlite3_column_int(statement, 0);
			NSString *time=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 1) encoding:NSUTF8StringEncoding];

            TimeBean *timebean=[[TimeBean alloc] initCourseTime:time_id Time:time];
            [time_arr addObject:timebean];
            
            [time release];
		}
		sqlite3_finalize(statement);
        statement = nil;
        
    } else
    {
        sqlite3_close(database);
    }
    [sql release];

}
//-(NSInteger )getitemcountTotable
//{
//    sqlite3_stmt *pStmt=nil;
//    NSString *sqlcount = @"select * from students";
//    sqlite3_prepare_v2(database, [sqlcount UTF8String], -1, &pStmt, nil);
//    if (SQLITE_ROW == sqlite3_step(pStmt)) {
//    return sqlite3_column_int(pStmt, 0);
//   }
//    return 0;
//}
//

@end
