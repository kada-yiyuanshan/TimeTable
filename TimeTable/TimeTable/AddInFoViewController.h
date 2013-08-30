//
//  AddInFoViewController.h
//  TimeTable
//
//  Created by hcui on 13-8-23.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddInFoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UINavigationBarDelegate,UITextFieldDelegate>
{
    UITableView *addTableView;
    UITextField *course;
    UITextField *classRoom;
    UITextField *teacher;
    UINavigationItem *item;
}
@property (strong,nonatomic) UITextField *course;
@property (strong,nonatomic) UITextField *classRoom;
@property (strong,nonatomic) UITextField *teacher;
@property (strong, nonatomic) id courseDetailItem;
@property (retain,nonatomic) NSString *tableName;
@property (retain,nonatomic) IBOutlet UINavigationItem *item;
@property(retain,nonatomic) IBOutlet UITableView *addTableView;

@end
