//
//  ArchivingData.m
//  Archiving Test
//
//  Created by hcui on 13-8-5.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "ArchivingData.h"


#define kNameKey @"NameKey"
#define kTitleKey @"TitleKey"

@implementation ArchivingData
@synthesize name,titlename;

#pragma mark NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:name forKey:kNameKey];
    [aCoder encodeObject:titlename forKey:kTitleKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        name = [aDecoder decodeObjectForKey:kNameKey];
        titlename = [aDecoder decodeObjectForKey:kTitleKey];
    }
    return self;
}
#pragma mark NSCoping
- (id)copyWithZone:(NSZone *)zone {
    ArchivingData *copy = [[[self class] allocWithZone:zone] init];
    copy.name = [self.name copyWithZone:zone];
    copy.titlename=[self.titlename copyWithZone:zone];
    return copy;
}
@end
