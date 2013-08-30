//
//  CustomCell.h
//  TimeTable
//
//  Created by hcui on 13-8-21.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
{
    UILabel *time;
    UILabel *subject;
    UIButton *moreInfo;
}
@property (strong,nonatomic) IBOutlet UILabel *time;
@property (strong,nonatomic) IBOutlet UILabel *subject;
@property (strong,nonatomic) IBOutlet UIButton *moreInfo;
@end
