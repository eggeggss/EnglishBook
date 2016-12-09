//
//  ExameViewController.m
//  多益單字本
//
//  Created by RogerRoan on 2016/3/24.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import "ExameViewController.h"

@interface  UIButton1 :UIButton
- (void)setFrame:(CGRect)frame ;
@end

@implementation UIButton1

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
}

@end

@interface ExameViewController ()
{
    UIView *view;
}
@property (strong,nonatomic)NSMutableArray<Result *> *err_list;

@property (weak, nonatomic) IBOutlet UIStackView *stackview1;

@property (weak, nonatomic) IBOutlet UIButton1 *btn_rand;
@property (weak, nonatomic) IBOutlet UIButton *btn_read;
@property (weak, nonatomic) IBOutlet UIButton *btn_check;

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UITextView *txt_ans;

@property (weak, nonatomic) IBOutlet UITextField *txt_input;
@property (weak, nonatomic) IBOutlet UILabel *label_msg;

@property (strong,nonatomic) CALayer *layer_btn_rand;
@property (strong,nonatomic) CALayer *layer_btn_read;
@property (strong,nonatomic) CALayer *layer_btn_check;

@property (strong,nonatomic) NSMutableArray *question_list;
@property (strong,nonatomic) NSMutableArray *ch_ans;

@property (weak, nonatomic) IBOutlet UIPickerView *pickrow;
@property (strong,nonatomic) English *anwser;
@end

@implementation ExameViewController

NSInteger current_number=0;



-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.err_list.count;    //return self->eng_names.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell2=[[UITableViewCell alloc] init];
    
    cell2.accessoryType=UITableViewCellAccessoryNone;

    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    
    UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(0, 40, tableView.frame.size.width, 40)];
    
    
    Result *result=self.err_list[indexPath.row];
    
    //result.wrong
    
    label.text=[NSString stringWithFormat:@"錯誤答案:%@",result.wrong];
    label2.text=[NSString stringWithFormat:@"正確答案:%@",result.correct];
    
    
    label.textColor=[UIColor blueColor];
    label2.textColor=[UIColor redColor];
    
    label.textAlignment=NSTextAlignmentCenter;
    label2.textAlignment=NSTextAlignmentCenter;
    
    [cell2.contentView addSubview:label];
    [cell2.contentView addSubview:label2];
    
    return cell2;
}


#pragma radom
- (IBAction)btn:(id)sender {
    
    //[self performSelector:@selector(correctMs)];
    
    current_number=0;
    
    self.err_list=nil;
    self.err_list=[[NSMutableArray<Result *> alloc] init];
    
    self.question_list=nil;
    self.question_list=[DataRandom Randata];
    self.ch_ans=nil;
    self.ch_ans=[NSMutableArray new];
    
    [self.question_list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [self.ch_ans addObject:((English *)obj).ch_name];
        
    }];
    
    [self.pickrow reloadAllComponents];
    
    [self performSelector:@selector(nextAnswer)];
    
}

-(void) alertErrMsg
{
    if (self->view !=nil)
    {
        [self->view removeFromSuperview];
        self->view=nil;
    }
    self->view=[[UIView alloc] initWithFrame:CGRectMake(10, 50, 300, 300)];
    
    self->view.center=CGPointMake(self.view.frame.size.width/2, 300);
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self->view.frame.size.width, 30)];
    
    [label setText:@"Error List"];
    
    label.font=[UIFont boldSystemFontOfSize:24];
    
    label.textAlignment=NSTextAlignmentCenter;
    
    label.textColor=[UIColor blueColor];
    
    UITableView *tv=[[UITableView alloc] initWithFrame:CGRectMake(0, 30, 300, 200)];
    
    tv.dataSource=self;
    tv.delegate=self;
    
    [tv reloadData ];
    
    UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(0, 250, self->view.frame.size.width, 50)];
    
    [button setTitle:@"ok" forState:UIControlStateNormal];
    
    button.backgroundColor=[UIColor blackColor];
    
    [button addTarget:self action:@selector(btnok:) forControlEvents:UIControlEventTouchUpInside];
    
    [self->view addSubview:label];
    [self->view addSubview:tv];
    [self->view addSubview: button];
    self->view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self->view];

    [self performSelector:@selector(inputout:) withObject:self];

}

-(void) correctMs
{
    
    if (self->view !=nil)
    {
        [self->view removeFromSuperview];
        self->view=nil;
    }
    
    self->view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/1.1, self.view.frame.size.height/3)];
    
    self->view.backgroundColor=[UIColor clearColor];
    
    self->view.center=CGPointMake(self.view.frame.size.width/2, 200);
    
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self->view.frame.size.width, 50)];
    title.text=@"沒有放鞭炮一下";
    title.textAlignment=NSTextAlignmentCenter;
    title.alpha=0;
    //title.backgroundColor=[UIColor blackColor];
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 50, self->view.frame.size.width, self->view.frame.size.height/1.8)];
    
    label.text=@"全部答對!";
    
    label.font=[UIFont boldSystemFontOfSize:24];
    //label.backgroundColor=[UIColor blueColor];
    
    label.textAlignment=NSTextAlignmentCenter ;
    
    label.alpha=0;
    
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(0, self->view.frame.size.width/2, self->view.frame.size.width, self->view.frame.size.height/3)];
    
    [btn setTitle:@"OK" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(btnok:) forControlEvents:UIControlEventTouchUpInside];
    
    btn.backgroundColor=[UIColor blackColor];
    
    [self->view addSubview:title];
    [self->view addSubview:label];
    
    [self->view addSubview:btn];
    
    [self.view addSubview:self->view];

    //[self.txt_ans resignFirstResponder];
    
    [self performSelector:@selector(touchbackground:) withObject:self];
    
    [UIView animateWithDuration:1 animations:^{
        label.alpha=1;
    } completion:^(BOOL finished) {
        
        [self performSelector:@selector(showTitle:) withObject:title];
        
    }];
    
}

-(void) showTitle:(id) sender
{
    UILabel *label=(UILabel *)sender;
    
    [UIView animateWithDuration:1 animations:^{
        label.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
    
    //NSLog(@"ok1");
    
}


-(IBAction) btnok:(UIButton *) sender
{
    [UIView animateWithDuration:1.0f animations:^{
        self->view.alpha=0;
    } completion:^(BOOL finished) {
        [self->view removeFromSuperview];
    }];
        //NSLog(@"HEELO");
}


#pragma 隨便念一下
- (IBAction)read_action:(id)sender {
    
    //NSLog(@"1=>%li",(long)current_number);
    
    English *english=(English *)[self.question_list objectAtIndex:current_number];
    
    [Speech Speek:english.eng_name andSpeed:2.0f andLanguage:Language_en_us];
    
}

- (IBAction)btn_next:(id)sender {
    NSMutableString *result;
    NSMutableString *ans;
    NSString *txt_as=self.txt_input.text;
    
    English *english=(English *)[self.question_list objectAtIndex:current_number];
    
    
    if ([txt_as isEqualToString:english.eng_name])
    {
        result=[NSMutableString stringWithString:@"Correct"];
    }else
    {
        result=[NSMutableString stringWithString:@"Wrong"];
        
        Result *result2=[[Result alloc] init];
        result2.correct=english.eng_name;
        result2.wrong=txt_as;
        
        [self.err_list addObject:result2];
    }
    
    ans=[NSMutableString stringWithFormat:@"Wrong   Ans:%@ \n Correct Ans:%@ \n %@",txt_as,english.eng_name,english.ch_name];
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:result message:ans preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:^{
        
        [self.txt_input setText:@""];
        
        [self.txt_ans setText:english.common2];
        
        [self performSelector:@selector(nextAnswer)];
        
    }];
    
}

- (IBAction)touchbackground:(id)sender {

    [self.txt_ans resignFirstResponder];
    [self.txt_input resignFirstResponder];
}

#pragma pickrow

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return  (NSString *)[self.ch_ans objectAtIndex:row];
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return  self.ch_ans.count;
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(void) nextAnswer
{
    if (current_number>9)
    {
        
        if(self.err_list.count>0)
        {
          [self performSelector:@selector(alertErrMsg)];
        }else
        {
            [self performSelector:@selector(correctMs)];
        }
        
        
        current_number=0;
        
        self.question_list=nil;
        self.question_list=[DataRandom Randata];
        self.ch_ans=nil;
        self.ch_ans=[NSMutableArray new];
        
        [self.question_list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self.ch_ans addObject:((English *)obj).ch_name];
            
        }];
        
        [self.pickrow reloadAllComponents];

        //重抽
        //[self performSelector:@selector(btn:) withObject:nil];
    }
    
    self.anwser=[self.question_list objectAtIndex:current_number];
    
    [self.label_msg setAlpha:0];
    
    [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [self.label_msg setAlpha:1];
        
        self.label_msg.text=[NSString stringWithFormat:@"第 %i 題",current_number+1];//@"Hello";
        
    } completion:^(BOOL finished) {
        
    }];
    
    current_number++;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIToolbar *toolbar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 17, self.view.frame.size.width,44)];
    
    toolbar.barTintColor=[UIColor orangeColor];
    
    toolbar.tintColor=[UIColor lightTextColor];
    
    [self.view addSubview:toolbar];
    
    self.view.backgroundColor=[UIColor orangeColor];

    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
    
    view.backgroundColor=[UIColor whiteColor];
    
    self.view1.backgroundColor=[UIColor orangeColor];
    self.txt_ans.backgroundColor=[UIColor orangeColor];
    
    self.txt_input.placeholder=@"Please Input Your Answer and enter";
    
    self.txt_input.keyboardType=UIKeyboardTypeASCIICapable;
    
    self.txt_input.autocorrectionType=UITextAutocorrectionTypeNo;
    
    [self.txt_input addTarget:self action:@selector(inputout:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [self.txt_ans setEditable:NO];
    
    self.label_msg.text=@"";
    
    [self.label_msg setTextColor:[UIColor blueColor]];
    
    self.label_msg.textAlignment=NSTextAlignmentCenter;

    self.label_msg.font=[UIFont boldSystemFontOfSize:16.0];
    
    self.layer_btn_rand=[self.btn_rand layer];
    
    self.layer_btn_read=[self.btn_read layer];
    
    self.layer_btn_check=[self.btn_check layer];
    
    //[self.view addSubview:view];
    
    //self.tabBarController.view.backgroundColor=[UIColor orangeColor];
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.layer_btn_rand setBorderColor:[UIColor greenColor].CGColor];
    [self.layer_btn_rand setBorderWidth:2.0f];
    
    [self.layer_btn_read setBorderColor:[UIColor greenColor].CGColor];
    [self.layer_btn_read setBorderWidth:2.0f];
    
    [self.layer_btn_check setBorderColor:[UIColor greenColor].CGColor];
    [self.layer_btn_check setBorderWidth:2.0f];
   
}

-(IBAction)inputout:(id)sender
{
    [sender resignFirstResponder];
    [self.pickrow becomeFirstResponder];

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
