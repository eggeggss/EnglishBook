//
//  PopupViewController.m
//  看智障學英文
//
//  Created by RogerRoan on 2016/3/21.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import "PopupViewController.h"

@interface PopupViewController ()
{
    BOOL stored_flag;
    NSMutableString  *xmlcontent;
}
@property (weak, nonatomic) IBOutlet UITextField *txt_eng;
@property (weak, nonatomic) IBOutlet UITextField *txt_ch;
@property (weak, nonatomic) IBOutlet UITextField *txt_comment;
@property (weak, nonatomic) IBOutlet UITextView *txt_comment2;

@end

@implementation PopupViewController

#pragma delegate
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    if([elementName isEqualToString:@"DataSet"])
    {
        self->book=[Book new];
    }
    
    if([elementName isEqualToString:@"Translation"])
    {
        self->stored_flag=YES;
    }
    
    if([elementName isEqualToString:@"Orig"])
    {
        self->stored_flag=YES;
    }
    
    if([elementName isEqualToString:@"Trans"])
    {
        self->stored_flag=YES;
    }
    //NSLog(@"%@",elementName);
}
-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self->stored_flag)
    {
        self->xmlcontent=[[NSMutableString alloc] initWithString:string];
    }
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //the end
    if ([elementName isEqualToString:@"DataSet"])
    {
        
        [self.txt_ch setText:self->book.ch_name];
         self.txt_comment2.text=self->book.translate;
       // NSLog(@"%@",self->book.ch_name);
    }
    
    
    if(self->stored_flag)
    {
        if ([elementName isEqualToString:@"Translation"])
        {
            
            [self->book.ch_name setString:self->xmlcontent];
            
        }
        
        if ([elementName isEqualToString:@"Orig"])
        {
            NSString *content=[NSString stringWithFormat:@"%@ \n",self->xmlcontent];
            
            [self->book.translate appendString:content];
            
        }
    
        
        if ([elementName isEqualToString:@"Trans"])
        {
            NSString *content=[NSString stringWithFormat:@"%@ \n",self->xmlcontent];
            
            [self->book.translate appendString:content];

            
        }

        [self->xmlcontent setString:@""];
        
        self->stored_flag=NO;
    }
}

-(void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"%@",parseError.description);
}



 NSString const *urlstr=@"http://fy.webxml.com.cn/webservices/EnglishChinese.asmx/Translator?wordkey=";

- (IBAction)btn_dissmiss:(id)sender {
    //NSLog(@"BACKGROUP");
    [self.txt_eng resignFirstResponder];
    [self.txt_ch resignFirstResponder];
    [self.txt_comment resignFirstResponder];
    [self.txt_comment2 resignFirstResponder];
}

- (IBAction)btn_online:(id)sender {
}

-(void) PopMessage:(NSString *)msg
{
    UIAlertController *cot;
    
    cot=[UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:cot animated:YES completion:^{
    
        int duration = 0.5; // duration in seconds
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            
            [cot dismissViewControllerAnimated:YES completion:^{
                
            }];
            //[toast dismissWithClickedButtonIndex:0 animated:YES];
        });
    }];
    
    
}

- (IBAction)btn_save:(id)sender {
    
    NSString *eng_name=self.txt_eng.text;
    NSString *ch_name=self.txt_ch.text;
    NSString *comment=self.txt_comment.text;
    NSString *comment2=self.txt_comment2.text;
    
        switch (self->actiontype) {
        case ActionTypeUpdateType:
            
                [self.appdelegate updateEnglish:eng_name andChinesename:ch_name andComment:comment andComment2:comment2 ];
                
                [self performSelector:@selector(PopMessage:) withObject:@"Save OK"];
                
            break;
        case ActionTypeInsertType:
            
            [self.appdelegate insertEnglishData:eng_name andChname:ch_name andCommon:comment andCommon2:comment2];
            [self.txt_eng setText:@""];
            [self.txt_ch setText:@""];
            [self.txt_comment setText:@""];
            [self.txt_comment2 setText:@""];
            [self.txt_eng becomeFirstResponder];
            
            [self performSelector:@selector(PopMessage:) withObject:@"Inserted"];
                
                
            break;
        default:
            break;
    }
}

- (IBAction)btn_delete:(id)sender {
    
    UIAlertController *alertcon=[UIAlertController alertControllerWithTitle:@"Information" message:@"Are You Sure To Delete?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action2=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.appdelegate deleteEnglish:self.eng_name];
        [self performSelector:@selector(btnBK:) withObject:self];
    }];
    
    [alertcon addAction:action2];
    [alertcon addAction:action];
    
    [self presentViewController:alertcon animated:YES completion:^{
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.appdelegate=[UIApplication sharedApplication].delegate;
    
    UIBarButtonItem *left=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(btnBK:)];
    
    UIToolbar *toolbar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 17, self.view.frame.size.width,44)];
    
    toolbar.barTintColor=[UIColor orangeColor];
    
    toolbar.tintColor=[UIColor lightTextColor];

    NSArray *items=[[NSArray alloc] initWithObjects:left, nil];
    
    [toolbar setItems:items];
    
    [self.view addSubview:toolbar];

    self.txt_eng.keyboardType=UIKeyboardTypeASCIICapable;
    
    self.txt_eng.autocorrectionType=UITextAutocorrectionTypeNo;
    
    self.txt_ch.keyboardType=UIKeyboardTypeDefault;
    
    self.txt_ch.autocorrectionType=UITextAutocorrectionTypeNo;
    
    self.txt_comment.keyboardType=UIKeyboardTypeASCIICapable;
    
    self.txt_comment.autocorrectionType=UITextAutocorrectionTypeNo;
    
    self.txt_comment2.keyboardType=UIKeyboardTypeASCIICapable;
    
    self.txt_comment2.autocorrectionType=UITextAutocorrectionTypeNo;
    
    
}

- (IBAction)btn_check_online:(id)sender {
    
    NSString *eng_name=self.txt_eng.text;
    
    NSString *querystr=[NSString stringWithFormat:@"%@%@",urlstr,eng_name ];
    
    NSURL *url=[NSURL URLWithString:querystr];
    
    self->parse=[[NSXMLParser alloc] initWithContentsOfURL:url];
    [self->parse setShouldProcessNamespaces:NO];
    [self->parse setShouldReportNamespacePrefixes:NO];
    [self->parse setShouldResolveExternalEntities:NO];
    self->parse.delegate=self;
    
    [Speech Speek:eng_name andSpeed:2.0f andLanguage:Language_en_us];
    
    [self->parse parse];
}


-(IBAction)btnBK:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) viewWillAppear:(BOOL)animated
{
   
    [self.txt_eng setText:self.english.eng_name];
    [self.txt_ch setText:self.english.ch_name];
    [self.txt_comment setText:self.english.common];
    [self.txt_comment2 setText:self.english.common2];
    //NSLog(@"%@",self.english.common2);
}


-(void) setActionType:(ActionType )type
{
    self->actiontype=type;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


@implementation Book
-(instancetype) init
{
    self.ch_name=[NSMutableString stringWithString:@""];
    self.translate=[NSMutableString stringWithString:@""];
    //NSLog(@"book init");
    
    return self;
}


@end


