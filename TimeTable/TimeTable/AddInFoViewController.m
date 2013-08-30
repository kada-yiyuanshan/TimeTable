//
//  AddInFoViewController.m
//  TimeTable
//
//  Created by hcui on 13-8-23.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "AddInFoViewController.h"
#import "MoreCell.h"
#import "DataBaseBean.h"
#import "HelpDataBase.h"

@interface AddInFoViewController ()

@end

@implementation AddInFoViewController
@synthesize addTableView;
@synthesize course,classRoom,teacher;
@synthesize tableName;
@synthesize item;
-(void)dealloc
{
    [super dealloc];
    [addTableView release];
    [item release];
    [course release];
    [classRoom release];
    [teacher release];
    [tableName release];
}
#pragma mark - Managing the detail item

- (void)setCourseDetailItem:(id)newDetailItem
{
    if (_courseDetailItem != newDetailItem) {
        [_courseDetailItem release];
        _courseDetailItem = [newDetailItem retain];
    }
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"AddInFoViewController" bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.addTableView.scrollEnabled=NO;
    UIBarButtonItem *rightbutton2=[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAction:)] autorelease];
        self.item.rightBarButtonItem =rightbutton2;
    [self textFieldAlloc];
}
-(void)textFieldAlloc
{
    course = [[UITextField alloc] initWithFrame:CGRectMake(90, 13, 200, 40)];
    course.textAlignment=NSTextAlignmentCenter;
    course.delegate=self;
    
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
    if (self.courseDetailItem) {
        databasebean=self.courseDetailItem;
        databasebean.courseName=self.course.text;
        databasebean.teacherName=self.teacher.text;
        databasebean.className=self.classRoom.text;
        [help updateTotable:databasebean TableName:tableName];
        [self dismissModalViewControllerAnimated:YES];
    }
    [help release];
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
    return 3;
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
        [cell addSubview:classRoom];
    }
    if (2 == indexPath.row) {
        [cell addSubview:teacher];
    }
    
    NSMutableArray *array=[[NSMutableArray alloc] initWithObjects:@"课名:",@"地点:",@"老师:", nil];
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


@end
