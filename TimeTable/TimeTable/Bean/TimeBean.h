//
//  TimeBean.h
//  TimeTable
//
//  Created by hcui on 13-8-22.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeBean : NSObject
{
    NSInteger time_ID;
    NSString *time;

}
@property(nonatomic,assign) NSInteger time_ID;
@property(retain,nonatomic) NSString *time;

-(id)initCourseTime:(NSInteger )time_id Time:(NSString *)time;
@end
