//
//  TimeDateViewController.m
//  TimeTable
//
//  Created by hcui on 13-8-20.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "TimeDateViewController.h"
#import "TimeTableViewController.h"
#import "SideBarSelectedDelegate.h"

@interface TimeDateViewController ()

@end

@implementation TimeDateViewController
@synthesize mainTableView,delegate;
@synthesize _dataList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *array=[[NSArray alloc] initWithObjects:@"星期一",@"星期二",@"星期三",@"星期四",@"星期五", nil];
    _dataList = array;
    if ([delegate respondsToSelector:@selector(leftSideBarSelectWithController:)]) {
        [delegate leftSideBarSelectWithController:[self subConWithIndex:0 IndexPathText:@"星期一"]];
        _selectIdnex = 0;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self._dataList count];
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
//-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 30;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString  *TableSampleIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    
    if(cell==nil)
    {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:TableSampleIdentifier] autorelease];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [self._dataList objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if ([delegate respondsToSelector:@selector(leftSideBarSelectWithController:)]) {
        if (indexPath.row == _selectIdnex) {
            [delegate leftSideBarSelectWithController:nil];
        }else
        {
            [delegate leftSideBarSelectWithController:[self subConWithIndex:indexPath.row IndexPathText:cell.textLabel.text]];
        }
        
    }
    _selectIdnex = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (UINavigationController *)subConWithIndex:(int)index IndexPathText:(NSString *)titleText
{
    TimeTableViewController *con = [[TimeTableViewController alloc] initWithNibName:@"TimeTableViewController" bundle:nil];
    con.status=YES;
    con.index = index+1;
    con.titleText=titleText;
    UINavigationController *nav= [[UINavigationController alloc] initWithRootViewController:con];
    nav.navigationBar.hidden = YES;
    return nav ;
}

@end
