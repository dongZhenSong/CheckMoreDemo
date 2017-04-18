//
//  ViewController.m
//  PullPushDemo
//
//  Created by dongzhensong on 16/9/23.
//  Copyright © 2016年 jinfuma. All rights reserved.
//

// 实现思路:
// 小按钮放在了collectionView中, collectionView放在tableViewCell上
// "查看更多"按钮放在tableView的区尾视图上面
// 当点击"查看更多"按钮时记录当前点击事件, 改变要展示的小按钮个数, 刷新tableViewCell所在分区.



#import "ViewController.h"
#import "TheCollectionTableViewCell.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) BOOL isOpen;
@property (assign, nonatomic) NSInteger showButtonNumber;
@property (copy, nonatomic) NSArray *titleArr;
@property (strong, nonatomic) UIButton *theButton;

@end

@implementation ViewController

- (UIButton *)theButton{

    if (!_theButton) {
        _theButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        _theButton.frame = CGRectMake(15, 0, [UIApplication sharedApplication].keyWindow.frame.size.width - 30, 30);
        [_theButton setTitle:@"查看更多" forState:(UIControlStateNormal)];
        [_theButton addTarget:self action:@selector(handleAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [_theButton setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
        [_theButton setBackgroundColor:[UIColor whiteColor]];
        _theButton.layer.cornerRadius = 15;
        _theButton.layer.masksToBounds = YES;
        _theButton.layer.borderWidth = 1;
        _theButton.layer.borderColor = [UIColor greenColor].CGColor;
    }
    return _theButton;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"查看更多/收起demo";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TheCollectionTableViewCell" bundle:nil] forCellReuseIdentifier:@"TheCollectionTableViewCell"];
    _showButtonNumber = 8;
    
    _titleArr = @[@"标题1", @"标题2", @"标题3", @"标题4",
                  @"标题5", @"标题6", @"标题7", @"标题8",
                  @"标题9", @"标题10", @"标题11", @"标题12",
                  @"标题13", @"标题14", @"标题15"];

}


// 记录按钮点击事件, 设定_isOpen
- (void)handleAction:(UIButton *)sender{

    _isOpen = !_isOpen;
    if (_isOpen) {
        _showButtonNumber = _titleArr.count;
        [sender setTitle:@"收起" forState:(UIControlStateNormal)];
    }else{
        _showButtonNumber = 8;
        [sender setTitle:@"查看更多" forState:(UIControlStateNormal)];
    }
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:(UITableViewRowAnimationAutomatic)];
}


#pragma mark - UITableViewDataSource, UITableViewDelegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    // 根据是否打开的标识 _isOpen返回不同row高度.
    if (_isOpen) {
        // 按照整数/整数丢失精度仍为整数的思想(例如 9/5=1), 显示按钮的行数 = 显示按钮的个数/(每行显示的按钮个数+1) 行数为_titleArr.count / (4+1)
        CGFloat height = (_titleArr.count / (4+1) + 1) * 30;
        
        return height;
    }else{
        return 60;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.05;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    TheCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TheCollectionTableViewCell" forIndexPath:indexPath];
    
    [cell setupCellWithNumber:_showButtonNumber andButtonNameArr:_titleArr];
    cell.buttonClicked = ^(NSInteger index){
    
        NSLog(@"点击的按钮下标为: %ld", index);
        
    };
    
    return cell;
    
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    UIView *firstFooter = [[UIView alloc] initWithFrame:self.theButton.frame];
    
    [firstFooter addSubview:self.theButton];
    
    return firstFooter;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
