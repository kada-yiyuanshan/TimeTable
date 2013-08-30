//
//  ArchivingData.h
//  Archiving Test
//
//  Created by hcui on 13-8-5.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArchivingData : NSObject<NSCoding,NSCopying>
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *titlename;
@end
