//Pikachu

#import "ViewController.h"
#import "ViewHeader.h"
@import MediaPlayer;

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *commentsTable;
@property (strong, nonatomic) MPMediaItem* currentPlayingItem;
@end

@implementation ViewController 

UITextField *postField;


@synthesize currentPlayingItem;

- (void)viewDidLoad {
  [super viewDidLoad];

  [self registerForKeyboardNotifications];
  currentPlayingItem = [[MPMusicPlayerController systemMusicPlayer] nowPlayingItem];
  self.automaticallyAdjustsScrollViewInsets = YES;
  
  [self setUpHeader];
  [self setUpPostingField];
  
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                 initWithTarget:self
                                 action:@selector(dismissKeyboard)];
  
  [self.view addGestureRecognizer:tap];
}

-(void) setUpHeader {
  ViewHeader *header = [[self commentsTable] dequeueReusableCellWithIdentifier:@"ViewHeader" ];
  if ([currentPlayingItem artwork])
  {
    header.albumImage.image = [[currentPlayingItem artwork] imageWithSize: CGSizeMake(80, 80)];
    header.albumImage.layer.masksToBounds = YES;
    header.albumImage.layer.borderColor = [UIColor grayColor].CGColor;
    header.albumImage.layer.borderWidth = 0.4f;
  }
  
  if ([currentPlayingItem title]) {
   header.titleLabel.text = [currentPlayingItem title];
  }
  if ([currentPlayingItem artist]) {
    header.subtitleLabel.text = [currentPlayingItem artist];
  }
  self.commentsTable.tableHeaderView = header;
}


-(void) setUpPostingField {
  postField = [[UITextField alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
  postField.placeholder = @"Post comment here";
  postField.backgroundColor = [UIColor greenColor];
  [[self view] addSubview:postField];
}


//MARK: tableview datasource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   UITableViewCell *cell = nil;
  return cell;
}

// PRAGMA MARK: keyboard

-(void)dismissKeyboard {
  [postField resignFirstResponder];
}

- (void)registerForKeyboardNotifications
{
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillShow:)
                                               name:UIKeyboardWillShowNotification object:nil];
  
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillBeHidden:)
                                               name:UIKeyboardWillHideNotification object:nil];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  [postField resignFirstResponder];
}

- (void) keyboardWillShow: (NSNotification*)aNotification {
  NSDictionary* info = [aNotification userInfo];
  CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

  [UIView animateWithDuration:0.3f animations:^{
    postField.frame = CGRectMake(postField.frame.origin.x, postField.frame.origin.y-kbSize.height, postField.frame.size.width, postField.frame.size.height);
  }];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
  [UIView animateWithDuration:0.3f animations:^{
    postField.frame = CGRectMake(postField.frame.origin.x, self.view.frame.size.height-postField.frame.size.height, postField.frame.size.width, postField.frame.size.height);
  }];
}

@end
