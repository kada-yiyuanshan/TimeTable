//
//  DataBaseBean.h
//  ContactInformation
//
//  Created by apple  on 12-10-31.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBaseBean : NSObject
{
    NSInteger _id;
    NSString *courseName;
    NSString *teacherName;
    NSString *className;
}

@property(nonatomic,assign) NSInteger _id;
@property(retain,nonatomic) NSString *courseName;
@property(retain,nonatomic) NSString *teacherName;
@property(retain,nonatomic) NSString *className;

-(id)initCourseInfo:(NSInteger )_idbean CourseName:(NSString *)coursename TeacherName:(NSString *)teachername ClassName:(NSString *)classname;


@end
