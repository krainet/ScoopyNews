#import "RADImages.h"

@interface RADImages ()

// Private interface goes here.

@end

@implementation RADImages

// Observables
+(NSArray *) observableKeys{
    // Observo las propiedades de las relaciones
    return @[RADImagesAttributes.title,RADImagesAttributes.imageData];
}


-(void) setImage:(UIImage *)image{
    
    // Convertir la UIImage en un NSData
    self.imageData = UIImageJPEGRepresentation(image, 0.9);
}

-(UIImage *) image{
    // Convertir la NSData en UIImage
    return [UIImage imageWithData:self.imageData];
}


#pragma mark - KVO
-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    
    // Set action for observables
    
}

@end
