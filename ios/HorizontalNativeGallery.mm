#import "React/RCTBridgeModule.h"

@interface RCT_EXPORT_MODULE(HorizontalNativeGallery, NSObject)

RCT_EXPORT_METHOD(showLightbox:(NSArray<NSDictionary *> *)horizontalGalleryImages
                 startingIndex:(NSInteger)startingIndex
                       details:(NSDictionary * _Nullable)details)
@end

