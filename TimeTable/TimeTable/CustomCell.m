//
//  CustomCell.m
//  TimeTable
//
//  Created by hcui on 13-8-21.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "CustomCell.h"

@interface CustomCell ()

@end

@implementation CustomCell
@synthesize time,moreInfo,subject;

-(void)dealloc
{
    [super dealloc];
    [subject release];
    [time release];
    [moreInfo release];
}
@end
