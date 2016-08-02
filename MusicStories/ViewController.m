
#import "ViewController.h"
#import "ViewHeader.h"

@import MediaPlayer;
@import MarqueeLabel;

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

  
  [self setUpPostingField];
  
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                 initWithTarget:self
                                 action:@selector(dismissKeyboard)];
  
  [self.view addGestureRecognizer:tap];
}

- (void) viewWillAppear:(BOOL)animated {
  [self refreshNavigationBar];
}

-(void) refreshNavigationBar {
   //set a button if no song appear
  CGRect headerFrame = CGRectMake(0, 0, self.view.frame.size.width, 44);
  
  if (currentPlayingItem == nil) {
  
   // UIButton *playButton = [UIButton alloc] ini
  } else {
    
    UIView *wrapper = [[UIView alloc] initWithFrame:headerFrame];
    
    UIImageView *microphoneImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 25, 25)];
    microphoneImage.image = [UIImage imageNamed:@"microphone_icon"];
    microphoneImage.contentMode = UIViewContentModeScaleAspectFit;
    microphoneImage.center = CGPointMake(microphoneImage.center.x, 22);
    [wrapper addSubview:microphoneImage];
    
    MarqueeLabel *titleLabel = [[MarqueeLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(microphoneImage.frame) + 8, 0, self.view.frame.size.width*0.7, 44) duration:8.0 andFadeLength:10.0f];
    titleLabel.text = [NSString stringWithFormat:@"%@ - %@", currentPlayingItem.title ?: @"" , currentPlayingItem.artist?: @"" ];
    [wrapper addSubview:titleLabel];
  
    self.navigationItem.titleView = wrapper;
  }
  
  
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
