//
//  RADNewsTableViewController.m
//  ScoopyNews
//
//  Created by RAMON ALBERTI DANES on 30/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#import "RADNewsTableViewController.h"
#import "RNews.h"
#import "RADImages.h"
#import "RADNewViewController.h"

@interface RADNewsTableViewController ()
@property (nonatomic, strong) RNews  *model;
@end

@implementation RADNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Leer Noticias";
}


// el método que genera la celda
-(UITableViewCell *) tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    // Averiguar la nota
    RNews *n = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    // Crear la celda
    static NSString *newsCellId = @"NewsCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newsCellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:newsCellId];
    }
    // Sincornizar nota -> celda
    cell.textLabel.text = n.title;
    
    
    // Crear una cola
    dispatch_queue_t asyncimage = dispatch_queue_create("asyncimage", 0);
    
    //Poner el prefijo
    __block UIImage *image =nil;
    __block NSData *imgData=nil;
    
    //Enviar un bloque a background
    dispatch_async(asyncimage, ^{
        NSURL *url = [NSURL URLWithString:n.imageURL];
        
        imgData = [NSData dataWithContentsOfURL:url];
        
        //Esto vuelve a primer plano y se ejecuta
        dispatch_async(dispatch_get_main_queue(), ^{
            image = [UIImage imageWithData:imgData];
            cell.imageView.image=image;
            
        });
    });
    
    
    
    cell.imageView.image=[UIImage imageNamed:@"noimage.jpg"];
    cell.detailTextLabel.text = n.author;
    
    // devolverla
    return cell;
    
}

-(void) tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    // Averiguar la nota
    RNews *n = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Crear el controlador
    RADNewViewController *nVC = [[RADNewViewController alloc] initWithModel:n AndContext:self.fetchedResultsController.managedObjectContext];
    
    // Hacer el push
    [self.navigationController pushViewController:nVC
                                         animated:YES];
    
    
}



#pragma mark - Unused
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
