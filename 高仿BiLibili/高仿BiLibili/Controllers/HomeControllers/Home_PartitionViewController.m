//
//  分区  分区  Home_PartitionViewController.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/2.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "Home_PartitionViewController.h"
#import "PartitionCollectionViewCell.h"

@interface Home_PartitionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) NSMutableArray *imageArray,*iconNameArray;
@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation Home_PartitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageArray = [[NSMutableArray alloc] init];
    for(int i=1; i<=13; i++){
        [self.imageArray addObject:[NSString stringWithFormat:@"hd_home_subregion_%d_55x55_",i]];
    }
    self.iconNameArray = [[NSMutableArray alloc] initWithArray:  @[@"直播",@"番剧",@"动画",@"音乐",@"舞蹈",@"游戏",@"科技",@"生活",@"鬼畜",@"时尚",@"娱乐",@"电影",@"电视剧"]];
    [self buildCollectionView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, BScreen_Width, BScreen_Height - 64 - 44) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = BBackgroundColor;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[PartitionCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.collectionView];
}

// MARK: - delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.iconNameArray.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PartitionCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setData:self.imageArray[indexPath.row] iconName:self.iconNameArray[indexPath.row]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(BScreen_Width/3, (BScreen_Width)/3 - 18);
    
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
