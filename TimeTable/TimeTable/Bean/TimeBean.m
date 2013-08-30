//
//  TimeBean.m
//  TimeTable
//
//  Created by hcui on 13-8-22.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "TimeBean.h"

@implementation TimeBean
@synthesize time;
@synthesize time_ID;
-(id)initCourseTime:(NSInteger )time_id Time:(NSString *)course_time
{
    self=[super init];
    if (self) {
        self.time_ID=time_id;
        self.time=course_time;
    }
    return self;

}
-(void)dealloc
{
    [super dealloc];
    [time release];
}
@end
