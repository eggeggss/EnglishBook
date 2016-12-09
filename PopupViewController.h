//
//  PopupViewController.h
//  看智障學英文
//
//  Created by RogerRoan on 2016/3/21.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnglishBook.h"
#import "AppDelegate.h"
@class Book;
typedef enum Action
{
  ActionTypeInsertType,
  ActionTypeUpdateType
} ActionType;

@interface PopupViewController : UIViewController<NSXMLParserDelegate>
{
    ActionType actiontype;
    NSXMLParser *parse;
    Book *book;
}
@property (strong,nonatomic) EnglishBook *english_book;
@property (strong,nonatomic) AppDelegate *appdelegate;
@property (strong,nonatomic) NSString *eng_name;
@property (strong,nonatomic) NSString *ch_name;
@property (strong,nonatomic) NSString *comment;
@property (strong,nonatomic) NSString *comment2;
@property (strong,nonatomic) English *english;
-(void) setActionType:(ActionType )type;

@end

@interface Book : NSObject
-(instancetype) init;
@property NSMutableString *ch_name;
@property NSMutableString *translate;

@end
