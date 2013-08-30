//
//  TimeDateViewController.h
//  TimeTable
//
//  Created by hcui on 13-8-20.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SideBarSelectDelegate;
@interface TimeDateViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_dataList;
    int _selectIdnex;
}
@property (retain ,nonatomic) NSArray *_dataList;
@property (strong,nonatomic)IBOutlet UITableView *mainTableView;
@property (assign,nonatomic) id<SideBarSelectDelegate> delegate;
@end
