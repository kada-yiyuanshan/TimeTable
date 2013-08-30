//
//  MoreInFoViewController.h
//  TimeTable
//
//  Created by hcui on 13-8-21.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreInFoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UINavigationBarDelegate,UIActionSheetDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIAlertViewDelegate,UIApplicationDelegate>
{
    UITableView *moreTableView;
    UITextField *course;
    UITextField *time;
    UITextField *classRoom;
    UITextField *teacher;
    UINavigationItem *item;
    BOOL buttonStatus;
    BOOL editStatus;
    UIPickerView *timePickerView;
    UIButton *OkButton,*CancelButton;
    UIActionSheet *actionSheet;
    NSMutableArray *minuteArray;
    NSMutableArray *secondArray;
    
    UIApplication *app;
	int hours,minutes,seconds;
	int htime1,mtime1;
	int hs,ms;
}
@property (retain,nonatomic) NSString *minuteSheetText,*secondSheetText;
@property (retain,nonatomic) NSMutableArray *minuteArray,*secondArray;
@property (retain,nonatomic) UIPickerView *timePickerView;
@property (retain,nonatomic) UIButton *OkButton,*CancelButton;
@property (retain,nonatomic) UIActionSheet *actionSheet;
@property (strong, nonatomic) UITextField *course;
@property (strong, nonatomic) UITextField *time;
@property (strong, nonatomic) UITextField *classRoom;
@property (strong, nonatomic) UITextField *teacher;
@property (strong, nonatomic) id courseDetailItem;
@property (strong, nonatomic) id timeDetailItem;
@property (retain, nonatomic) NSString *tableName;
@property (retain, nonatomic) IBOutlet UINavigationItem *item;
@property (retain,nonatomic) NSString *returnStr;

@property (retain,nonatomic) IBOutlet UITableView *moreTableView;
-(IBAction)backAction:(id)sender;
-(IBAction)saveAction:(id)sender;
@end
