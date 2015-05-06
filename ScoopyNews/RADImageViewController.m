//
//  RADImageViewController.m
//  ScoopyNews
//
//  Created by RAMON ALBERTI DANES on 2/5/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#import "RADImageViewController.h"
#import "RADNews.h"
#import "RADImages.h"

#import "Config.h"

#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import <CommonCrypto/CommonDigest.h>

@interface RADImageViewController ()
@property (strong,nonatomic) RADNews *model;
@property (strong,nonatomic) RADImages *modelImage;
@property (strong,nonatomic) MSClient *client;
@property (strong,nonatomic) NSManagedObjectContext *context;
@end

@implementation RADImageViewController

#pragma mark - Init
-(id) initWithModel:(RADNews*) model AndContext:(NSManagedObjectContext *)context{
    if(self=[super initWithNibName:nil bundle:nil]){
        _model=model;
        _client=[MSClient clientWithApplicationURLString:AZURE_ENDPOINT applicationKey:AZURE_KEY];
        _context=context;
    }
    return self;
}

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self syncViewWithModel];
}


#pragma mark - Actions

- (IBAction)takePicture:(id)sender {
    
    // Creamos un UIImagePickerController
    UIImagePickerController *picker = [UIImagePickerController new];
    
    // Lo configuro
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        // Uso la cámara
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
    }else{
        // Tiro del carrete
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    picker.delegate = self;
    
    picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    // Lo muestro de forma modal
    [self presentViewController:picker
                       animated:YES
                     completion:^{
                         // Esto se va a ejecutar cuando termine la
                         // animación que muestra al picker.
                     }];
    
    
}

- (IBAction)saveNews:(id)sender {
}

- (IBAction)deletePicture:(id)sender {
}

#pragma mark - Utils
-(void) syncViewWithModel{
    self.newsImage.image=self.model.image.image;
}



#pragma mark - UIImagePickerControllerDelegate
-(void) imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    // ¡OJO! Pico de memoria asegurado, especialmente en
    // dispositivos antiguos
    
    //NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    // Sacamos la UIImage del diccionario
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // La guardo en el modelo
    self.model.image.image = img;
    
    //submis timestampMd5 de la imagen
    NSString * timestamp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
    
    NSString *md5name = [self md5:timestamp];
    md5name=[md5name stringByAppendingString:@".jpg"];
    NSLog(@"Nombre :: %@",md5name);

    [self.client invokeAPI:@"getuploadsasurl" body:nil HTTPMethod:@"GET"
                parameters:@{@"blobName":md5name}
                   headers:nil
                completion:^(id result, NSHTTPURLResponse *response, NSError *error) {
                    if (!error) {
                        NSString *sasUrls= [result valueForKey:@"sasUrl"];
                        NSURL *passUrl = [NSURL URLWithString:sasUrls];
                        [self handleImageToUploadAzureBlob:passUrl blobImg:img completionUploadTask:^(id result, NSError *error) {
                            NSLog(@"Entramos en completion....");
                            if(error){
                                NSLog(@"Error handling upload.... %@",error);
                            }else{
                                NSLog(@"Upload successfull ... ");
                                self.model.image.imageUrl=md5name;
                            }
                        }];
                    }else{
                        NSLog(@"Error subiendo %@",error);
                        
                    }
    }];
    
    self.model.image.imageUrl=@"https://scoopynews.blob.core.windows.net/scoopycontainer/";
    self.model.image.imageUrl=[self.model.image.imageUrl stringByAppendingString:md5name];
    
    //save context
    NSError *error;
    [self.context save:&error];
    if(error){
        NSLog(@"Error");
    }else{
        NSLog(@"Sin error");
    }
    
    // Quito de encima el controlador que estamos presentando
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 // Se ejecutará cuando se haya ocultado del todo
                             }];
}



- (void)handleImageToUploadAzureBlob:(NSURL *)theURL blobImg:(UIImage*)blobImg completionUploadTask:(void (^)(id result, NSError * error))completion{
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:theURL];
    
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"image/jpeg" forHTTPHeaderField:@"Content-Type"];
    
    NSData *data = UIImageJPEGRepresentation(blobImg, 1.f);
    
    NSURLSessionUploadTask *uploadTask = [[NSURLSession sharedSession] uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            //NSLog(@"resultado --> %@", response);
            NSLog(@"UploadSuccessfull");
        }
        
    }];
    [uploadTask resume];
}


#pragma mark - Unused
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Utils
- (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

@end
