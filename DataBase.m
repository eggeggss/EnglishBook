//
//  DataBase.m
//  看智障學英文
//
//  Created by RogerRoan on 2016/3/15.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import "DataBase.h"

@implementation DataRandom

NSInteger static const number_count=12;

+(NSMutableArray *) Randata
{
    //NSInteger const test_int=10;
    NSInteger test_int=number_count;
    
    AppDelegate *app=[UIApplication sharedApplication].delegate;
    
    //[app refreshEnglishData:10];
    
    [app refreshEnglishDataAll];
    
    NSMutableArray<English *> *eng_list=app.eng_list;
    
    NSMutableDictionary *dist=[[NSMutableDictionary alloc] init];
    
    [eng_list enumerateObjectsUsingBlock:^(English * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [dist setObject:obj forKey:@(obj.eng_id)];
    }];
    
    NSInteger row_count=eng_list.count;
    
    NSMutableArray *list=[[NSMutableArray alloc] init];
    
    for(int i=0;i<row_count;i++)
    {
        [list addObject:@(i)];
    }
    
    for(int i=0;i<row_count;i++)
    {
        int remaincount=row_count-i;
        int rad= ((arc4random() % remaincount)+i );
    
        [list exchangeObjectAtIndex:i withObjectAtIndex:rad];
    }
    
    if(list.count<test_int)
        test_int=list.count;
    
    NSMutableArray<English *> *list_tmp=[NSMutableArray<English *> new];
    
    for(int idx=0;idx<20  ;idx++)
    {
        NSInteger idx_new=[list[idx] integerValue]+1;
        
        //NSLog(@"%@ ,%i ,%i",((English *)[dist objectForKey:@(idx_new)]).eng_name,idx_new,idx);
        
        English *english=((English *)[dist objectForKey:@(idx_new)]);
        
        if(english!=nil)
          [list_tmp addObject:english];
        
        
    }
    
    
    return [NSMutableArray arrayWithArray:[list_tmp subarrayWithRange:NSMakeRange(0, test_int-1)]];
    
}

@end
