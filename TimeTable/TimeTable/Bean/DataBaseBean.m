//
//  DataBaseBean.m
//  ContactInformation
//
//  Created by apple  on 12-10-31.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "DataBaseBean.h"

@implementation DataBaseBean

@synthesize courseName,teacherName,className;
@synthesize _id;

-(id)initCourseInfo:(NSInteger )_idbean CourseName:(NSString *)coursename TeacherName:(NSString *)teachername ClassName:(NSString *)classname;
{
    self=[super init];
    
    if (self) {
        self._id=_idbean;
        self.courseName=coursename;
        self.teacherName=teachername;
        self.className=classname;
    }
  
    return self;
}


-(void)dealloc
{
    [courseName release];
    [teacherName release];
    [className release];
    [super dealloc];
}


@end
