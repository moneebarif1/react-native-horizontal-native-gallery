#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(HorizontalNativeGallery, NSObject)

RCT_EXTERN_METHOD(showLightbox:(NSArray<NSDictionary *> *)horizontalGalleryImages
                 startingIndex:(NSInteger)startingIndex
                       details:(NSDictionary * _Nullable)details)
@end

