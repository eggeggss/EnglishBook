//
//  ViewController.m
//  看智障學英文
//
//  Created by RogerRoan on 2016/3/15.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *txtview;

@end

@implementation ViewController
- (IBAction)btn:(id)sender {
    NSLog(@"OK");
    
    [self.txtview resignFirstResponder];
}

- (IBAction)btn_delete:(id)sender {
    [self.appdelegate deleteall];
}

- (IBAction)btn_try:(id)sender {
    
    NSString *us=self.text_us.text;
    
    [Speech Speek:us andSpeed:2.0f andLanguage:Language_en_us];
    
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    
    if([viewController isMemberOfClass:[ViewController2 class]])
    {
        ViewController2 *v2=(ViewController2 *)viewController;
    
        //EnglishBook *book=[self.database refreshEnglishData];
        //v2.book=book;
               
        //book.eng_list;
        //v2.database=self.database;
      
    }

    return  YES;
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.txtview resignFirstResponder];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.txtview setEditable:NO];
    
    //NSLog(@"load");
     /*
    self.tabBarController.delegate=self;
    
    UIColor *lightblue=[UIColor colorWithRed:0/255.0 green:150/255.0 blue:255/255.0 alpha:0.5];
    
    self.text_us.placeholder=@"輸入英文單字";
    
    self.text_us.keyboardType=UIKeyboardTypeASCIICapable;
    
    self.text_us.autocorrectionType=UITextAutocorrectionTypeNo;
    
    [self.text_us addTarget:self action:@selector(textEndAction:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [self.text_us addTarget:self action:@selector(textbeginAction:) forControlEvents:UIControlEventEditingDidBegin];
    
    self.text_chinese.placeholder=@"輸入中文";
    
    [self.text_chinese addTarget:self action:@selector(textEndAction2:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    self.text_chinese.autocorrectionType=UITextAutocorrectionTypeNo;
    
    
    self.text_comm.text=@"";
    self.text_comm.backgroundColor=lightblue;
    
    self.text_comm.autocorrectionType=UITextAutocorrectionTypeNo;
    
    self.appdelegate=[[UIApplication sharedApplication] delegate];
    
    [self.appdelegate refreshEnglishData:10];
    
    [self.appdelegate.en_names enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
    
    
    
    [self.btn_save setTitle:@"Save" forState:UIControlStateNormal];
      
      
      */
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)dismissKeyboard:(id)sender {
    //NSLog(@"TOUCH BACKGROUND");
    [self.text_us resignFirstResponder];
    [self.text_chinese resignFirstResponder];
    [self.text_comm resignFirstResponder];
}

- (IBAction)save:(id)sender {
    
    [self.text_comm resignFirstResponder];
    
    NSString *eng_name=self.text_us.text;
    NSString *ch_name=self.text_chinese.text;
    NSString *common=self.text_comm.text;
    
    [self.appdelegate insertEnglishData:eng_name andChname:ch_name andCommon:common andCommon2:@""];
    //[self.database insertEnglishData:eng_name andChname:ch_name andCommon:common];
    
    self.label_msg.text=@"Save OK";
    [self.text_us setText:@""];
    [self.text_chinese setText:@""];
    [self.text_comm setText:@""];
    
    
    //[self.text_us becomeFirstResponder];
}
-(void) textbeginAction:(UITextField *)textfied
{
    self.label_msg.text=@"";
    //NSLog(@"BEGIN");
}

-(void) textEndAction:(UITextField *) textfied
{
    [self.text_chinese becomeFirstResponder];
    //[self.text_chinese resignFirstResponder];
    //[textfied resignFirstResponder];
}

-(void) textEndAction2:(UITextField *) textfied
{
    [self.text_comm becomeFirstResponder];
    //[self.text_chinese becomeFirstResponder];
    //[self.text_chinese resignFirstResponder];
    //[textfied resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    //self.database=nil;
    self.tabBarController.delegate=nil;
    
    
    // Dispose of any resources that can be recreated.
}

@end







