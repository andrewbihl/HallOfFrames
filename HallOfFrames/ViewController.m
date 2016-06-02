//
//  ViewController.m
//  HallOfFrames
//
//  Created by Andrew Bihl on 6/2/16.
//  Copyright © 2016 Andrew Bihl. All rights reserved.
//

#import "ViewController.h"
#import "Picture.h"
#import "PictureCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property NSArray* pictures;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Picture* picture1 = [[Picture alloc]init];
    picture1.image = [UIImage imageNamed:@"DukeAtNight"];
    self.pictures = [NSArray arrayWithObjects:picture1, nil];
    // Do any additional setup after loading the view.
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PictureCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PictureCell" forIndexPath:indexPath];
    Picture* currentPicture = [self.pictures objectAtIndex:indexPath.row];
    cell.imageView.image = currentPicture.image;
    cell.backgroundColor = currentPicture.frameColor;
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.pictures.count;
}

@end
