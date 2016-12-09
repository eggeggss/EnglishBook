//
//  AppDelegate.m
//  看智障學英文
//
//  Created by RogerRoan on 2016/3/15.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


-(void) createEnglishDB
{
    NSString *dbpath=[NSString stringWithFormat:@"%@/Documents/engdb.db",NSHomeDirectory()];
    
    if(sqlite3_open([dbpath UTF8String], &self->Englishdb)==SQLITE_OK)
    {
        
    }
}

-(void) createEnglishTable
{
    const char *sql="create table if not exists engdb (id integer primary key autoincrement, eng_name text , ch_name text ,common text ,common2 text ,wrong_count integer )";
    
    char *err;
    
    if(sqlite3_exec(Englishdb, sql, NULL, NULL, &err)==SQLITE_OK)
    {
        NSLog(@"create table ok");
    }
}

-(void) updateEnglish:(NSString *) eng_name andChinesename:(NSString *) ch_name andComment:(NSString *) comment andComment2:(NSString *) comment2
{

    char *err;
    
    NSString *comment3= [comment2 stringByReplacingOccurrencesOfString:@"'" withString:@""""];
    
    NSString *sql2=[NSString stringWithFormat:@"update engdb set ch_name='%@' , common='%@' ,common2='%@' where eng_name='%@' ;",ch_name ,comment,comment3,eng_name];
    
   // NSLog(@"%@",sql2);
    //sql2 datau
    
    NSData *data=[sql2 dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    const char *sql=[data bytes];
    
    if(sqlite3_exec(Englishdb, sql, NULL, NULL, &err)==SQLITE_OK)
    {
        NSLog(@"update table ok");
    }
    else
    {
        NSLog(@"update error %s",err);
    }
}

-(void)insertEnglishData:(NSString *) eng_name andChname:(NSString *) ch_name andCommon:(NSString *)common andCommon2:(NSString *) common2
{
    char *err;
    
    NSString *common3= [common2 stringByReplacingOccurrencesOfString:@"'" withString:@""""];
    
    NSString *sql2=[NSString stringWithFormat:@"insert into engdb (eng_name, ch_name, common ,common2) values('%@','%@','%@','%@');",eng_name,ch_name,common,common3];
    
    NSLog(@"%@",sql2);
    
    NSData *data=[sql2 dataUsingEncoding:NSUTF8StringEncoding];
    
    const char *sql=[data bytes];
    
    if(sqlite3_exec(Englishdb, sql, NULL, NULL, &err)==SQLITE_OK)
    {
        NSLog(@"insert table ok");
    }
    else
    {
       NSLog(@"insert error %s",err);
    }
}


-(void)deleteEnglish:(NSString *)eng_name
{
    char *err;
    
    NSString *sql2=[NSString stringWithFormat:@"delete from engdb where eng_name='%@'",eng_name];
    
    
    NSData *data=[sql2 dataUsingEncoding:NSUTF8StringEncoding];
    
    const char *sql=[data bytes];
    
    if(sqlite3_exec(Englishdb, sql, NULL, NULL, &err)==SQLITE_OK)
    {
        NSLog(@"delet table ok");
    }
    else
    {
        NSLog(@"delte error %s",err);
    }
}



-(void)deleteall
{
    char *err;
    
    NSString *sql2=[NSString stringWithFormat:@"delete from engdb "];
    
    NSData *data=[sql2 dataUsingEncoding:NSUTF8StringEncoding];
    
    const char *sql=[data bytes];
    
    if(sqlite3_exec(Englishdb, sql, NULL, NULL, &err)==SQLITE_OK)
    {
        //NSLog(@"delet table ok");
    }
    else
    {
        //NSLog(@"delte error %s",err);
    }
}




-(void) refreshEnglishDataAll
{
    NSString *eng_name,*ch_name,*common,*common2;
    
    NSString *str_sql=@"select eng_name,ch_name,common,common2 from engdb order by id desc;";
    
    NSData *str_data=[str_sql dataUsingEncoding:NSASCIIStringEncoding];
    
    const char *sql=[str_data bytes];
    
    //NSLog(@"%s",sql);
    //const char *sql="select eng_name,ch_name,common,common2 from engdb order by id desc";
    
    sqlite3_stmt *stmt;
    
    English *english;
    
    self.en_names=[NSMutableArray new];
    self.ch_names=[NSMutableArray new];
    self.comment=[NSMutableArray new];
    self.comment2=[NSMutableArray new];
    
    [self.eng_list removeAllObjects];
    
    if( sqlite3_prepare(Englishdb, sql, -1, &stmt, NULL)==SQLITE_OK)
    {
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            
            eng_name=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
            
            ch_name=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
            common=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];
            
            common2=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 3)];
            
            [self.en_names addObject:eng_name];
            [self.ch_names addObject:ch_name];
            [self.comment addObject:common];
            [self.comment2 addObject:common2];
            
            english=[[English alloc] init:eng_name andChineseName:ch_name andCommon:common andCommon2:common2];
            
            [self.eng_list addObject:english];
            
        }
        sqlite3_finalize(stmt);
        self.book.eng_list =self.eng_list;
    }
    
}

-(void) refreshEnglishData:(NSInteger) count
{
    NSString *eng_name,*ch_name,*common,*common2;
    
    //NSString *str_sql=@"select eng_name,ch_name,common,common2 from engdb order by id desc LIMIT 10;";
    NSString *str_sql=[NSString stringWithFormat:@"select eng_name,ch_name,common,common2 from engdb order by id desc LIMIT %i;",count];
    
    NSData *str_data=[str_sql dataUsingEncoding:NSASCIIStringEncoding];
    
    const char *sql=[str_data bytes];
    
    //NSLog(@"%s",sql);
    //const char *sql="select eng_name,ch_name,common,common2 from engdb order by id desc";
    
    sqlite3_stmt *stmt;
    
    English *english;
    
    self.en_names=[NSMutableArray new];
    self.ch_names=[NSMutableArray new];
    self.comment=[NSMutableArray new];
    self.comment2=[NSMutableArray new];
    
    [self.eng_list removeAllObjects];
    
    if( sqlite3_prepare(Englishdb, sql, -1, &stmt, NULL)==SQLITE_OK)
    {
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            
            eng_name=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
            
            ch_name=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
            common=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];
            
            common2=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 3)];
            
            [self.en_names addObject:eng_name];
            [self.ch_names addObject:ch_name];
            [self.comment addObject:common];
            [self.comment2 addObject:common2];
            
            english=[[English alloc] init:eng_name andChineseName:ch_name andCommon:common andCommon2:common2];
            
             [self.eng_list addObject:english];
            
        }
        sqlite3_finalize(stmt);
        self.book.eng_list =self.eng_list;
    }

}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self createEnglishDB];
    [self createEnglishTable];
    
    self.eng_list=[NSMutableArray<English *> new];
    
    self.book=[[EnglishBook alloc] init];
    
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
