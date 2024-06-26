import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-horizontal-native-gallery' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const HorizontalNativeGallery = NativeModules.HorizontalNativeGallery
  ? NativeModules.HorizontalNativeGallery
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export interface ImageDetails {
  x: number;
  y: number;
  width: number;
  height: number;
}

export interface LightBoxImage {
  imageUrl: string;
  text?: string;
  videoUrl?: string;
}

export function showLightbox(
  images: LightBoxImage[],
  startingIndex: number = 0,
  imageDetails?: ImageDetails
): Promise<void> {
  return HorizontalNativeGallery.showLightbox(
    images,
    imageDetails,
    startingIndex
  );
}
