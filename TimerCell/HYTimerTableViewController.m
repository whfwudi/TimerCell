//
//  HYTimerTableViewController.m
//  TimerCell
//
//  Created by 100lishi on 16/12/12.
//  Copyright © 2016年 whfwudi. All rights reserved.
//

#import "HYTimerTableViewController.h"
#import "CountDown.h"
#import "HYTimerTableViewCell.h"

@interface HYTimerTableViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *dataSource;//时间数组
}
@property (strong, nonatomic)  CountDown *countDown;

@end

@implementation HYTimerTableViewController

-(void)updateTimeInVisibleCells
{
    NSArray *cells = self.tableView.visibleCells;
    for (HYTimerTableViewCell *cell in cells) {
        cell.countDownLabel.text = [self getNowTimeWithString:dataSource[cell.tag]];
//        if ([cell.countDownLabel.text isEqualToString:@"活动已经结束！"]) {
//            cell.countDownLabel.textColor = [UIColor redColor];
//        }else{
//            cell.countDownLabel.textColor = [UIColor orangeColor];
//        }
    }
}

-(NSString *)getNowTimeWithString:(NSString *)aTimeString
{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 截止时间date格式
    NSDate  *expireDate = [formater dateFromString:aTimeString];
    NSDate  *nowDate = [NSDate date];
    // 当前时间字符串格式
    NSString *nowDateStr = [formater stringFromDate:nowDate];
    // 当前时间date格式
    nowDate = [formater dateFromString:nowDateStr];
    
    NSTimeInterval timeInterval =[expireDate timeIntervalSinceDate:nowDate];
    
    int days = (int)(timeInterval/(3600*24));
    int hours = (int)((timeInterval-days*24*3600)/3600);
    int minutes = (int)(timeInterval-days*24*3600-hours*3600)/60;
    int seconds = timeInterval-days*24*3600-hours*3600-minutes*60;
    
    NSString *dayStr;NSString *hoursStr;NSString *minutesStr;NSString *secondsStr;
    //天
    dayStr = [NSString stringWithFormat:@"%d",days];
    //小时
    hoursStr = [NSString stringWithFormat:@"%d",hours];
    //分钟
    if(minutes<10)
        minutesStr = [NSString stringWithFormat:@"0%d",minutes];
    else
        minutesStr = [NSString stringWithFormat:@"%d",minutes];
    //秒
    if(seconds < 10)
        secondsStr = [NSString stringWithFormat:@"0%d", seconds];
    else
        secondsStr = [NSString stringWithFormat:@"%d",seconds];
    if (hours<=0 && minutes<=0 && seconds<=0) {
        return @"活动已经结束！";
    }
    if (days) {
        return [NSString stringWithFormat:@"%@天 %@小时 %@分 %@秒", dayStr,hoursStr, minutesStr,secondsStr];
    }
    return [NSString stringWithFormat:@"%@小时 %@分 %@秒",hoursStr , minutesStr,secondsStr];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataSource = @[@"2016-12-13 22:23:49",@"2016-12-14 14:23:43",@"2016-12-15 14:23:14",@"2016-12-16 14:23:41",@"2016-12-17 14:11:46",@"2016-12-18 14:23:23",@"2016-12-19 14:23:43",@"2016-12-20 14:12:45",@"2016-12-21 14:23:22",@"2016-12-22 14:23:40",@"2016-12-23 14:13:40",@"2016-12-24 14:23:45",@"2016-12-25 14:23:45",@"2016-12-26 14:14:41",@"2016-12-27 14:23:50",@"2016-12-28 14:23:45",@"2016-12-29 14:15:42",@"2016-12-30 14:23:51",@"2017-01-01 14:28:45",@"2017-01-02 14:16:43",@"2017-01-03 14:23:52",@"2017-01-04 14:29:45",@"2017-01-05 14:17:44",@"2017-01-06 14:23:53",@"2017-01-07 14:30:45",@"2017-01-08 14:18:45",@"2017-01-09 14:23:54",@"2017-01-10 14:31:01",@"2017-02-01 14:19:30",@"2017-02-02 14:23:55",@"2017-02-03 14:32:02",@"2017-02-04 14:20:31",@"2017-03-01 14:23:56",@"2017-03-02 14:33:03",@"2017-03-03 14:21:12",@"2017-03-07 14:23:45",@"2017-04-02 14:34:04",@"2017-04-03 14:23:32",@"2017-04-04 14:23:49",@"2017-04-05 14:04:05",@"2017-05-05 14:23:05",@"2017-06-02 14:24:09",@"2017-07-05 14:14:06"];
    self.countDown = [[CountDown alloc] init];
    __weak __typeof(self) weakSelf = self;
    ///每秒回调一次
    [self.countDown countDownWithPER_SECBlock:^{
        NSLog(@"6");
        [weakSelf updateTimeInVisibleCells];
    }];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 100;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYTimerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.countDownLabel.text = [self getNowTimeWithString:dataSource[indexPath.row]];
    cell.tag = indexPath.row;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)dealloc
{
    NSLog(@"%s dealloc",object_getClassName(self));
}

@end
