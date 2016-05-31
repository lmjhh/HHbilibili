//
//  Live_MostPopularViewController.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/12.
//  Copyright © 2016年 黄人煌. All rights reserved.
//


#import "Live_MostPopularViewController.h"
#import "Live_ColCollectionViewCell.h"
#import "HomeData.h"

@interface Live_MostPopularViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *data;
@property (nonatomic,assign) NSInteger Index;

@end

@implementation Live_MostPopularViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildCollectionView];
    [self loadDataFormNet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 8;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 10);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, BScreen_Width, BScreen_Height - 64 - .0675 * BScreen_Height) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[Live_ColCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.collectionView];
    
    _Index = 1;
}

- (void)loadDataFormNet{
    
    [[BiLi_NetAPIManager sharedManager] request_MostPopularDataWithBlock:_Index dataBlock:^(id data, NSError *error) {
        
        self.data = [[NSMutableArray alloc] init];
        
        NSArray *lives = [data valueForKey:@"data"];
        for(int i=0;i<lives.count;i++){
            
            Lives *live = [Lives mj_objectWithKeyValues:lives[i]];
            [self.data addObject:live];
        }
        [self.collectionView reloadData];
        
    }];
    
}


// MARK: - delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.data.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Live_ColCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setData:self.data[indexPath.row]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(BScreen_Width/2 - 10, (BScreen_Width - 10)/2 * 0.63 + 49);
    
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
