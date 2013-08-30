//
//  TimeTableViewController.m
//  TimeTable
//
//  Created by hcui on 13-8-20.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "TimeTableViewController.h"
#import "SidebarViewController.h"
#import "CustomCell.h"
#import "MoreInFoViewController.h"
#import "TimeBean.h"
#import "DataBaseBean.h"
#import "HelpDataBase.h"
#import "AddInFoViewController.h"
#import "ArchivingData.h"

#define FRI @"FRI"
#define MON @"MON"
#define THU @"THU"
#define WED @"WED"
#define TUE @"TUE"
#define kArchivingFileKey @"archivingFile.plist"
#define kArchivingDataKey @"ArchivingDataKey"
@interface TimeTableViewController ()

@end

@implementation TimeTableViewController
@synthesize index;
@synthesize amTableView,pmTableView,nightTableView;
@synthesize amTimeArray;
@synthesize pmTimeArray;
@synthesize nightTimeArray;
@synthesize allTimeDataArray;
@synthesize allCourseDataArray;
@synthesize titleLable,titleText;
@synthesize amCourseArray,pmCourseArray,nightCourseArray;
@synthesize week;
@synthesize status;
@synthesize archivingFilePath;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

-(void)dealloc
{
    [super dealloc];
    [allTimeDataArray release];
    self.allTimeDataArray=nil;
    [allCourseDataArray release];
    self.allCourseDataArray=nil;
    [amTableView release];
    [pmTableView release];
    [nightTableView release];
    [amTimeArray release];
    self.amTimeArray=nil;
    [pmTimeArray release];
    self.pmTimeArray=nil;
    [nightTimeArray release];
    self.nightTimeArray=nil;
    [amCourseArray release];
    self.amCourseArray=nil;
    [pmCourseArray release];
    self.pmCourseArray=nil;
    [nightCourseArray release];
    self.nightCourseArray=nil;
    [titleLable release];
    [titleText release];
    [week release];
    [archivingFilePath release];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.amTableView.scrollEnabled = NO;
    self.pmTableView.scrollEnabled = NO;
    self.nightTableView.scrollEnabled = NO;
}
-(void)acrchivingDataManage
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    self.archivingFilePath = [documentsDirectory stringByAppendingPathComponent:kArchivingFileKey];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:self.archivingFilePath]) {
        //如果归档文件存在，则读取其中内容，显示在界面上
        NSData *data = [[NSMutableData alloc] initWithContentsOfFile:self.archivingFilePath];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        ArchivingData *archivingData = [unarchiver decodeObjectForKey:kArchivingDataKey];
        [unarchiver finishDecoding];
        self.week = archivingData.name;
        self.titleLable.text=archivingData.titlename;
    }
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:app];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.titleLable.text=self.titleText;
    [self.amTableView reloadData];
    [self.pmTableView reloadData];
    [self.nightTableView reloadData];
    if (status) {
        if(index==1) {
            self.week=MON;
        }else if(index==2) {
            self.week=TUE;
        }else if(index==3){
            self.week=WED;
        }else if(index==4){
            self.week=THU;
        }else if(index==5){
            self.week=FRI;
        }
    }else
    {
    //[self acrchivingDataManage];

    }
    [self someCourseDataAlloc:week];
    [self someCourseTimeAlloc];
        
}
- (void)applicationWillResignActive:(NSNotification *)notification {
    ArchivingData *archivingData = [[ArchivingData alloc] init];
    archivingData.name = self.week;
    archivingData.titlename =self.titleText;
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:archivingData forKey:kArchivingDataKey];
    [archiver finishEncoding];
    [data writeToFile:self.archivingFilePath atomically:YES];
}

-(void)someCourseTimeAlloc
{
    HelpDataBase *help=[[HelpDataBase alloc] init];
    allTimeDataArray=[[NSMutableArray alloc] init];
    [help queryToTimeTable:allTimeDataArray];
      if ([allTimeDataArray count]==10) {
    amTimeArray=[[NSMutableArray alloc] initWithObjects:[allTimeDataArray objectAtIndex:0],[allTimeDataArray objectAtIndex:1],[allTimeDataArray objectAtIndex:2],[allTimeDataArray objectAtIndex:3], nil];
    pmTimeArray=[[NSMutableArray alloc] initWithObjects:[allTimeDataArray objectAtIndex:4],[allTimeDataArray objectAtIndex:5],[allTimeDataArray objectAtIndex:6],[allTimeDataArray objectAtIndex:7], nil];
    nightTimeArray=[[NSMutableArray alloc] initWithObjects:[allTimeDataArray objectAtIndex:8],[allTimeDataArray objectAtIndex:9], nil];
      }
    [help release];
}
-(void)someCourseDataAlloc:(NSString *)weeks
{
    HelpDataBase *help=[[HelpDataBase alloc] init];
    allCourseDataArray =[[NSMutableArray alloc] init];
    [help queryTotable:allCourseDataArray TableName:weeks];
    if ([allCourseDataArray count]==10) {

        amCourseArray=[[NSMutableArray alloc] initWithObjects:[allCourseDataArray objectAtIndex:0], [allCourseDataArray objectAtIndex:1],[allCourseDataArray objectAtIndex:2],[allCourseDataArray objectAtIndex:3],nil];
        
        pmCourseArray=[[NSMutableArray alloc] initWithObjects:[allCourseDataArray objectAtIndex:4], [allCourseDataArray objectAtIndex:5],[allCourseDataArray objectAtIndex:6],[allCourseDataArray objectAtIndex:7],nil];
        
        nightCourseArray=[[NSMutableArray alloc] initWithObjects:[allCourseDataArray objectAtIndex:8],[allCourseDataArray objectAtIndex:9],nil];
    }
	[help release];

    //    NSLog(@"1==>%d\n2==>%d\n3====>%d",[amCourseArray count],[pmCourseArray count],[nightCourseArray count]);
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.nightTableView==tableView) {
        return 2;
    }
    return 4;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString  *TableSampleIdentifier=@"TableSampleIdentifier";
    
    CustomCell *cell=(CustomCell *)[tableView
                              dequeueReusableCellWithIdentifier: TableSampleIdentifier];
    
    if(cell==nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell"
                                                     owner:self options:nil];
        for (id oneObject in nib)
            if ([oneObject isKindOfClass:[CustomCell class]])
                cell = (CustomCell *)oneObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    DataBaseBean *bean;
    TimeBean *timebean;
    if (self.amTableView==tableView) {
        timebean=[self.amTimeArray objectAtIndex:indexPath.row];
        cell.time.text=timebean.time;
        bean=[self.amCourseArray objectAtIndex:indexPath.row];
        cell.subject.text=bean.courseName;
    }else if(self.pmTableView==tableView)
    {
        timebean=[self.pmTimeArray objectAtIndex:indexPath.row];
        cell.time.text=timebean.time;
        bean=[self.pmCourseArray objectAtIndex:indexPath.row];
        cell.subject.text=bean.courseName;
    }else if(self.nightTableView==tableView)
    {
        timebean=[self.nightTimeArray objectAtIndex:indexPath.row];
        cell.time.text=timebean.time;
        bean=[self.nightCourseArray objectAtIndex:indexPath.row];
        cell.subject.text=bean.courseName;
    }
    if ([bean.courseName isEqualToString:@""]||[bean.teacherName isEqualToString:@""]||[bean.className isEqualToString:@""] ) {
        [cell.moreInfo setTitle:@"添加" forState:UIControlStateNormal];
        [cell.moreInfo addTarget:self action:@selector(addInfoAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    [cell.moreInfo addTarget:self action:@selector(MoreInFoAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
}
-(IBAction)addInfoAction:(id)sender
{
    AddInFoViewController *addView=[[AddInFoViewController alloc] init];
    UITableView *tableview = (UITableView *)[(UITableViewCell *)[[sender superview] superview] superview];
    NSData *courseObject=[self myCourseTableView:tableview _id:sender];
    addView.courseDetailItem = courseObject;
    addView.tableName=self.week;
    [self presentModalViewController:addView animated:YES];
}
-(IBAction)MoreInFoAction:(id)sender
{
    MoreInFoViewController *moreInFo=[[MoreInFoViewController alloc] init];
    UITableView *tableview = (UITableView *)[(UITableViewCell *)[[sender superview] superview] superview];
    NSData *courseObject=[self myCourseTableView:tableview _id:sender];
    NSData *timeObject=[self myTimeTableView:tableview _id:sender];
    moreInFo.timeDetailItem=timeObject;
    moreInFo.courseDetailItem = courseObject;
    moreInFo.tableName=self.week;
    [self presentViewController:moreInFo animated:YES completion:nil];
}
-(NSData *)myCourseTableView:(UITableView *)tableView _id:(id)sender
{
    NSData *object;
    UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath * indexPath = [tableView indexPathForCell:cell];
    if (tableView==self.amTableView) {
        object = [amCourseArray objectAtIndex:indexPath.row];
    }else if(tableView==self.pmTableView){
        object = [pmCourseArray objectAtIndex:indexPath.row];
    }else if(tableView==self.nightTableView){
        object = [nightCourseArray objectAtIndex:indexPath.row];
    }
    return object;
}
-(NSData *)myTimeTableView:(UITableView *)tableView _id:(id)sender
{
    NSData *object;
    UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath * indexPath = [tableView indexPathForCell:cell];
    if (tableView==self.amTableView) {
        object = [amTimeArray objectAtIndex:indexPath.row];
    }else if(tableView==self.pmTableView){
        object = [pmTimeArray objectAtIndex:indexPath.row];
    }else if(tableView==self.nightTableView){
        object = [nightTimeArray objectAtIndex:indexPath.row];
    }
    return object;
}
#pragma mark - ibaction

- (IBAction)showLeftSideBar:(id)sender
{
    if ([[SidebarViewController share] respondsToSelector:@selector(showSideBarControllerWithDirection:)]) {
        [[SidebarViewController share] showSideBarControllerWithDirection:SideBarShowDirectionLeft];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
