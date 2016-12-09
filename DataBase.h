//
//  DataBase.h
//  看智障學英文
//
//  Created by RogerRoan on 2016/3/15.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "EnglishBook.h"
#import "AppDelegate.h"
@interface DataRandom : NSObject
{
  sqlite3 *Englishdb;
}
+(NSMutableArray *) Randata;
@end


