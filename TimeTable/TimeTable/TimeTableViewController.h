//
//  TimeTableViewController.h
//  TimeTable
//
//  Created by hcui on 13-8-20.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *amTableView;
    NSMutableArray *amTimeArray;
    NSMutableArray *amCourseArray;
    
    NSMutableArray *pmTimeArray;
    NSMutableArray *pmCourseArray;
    
    NSMutableArray *nightTimeArray;
    NSMutableArray *nightCourseArray;
    
    UITableView *pmTableView;
    UITableView *nightTableView;
    NSMutableArray *allTimeDataArray;
    NSMutableArray *allCourseDataArray;
    
    NSString *week;
    BOOL status;
}
@property (retain,nonatomic) NSMutableArray *allTimeDataArray;
@property (retain,nonatomic) NSMutableArray *allCourseDataArray;
@property (assign,nonatomic) BOOL status;
@property (retain,nonatomic) NSMutableArray *amTimeArray;
@property (retain,nonatomic) NSMutableArray *amCourseArray;

@property (retain,nonatomic) NSMutableArray *pmTimeArray;
@property (retain,nonatomic) NSMutableArray *pmCourseArray;

@property (retain,nonatomic) NSMutableArray *nightTimeArray;
@property (retain,nonatomic) NSMutableArray *nightCourseArray;

@property (retain,nonatomic) IBOutlet UITableView *amTableView;
@property (retain,nonatomic) IBOutlet UITableView *pmTableView;
@property (retain,nonatomic) IBOutlet UITableView *nightTableView;
@property (assign,nonatomic) int index;
@property (retain,nonatomic) IBOutlet UILabel *titleLable;
@property (retain,nonatomic) NSString *titleText;
@property (retain,nonatomic) NSString *week;

@property (copy, nonatomic) NSString *archivingFilePath;
- (void)applicationWillResignActive:(NSNotification *)notification;
-(IBAction)MoreInFoAction:(id)sender;
@end
