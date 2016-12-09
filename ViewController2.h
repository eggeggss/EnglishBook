//
//  ViewController2.h
//  看智障學英文
//
//  Created by RogerRoan on 2016/3/15.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnglishBook.h"
#import "AppDelegate.h"
#import "PopupViewController.h"
@interface ViewController2 : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray<English *> *eng_list;
    NSMutableArray *eng_names;
     NSMutableArray *ch_names;
    NSMutableArray *comment;
    NSMutableArray *comment2;
    BOOL lb_show_chines;
}
@property (strong,nonatomic) UIBarButtonItem *showbtn;
@property (strong,nonatomic) AppDelegate *appdelegate;
@property (strong,nonatomic)EnglishBook *book;

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong,nonatomic) UIRefreshControl *refreshControl;


@end


