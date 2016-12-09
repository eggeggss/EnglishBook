//
//  ViewController2.m
//  看智障學英文
//
//  Created by RogerRoan on 2016/3/15.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import "ViewController2.h"
@interface ViewController2 ()

@end

@implementation ViewController2

static NSInteger fresh_count=10;

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
   return self.book.eng_list.count;
    //return self->eng_names.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellname=@"mycell";
    
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellname];
    
    if (cell!=nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
    }
    //UITableViewCellStyleValue1
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    /*
    NSString *eng_str=[self->eng_names objectAtIndex:indexPath.row];
    NSString *comment_str=[self->comment objectAtIndex:indexPath.row];
    NSString *ch_str=[self->ch_names objectAtIndex:indexPath.row];
    */
    English *english=[self.book.eng_list objectAtIndex:indexPath.row ];
    
    NSString *eng_str=english.eng_name;
    NSString *comment_str=english.common;
    NSString *ch_str=english.ch_name;
    
    
    UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(0, 10, 40, 30)];
    
    [button setTitle:@"Edit" forState:UIControlStateNormal];
    
    //button.backgroundColor=[UIColor lightGrayColor];
    //button.tintColor=[UIColor blueColor];
    
    [button addTarget:self action:@selector(btn_edit:) forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    
    button.tag=1;
    
    if (self.tableview.isEditing) {
        [button setHidden:NO];
    }
    else {
        [button setHidden:YES];
    }
    
    [cell.contentView addSubview:button];
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(40, 10, 200, 30)];
    
    [label setText:eng_str];
    
    label.font=[UIFont systemFontOfSize:18];
    
    label.textColor=[UIColor blueColor];
    //label.backgroundColor=[UIColor blueColor];
    
    [cell.contentView addSubview:label];
    /*
    UILabel *label_detail=[[UILabel alloc] initWithFrame:CGRectMake(240, 10, 100, 30)];
    */
    
    UILabel *label_detail=[[UILabel alloc] initWithFrame:CGRectMake(40,40,200,30)];
    
    [label_detail setText:comment_str];
    
    label_detail.font=[UIFont systemFontOfSize:14];
    
    label_detail.textColor=[UIColor redColor];
    
    [cell.contentView addSubview:label_detail];
    //中文
     UILabel *label_detail2=[[UILabel alloc] initWithFrame:CGRectMake(240, 10, 100, 30)];
    
    [label_detail2 setText:ch_str];
    
    label_detail2.font=[UIFont systemFontOfSize:12];
    
    if(self->lb_show_chines)
    {
        [label_detail2 setHidden:YES];
    }
    else
    {
        [label_detail2 setHidden:NO];
    }
    
    label_detail2.tag=2;
    
    [cell.contentView addSubview:label_detail2];
   
 
    return cell;
    
}



-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSString *eng_str=[self->eng_names objectAtIndex:indexPath.row];
    
    English *english=[self.book.eng_list objectAtIndex:indexPath.row];
    NSString *eng_str=english.eng_name;
    
    
    [Speech Speek:eng_str andSpeed:2.0f andLanguage:Language_en_us];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//是否要縮排
-(BOOL) tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  YES;
}
//編輯模式的style
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableview setEditing:NO animated:YES];
    
    UIBarButtonItem *left=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(btnAdd:)];
    
    UIBarButtonItem *fix=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace  target:self action:nil];
    
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTitle:@"編輯" style:UIBarButtonItemStyleDone target:self action:@selector(btnGroup:)];
    
    self.showbtn=[[UIBarButtonItem alloc] initWithTitle:@"顯示中文" style:UIBarButtonItemStyleDone target:self action:@selector(showChine:)];
    
    
    UIToolbar *toolbar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 17, self.view.frame.size.width,44)];
    
    toolbar.barTintColor=[UIColor orangeColor];
    
    toolbar.tintColor=[UIColor lightTextColor];
    
    NSArray *items=[[NSArray alloc] initWithObjects:left,fix,self.showbtn,right, nil];
    
    [toolbar setItems:items];
    
    [self.view addSubview:toolbar];
    
    self.view.backgroundColor=[UIColor orangeColor];
    
    //self.tableview.backgroundView.backgroundColor=[UIColor orangeColor];
    //[self.tableview setEditing:YES animated:YES];
    
    self.refreshControl=[[UIRefreshControl alloc] init];
    
    [self.refreshControl addTarget:self action:@selector(fresh) forControlEvents:UIControlEventValueChanged];
    
    [self.tableview addSubview:self.refreshControl];
    
    self.appdelegate=[[UIApplication sharedApplication] delegate];
    
        // Do any additional setup after loading the view.
}

-(IBAction)showChine:(id)sender
{
    UIBarButtonItem *btn=(UIBarButtonItem *) sender;
    
    if(self->lb_show_chines)
    {
        [btn setTitle:@"取消顯示中文"];
        
        self->lb_show_chines=NO;
        
        for (UITableViewCell *cell in [self.tableview visibleCells]) {
            UILabel *label = (UILabel *)[cell viewWithTag:2];
            [label setHidden:NO];
        }
    }
    else
    {
        [btn setTitle:@"顯示中文"];
        
        self->lb_show_chines=YES;
        
        for (UITableViewCell *cell in [self.tableview visibleCells]) {
            UILabel *label = (UILabel *)[cell viewWithTag:2];
            [label setHidden:YES];
        }
    }
}

- (IBAction)btnAdd:(id)sender{
    
    PopupViewController *v2=[self.storyboard instantiateViewControllerWithIdentifier:@"pop1"];
    
    [v2 setActionType:ActionTypeInsertType];
    
    [self presentViewController:v2 animated:YES completion:^{
        
    }];
}

-(void) btn_edit:(UIButton *) sender
{
    CGPoint buttonOriginInTableView = [sender convertPoint:CGPointZero toView:self.tableview];
    
    NSIndexPath *indexPath = [self.tableview indexPathForRowAtPoint:buttonOriginInTableView];
    
    /*
    NSString  *eng_name=[self->eng_names objectAtIndex:indexPath.row];
    NSString  *ch_name=[self->ch_names objectAtIndex:indexPath.row];
    NSString *comment=[self->comment objectAtIndex:indexPath.row];
    NSString *comment2=[self->comment2 objectAtIndex:indexPath.row];
    */
    
    English *english=[self.book.eng_list objectAtIndex:indexPath.row];
    
    PopupViewController *v2=[self.storyboard instantiateViewControllerWithIdentifier:@"pop1"];
    
    v2.english=english;
    
    //NSLog(@"=>%@",v2.english.common2);
    /*
    v2.eng_name=eng_name;
    v2.ch_name=ch_name;
    v2.comment=comment;
    v2.comment2=comment2;
    */
    [v2 setActionType:ActionTypeUpdateType];
    
    [self presentViewController:v2 animated:YES completion:^{
        
    }];
}



- (IBAction)btnGroup:(id)sender {
    UIBarButtonItem *btn=(UIBarButtonItem *) sender;
    
    if ([self.tableview isEditing]) {
        
        [btn setTitle:@"編輯"];
        
        [self.tableview setEditing:NO animated:YES];
        
        for (UITableViewCell *cell in [self.tableview visibleCells]) {
            UIButton *btn = (UIButton *)[cell viewWithTag:1];
            [btn setHidden:YES];
        }
    }
    else {
        
        [btn setTitle:@"取消編輯"];
        
        [self.tableview setEditing:YES animated:YES];
        
        for (UITableViewCell *cell in [self.tableview visibleCells]) {
            UIButton *btn = (UIButton *)[cell viewWithTag:1];
            [btn setHidden:NO];
        }
    }
}


-(void) reloadData
{
    
    [self.appdelegate refreshEnglishData:fresh_count];
    /*
    self->eng_names=self.appdelegate.en_names;
    
    self->ch_names=self.appdelegate.ch_names;
    
    self->comment=self.appdelegate.comment;
    
    self->comment2=self.appdelegate.comment2;
    */
    
    self.book=nil;
    
    self.book=self.appdelegate.book;
    
    //NSLog(@"row count %i",self.appdelegate.en_names.count);
    //NSLog(@"row count %i",self.appdelegate.book.eng_list.count);
    
    [self.tableview reloadData];
}

-(void) fresh{
    fresh_count=fresh_count+20;
    //[English ResetGid];
    [self performSelector:@selector(reloadData)];
    [self.refreshControl endRefreshing];
}

-(void) viewWillAppear:(BOOL)animated
{
    self->lb_show_chines=NO;
    
   [self performSelector:@selector(reloadData)];
    
   [self performSelector:@selector(showChine:) withObject:nil];
    
    if (self->lb_show_chines)
    {
        [self.showbtn setTitle:@"顯示中文"];
        
    }
    else
    {
        [self.showbtn setTitle:@"取消顯示中文"];
        
    }
    
   /*
    for (UITableViewCell *cell in [self.tableview visibleCells]) {
        UILabel *label = (UILabel *)[cell viewWithTag:2];
        [label setHidden:YES];
    }
     */
}

-(void) viewDidAppear:(BOOL)animated
{
    
    //[self.tableview reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    self.appdelegate=nil;
    self.tableview.delegate=nil;
    self.refreshControl=nil;
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
