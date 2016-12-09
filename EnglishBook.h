//
//  EnglishBook.h
//  看智障學英文
//
//  Created by RogerRoan on 2016/3/15.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef enum Language
{
    Language_en_us,
    Language_chinese
} LanguageType;

@interface English : NSObject
{
        //static int intMember;
    //static NSNumber  g_id;
}

@property NSInteger eng_id;
@property (strong,nonatomic) NSString *eng_name;
@property (strong,nonatomic) NSString *ch_name;
@property (strong,nonatomic) NSString *common;
@property (strong,nonatomic) NSString *common2;
-(id) init:(NSString *) eng_name andChineseName:(NSString *) ch_name andCommon:(NSString *) common andCommon2:(NSString *) common2;
+(void) ResetGid;
+(NSInteger) ReturnGid;
@end

@interface EnglishBook:NSObject
@property NSInteger *g_id;
@property (strong,nonatomic) NSMutableArray<English *> *eng_list;
-(instancetype) initaBook;
@end

@interface Speech : NSObject
+(void) Speek:(NSString *)content andSpeed:(float) speed andLanguage:(LanguageType) type;

@end

@interface Result:NSObject
@property (strong,nonatomic) NSString *correct;
@property (strong,nonatomic) NSString *wrong;

@end


