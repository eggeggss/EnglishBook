//
//  ExameViewController.h
//  多益單字本
//
//  Created by RogerRoan on 2016/3/24.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBase.h"
@interface ExameViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDataSource,UITableViewDelegate>

@end


@interface  ResultClass : NSObject
@property (strong,nonatomic) NSString *correct;
@property (strong,nonatomic) NSString *wrong;
@end