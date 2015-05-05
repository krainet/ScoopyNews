//
//  RADAuthorsTableViewController.m
//  ScoopyNews
//
//  Created by RAMON ALBERTI DANES on 1/5/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#import "RADAuthorsTableViewController.h"

#import "RADNews.h"
#import "RADImages.h"
#import "RADAddNewsViewController.h"
#import "RADAuthors.h"

@interface RADAuthorsTableViewController ()
@property (strong,nonatomic) RADNews *news;
@end

@implementation RADAuthorsTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNewsButton];
    
    // Edit button
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

// el método que genera la celda
-(UITableViewCell *) tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    // Averiguar la nota
    RADNews *n = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    // Crear la celda
    static NSString *newsCellId = @"NewsCellId2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newsCellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:newsCellId];
    }
    // Sincornizar nota -> celda
    cell.textLabel.text = n.title;
    cell.imageView.image=[n.image image];
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:n.dateAdd
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterFullStyle];
    cell.detailTextLabel.text = dateString;
    
    // devolverla
    return cell;
    
}

-(void) tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    // Averiguar la nota
    RADNews *n = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Crear el controlador
    RADAddNewsViewController *nVC = [[RADAddNewsViewController alloc]initWithModel:n AndContext:self.fetchedResultsController.managedObjectContext];
    
    // Hacer el push
    [self.navigationController pushViewController:nVC
                                         animated:YES];
    
}

#pragma mark - Utils
-(void) addNewsButton{
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc]
                            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                            target:self action:@selector(addNewNews:)];
    
    self.navigationItem.rightBarButtonItem = add;
    
}

-(void) addNewNews:(id) sender{
    RADAuthors *author = [RADAuthors authorWithName:@"Ramon Alberti" InContext:self.fetchedResultsController.managedObjectContext];
    [RADNews newsWithTitle:@"Nueva noticia" Text:@"" Author:author InContext:self.fetchedResultsController.managedObjectContext];
}


#pragma mark - Delete
-(void) tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        // Inmediatamente lo elimino del modelo
        
        // Averiguar la libreta
        RADNews *nb = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        // Eliminarla
        [self.fetchedResultsController.managedObjectContext deleteObject:nb];
        
    }
    
}




#pragma mark - Unused
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
