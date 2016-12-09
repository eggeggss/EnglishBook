//
//  AppDelegate.h
//  看智障學英文
//
//  Created by RogerRoan on 2016/3/15.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "EnglishBook.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
  sqlite3 *Englishdb;
  
}
@property (strong,nonatomic) EnglishBook *book;
@property NSMutableArray *en_names;
@property NSMutableArray *ch_names;
@property NSMutableArray *comment;
@property NSMutableArray *comment2;
@property NSMutableArray<English *> *eng_list;
@property (strong, nonatomic) UIWindow *window;

+(instancetype) initEnglishDb;
-(void)createEnglishDB;
-(void)createEnglishTable;
-(void)insertEnglishData:(NSString *) eng_name andChname:(NSString *) ch_name andCommon:(NSString *)common andCommon2:(NSString *) common2;
-(void)deleteall;
-(void)deleteEnglish:(NSString *)eng_name;
-(void) refreshEnglishDataAll;
-(void) refreshEnglishData:(NSInteger) count;
-(void) updateEnglish:(NSString *) eng_name andChinesename:(NSString *) ch_name andComment:(NSString *) comment andComment2:(NSString *) comment2;


@end

