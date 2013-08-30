//
//  MoreInFoViewController.m
//  TimeTable
//
//  Created by hcui on 13-8-21.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "MoreInFoViewController.h"
#import "MoreCell.h"
#import "DataBaseBean.h"
#import "TimeBean.h"
#import "HelpDataBase.h"
#import "SidebarViewController.h"

@interface MoreInFoViewController ()

@end

@implementation MoreInFoViewController
@synthesize moreTableView;
@synthesize course,time,classRoom,teacher;
@synthesize tableName;
@synthesize item;
@synthesize OkButton,CancelButton;
@synthesize actionSheet;
@synthesize timePickerView;
@synthesize minuteArray,secondArray;
@synthesize returnStr;
@synthesize minuteSheetText,secondSheetText;

#pragma mark - Managing the detail item
- (void)setCourseDetailItem:(id)newDetailItem
{
    if (_courseDetailItem != newDetailItem) {
        [_courseDetailItem release];
        _courseDetailItem = [newDetailItem retain];
    }
}
- (void)setTimeDetailItem:(id)newDetailItem
{
    if (_timeDetailItem != newDetailItem) {
        [_timeDetailItem release];
        _timeDetailItem = [newDetailItem retain];
    }
}
-(void)dealloc
{
    [super dealloc];
    [minuteSheetText release];
    [secondSheetText release];
    [returnStr release];
    [item release];
    [moreTableView release];
    [course release];
    [time release];
    [classRoom release];
    [teacher release];
    [tableName release];
    [minuteArray release];
    [timePickerView release];
    [actionSheet release];
    [OkButton release];
    [CancelButton release];
    [secondArray release];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"MoreInFoViewController" bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    [self someTingSet];
}
-(void)someTingSet
{
    buttonStatus=YES;
    [self textFieldAlloc];
    [self textFieldText];
    if (buttonStatus==YES) {
        self.item.rightBarButtonItem=self.editButtonItem;
        editStatus=NO;
        [self textColor];
    }
    self.moreTableView.scrollEnabled=NO;
    minuteArray=[[NSMutableArray alloc] init];
    NSString *minute;
    for (int i=0;i<24; i++) {
        if (i<9) {
            minute =[NSString stringWithFormat:@"0%d",i+1];
        }else{
            minute=[NSString stringWithFormat:@"%d",i+1];
        }
        [minuteArray insertObject:minute atIndex:i];
    }
    secondArray=[[NSMutableArray alloc] init];
    NSString *second;
    for (int i=0;i<60; i++) {
        if (i<9) {
            second=[NSString stringWithFormat:@"0%d",i+1];
        }else{
            second=[NSString stringWithFormat:@"%d",i+1];
        }
        [secondArray insertObject:second atIndex:i];
    }
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    
    UIBarButtonItem *rightbutton2=[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAction:)] autorelease];
    if (editing) {
        self.item.rightBarButtonItem =rightbutton2;
        editStatus=YES;
        [self textColor];
    }
}
-(void)textFieldText
{
    DataBaseBean *databasebean;
    TimeBean *timebean;
    if (self.courseDetailItem) {
        databasebean=self.courseDetailItem;
        self.course.text=databasebean.courseName;
        self.teacher.text=databasebean.teacherName;
        self.classRoom.text=databasebean.className;
    }
    if (self.timeDetailItem) {
        timebean=self.timeDetailItem;
    }
    self.time.text=timebean.time;
}
-(void)textColor
{
    if (!editStatus) {
        self.course.textColor=[UIColor grayColor];
        self.course.enabled=NO;
        self.time.textColor=[UIColor grayColor];
        self.time.enabled=NO;
        self.classRoom.textColor=[UIColor grayColor];
        self.classRoom.enabled=NO;
        self.teacher.textColor=[UIColor grayColor];
        self.teacher.enabled=NO;
    }else
    {
        self.course.textColor=[UIColor blackColor];
        self.course.enabled=YES;
        self.time.textColor=[UIColor blackColor];
        self.time.enabled=NO;
        self.classRoom.textColor=[UIColor blackColor];
        self.classRoom.enabled=YES;
        self.teacher.textColor=[UIColor blackColor];
        self.teacher.enabled=YES;
    }
    
}
-(void)textFieldAlloc
{
    course = [[UITextField alloc] initWithFrame:CGRectMake(90, 13, 200, 40)];
    course.textAlignment=NSTextAlignmentCenter;
    course.delegate=self;
    
    time = [[UITextField alloc] initWithFrame:CGRectMake(90, 13, 200, 40)];
    time.textAlignment=NSTextAlignmentCenter;
    time.delegate=self;
    
    classRoom = [[UITextField alloc] initWithFrame:CGRectMake(90, 13, 200, 40)];
    classRoom.textAlignment=NSTextAlignmentCenter;
    classRoom.delegate=self;
    
    teacher = [[UITextField alloc] initWithFrame:CGRectMake(90, 13, 200, 40)];
    teacher.textAlignment=NSTextAlignmentCenter;
    teacher.delegate=self;

}

-(IBAction)saveAction:(id)sender
{
    DataBaseBean *databasebean;
    HelpDataBase *help=[[HelpDataBase alloc]init];
    TimeBean *timebean;
    if (self.courseDetailItem) {
        databasebean=self.courseDetailItem;
        if (self.timeDetailItem) {
            timebean=self.timeDetailItem;
        }
        if ([self.time.text isEqualToString:@""]) {
            [self messageTitle:@"上课时间不能为空！"];
        }else
        {
        timebean.time=self.time.text;
        databasebean.courseName=self.course.text;
        databasebean.teacherName=self.teacher.text;
        databasebean.className=self.classRoom.text;
        [help updateTotable:databasebean TableName:tableName];
        [help updateToTimeTable:timebean];
        [self dismissModalViewControllerAnimated:YES];
        }
    }
    [help release];
}
-(void)messageTitle:(NSString *)message
{
    UIAlertView *alerview=[[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alerview show];
    [alerview release];
}
#pragma make - TextField

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.textAlignment=NSTextAlignmentCenter;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString  *TableSampleIdentifier=@"TableSampleIdentifier";
    MoreCell *cell=(MoreCell *)[tableView
                                    dequeueReusableCellWithIdentifier: TableSampleIdentifier];
    
    if(cell==nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MoreCell"
                                                     owner:self options:nil];
        for (id oneObject in nib)
            if ([oneObject isKindOfClass:[MoreCell class]])
                cell = (MoreCell *)oneObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (0 == indexPath.row) {
        
        [cell addSubview:course];
    
    }
    if (1 == indexPath.row) {
        cell.settingTime.hidden=NO;
        [cell addSubview:time];

    }
    if (2 == indexPath.row) {
        [cell addSubview:classRoom];
    }
    if (3 == indexPath.row) {
        [cell addSubview:teacher];
    }
   [cell.settingTime addTarget:self action:@selector(ShowSheet) forControlEvents:UIControlEventTouchUpInside];
    NSMutableArray *array=[[NSMutableArray alloc] initWithObjects:@"课名:",@"时间:",@"地点:",@"老师:", nil];
    cell.name.text=[array objectAtIndex:indexPath.row];
    [array release];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)backAction:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
-(void)ShowSheet
{
    NSString *title = UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation) ? @"\n\n\n\n\n\n\n\n\n" : @"\n\n\n\n\n\n\n\n\n\n\n\n" ;
    actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    [actionSheet  showInView:self.view];
    self.timePickerView =  [[[UIPickerView  alloc] initWithFrame:CGRectMake(0, 45, 320, 215)] autorelease];
    self.timePickerView .delegate = self;
    self.timePickerView .dataSource =self;
    self.timePickerView .showsSelectionIndicator  =  YES ;
    [self.timePickerView setAccessibilityTraits:UIAccessibilityTraitPlaysSound];
    self.timePickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [actionSheet addSubview:timePickerView];
    CGRect frame1=CGRectMake(10, 8, 70, 29);
    CancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
    CancelButton.frame=frame1;
    [CancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [CancelButton setBackgroundImage:[[UIImage imageNamed:@"dialog_button_normal.png"]stretchableImageWithLeftCapWidth:12 topCapHeight:0] forState:UIControlStateNormal];
    [CancelButton setBackgroundImage:[[UIImage imageNamed:@"dialog_button_active.png"]stretchableImageWithLeftCapWidth:12 topCapHeight:0] forState:UIControlStateHighlighted];
    [CancelButton addTarget:self action:@selector(CancelButtonclick:) forControlEvents:UIControlEventTouchUpInside];
    
    [actionSheet addSubview:CancelButton ];
    
    CGRect frame2=CGRectMake(235, 8, 70, 29);
    OkButton=[UIButton buttonWithType:UIButtonTypeCustom];
    OkButton.frame=frame2;
    [OkButton setTitle:@"确定" forState:UIControlStateNormal];
    [OkButton setBackgroundImage:[[UIImage imageNamed:@"dialog_button_normal.png"]stretchableImageWithLeftCapWidth:12 topCapHeight:0] forState:UIControlStateNormal];
    [OkButton setBackgroundImage:[[UIImage imageNamed:@"dialog_button_active.png"]stretchableImageWithLeftCapWidth:12 topCapHeight:0] forState:UIControlStateHighlighted];
    [OkButton addTarget:self action:@selector(notfacation) forControlEvents:UIControlEventTouchUpInside];
    [actionSheet addSubview:OkButton ];
    [actionSheet  showInView:self.view];
    minuteSheetText=NSLocalizedString(@"01",@"");
    secondSheetText=NSLocalizedString(@"01",@"");
}
-(IBAction)CancelButtonclick:(id)sender
{
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}
#pragma mark -
#pragma mark UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component==0) {
       
        minuteSheetText=[minuteArray objectAtIndex:row%24];
    }
    if (component==1) {
        secondSheetText=[secondArray objectAtIndex:row%60];
    }
//    NSLog(@"text==>%@\n%@",minuteSheetText,secondSheetText);
}
-(void)notfacation{
	//获取当前时间
	NSDate* now = [NSDate date];
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps = [[NSDateComponents alloc] init];
	NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
	NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
	comps = [calendar components:unitFlags fromDate:now];
	hours = [comps hour];
	minutes = [comps minute];
	seconds = [comps second];
	
	htime1=[minuteSheetText integerValue];
	mtime1=[secondSheetText integerValue];
	
	hs=htime1-hours;
	ms=mtime1-minutes;
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
	//设置弹出框提醒用户
	UIAlertView *at=[[UIAlertView alloc] initWithTitle:@"!"
											   message:[NSString stringWithFormat:@"你设置的时间:%i:%i ",htime1,mtime1]
											  delegate:nil
                                     cancelButtonTitle:@"确定"
                                     otherButtonTitles:@"关闭",nil];
	[at setDelegate:self];
	[at show];
	[at release];
}

#pragma mark alertview delegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        //计算多少秒后闹钟响应时间
        int hm=(hs*3600)+(ms*60)-seconds;
        //建立后台消息对象
        app=[UIApplication sharedApplication];
        UILocalNotification *notification=[[UILocalNotification alloc] init];
        if (notification!=nil)
        {
            notification.repeatInterval=NSDayCalendarUnit;
            NSDate *now1=[NSDate new];
            notification.fireDate=[now1 dateByAddingTimeInterval:hm];
            notification.timeZone=[NSTimeZone defaultTimeZone];
            notification.soundName = @"懒猪起床.caf";
            notification.alertBody = [NSString stringWithFormat:NSLocalizedString(@"猪,现在时间是: %i:%i.",nil),htime1 ,mtime1];
            [app scheduleLocalNotification:notification];
            [now1 release];
        }

    }else {
        NSLog(@"222---2222");
    }
}

#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if (component==0) {
        returnStr = [minuteArray objectAtIndex:row%24];
    }
    if (component==1) {
        returnStr = [secondArray objectAtIndex:row%60];
    }
	return returnStr;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	CGFloat componentWidth = 0.0;
    
	if (component == 0)
		componentWidth = 150.0;	// first column size is wider to hold names
	else
		componentWidth = 150.0;	// second column is narrower to show numbers
    
	return componentWidth;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	return 40.0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger countnumber=0;
    if (component==0) {
        countnumber=[minuteArray count]*1000;
    }
    if(component==1){
        countnumber=[secondArray count]*1000;
    }
    return countnumber;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(12.0f, 0.0f, [pickerView rowSizeForComponent:component].width-12, [pickerView rowSizeForComponent:component].height)] autorelease];
    label.backgroundColor=[UIColor clearColor];
    [label setFont:[UIFont boldSystemFontOfSize:30]];
    if (component==0) {
        [label setText:[minuteArray objectAtIndex:row%24]];
    }
    if (component==1) {
        [label setText:[secondArray objectAtIndex:row%60]];
    }
    [label setTextAlignment:UITextAlignmentCenter];
    return label;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 2;
}

@end
