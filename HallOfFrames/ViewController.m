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
#import "MyCustomView.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,MyCustomViewDelegate>

@property NSArray* pictures;
@property PictureCollectionViewCell* currentSelectedCell;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    Picture* picture1 = [[Picture alloc]init];
    picture1.image = [UIImage imageNamed:@"DukeAtNight"];
    picture1.frameColor = [self generateRandomColor];
    Picture* picture2 = [[Picture alloc]init];
    picture2.image = [UIImage imageNamed:@"FrenchBridge"];
    picture2.frameColor = [self generateRandomColor];
    Picture* picture3 = [[Picture alloc]init];
    picture3.image = [UIImage imageNamed:@"Painting"];
    picture3.frameColor = [self generateRandomColor];
    Picture* picture4 = [[Picture alloc]init];
    picture4.image = [UIImage imageNamed:@"yosemite"];
    picture4.frameColor = [self generateRandomColor];
    self.pictures = [NSArray arrayWithObjects:picture1,picture2,picture3,picture4,nil];

    // Do any additional setup after loading the view.
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   // Show the new view with options to change color.
    
    NSArray* newViews = [[NSBundle mainBundle] loadNibNamed:@"CustomizedView" owner:self options:nil];
    MyCustomView* newView = [newViews objectAtIndex:0];
    int x = self.view.frame.origin.x + self.view.frame.size.width * (1.0/5);
    int y = self.view.frame.origin.y + self.view.frame.size.height / 3.0;
    int width = self.view.frame.size.width * (3.0/5);
    int height = self.view.frame.size.height/3.0;
    newView.delegate = self;
    self.currentSelectedCell = [collectionView cellForItemAtIndexPath:indexPath];
    [newView setFrame:CGRectMake(x, y, width, height)];
    [self.view addSubview:newView];    
//    newView.delegate = self;
}

-(void)updateColorValueWithRestorationID:(NSString *)color toFloat:(float)newValue{
    UIColor* currentColor = self.currentSelectedCell.backgroundColor;
    CGFloat red,green,blue,alpha;
    [currentColor getRed:&red green:&green blue:&blue alpha:&alpha];
    
    if ([color isEqualToString:@"RedSlider"])
        self.currentSelectedCell.backgroundColor = [UIColor colorWithRed:newValue green:green blue:blue alpha:alpha];
    else if([color isEqualToString:@"GreenSlider"])
        self.currentSelectedCell.backgroundColor = [UIColor colorWithRed:red green:newValue blue:blue alpha:alpha];
    else
        self.currentSelectedCell.backgroundColor = [UIColor colorWithRed:red green:green blue:newValue alpha:alpha];
    
}

-(UIColor*)generateRandomColor{
    float r = (float)arc4random()/INT_MAX;
    float g = (float)arc4random()/INT_MAX;
    float b = (float)arc4random()/INT_MAX;
    UIColor* result = [UIColor colorWithRed:r green:g blue:b alpha:1];
    return result;
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
