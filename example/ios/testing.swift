//
//  testing.swift
//  HorizontalNativeGalleryExample
//
//  Created by Moneeb Arif on 21/04/2024.
//

import Foundation
import UIKit
import Lightbox
import Hero
import SDWebImage

@objc(HorizontalNativeGallery)
class HorizontalNativeGallery: NSObject {
    private var lightboxController: LightboxController?

    @objc
    func showLightbox(_ images: [NSDictionary], startingIndex: Int , details: NSDictionary?) {

      var x: CGFloat = 0
      var y: CGFloat = 0
      var width: CGFloat = UIScreen.main.bounds.width
      var height: CGFloat = UIScreen.main.bounds.height

      if let details = details {
    // Now that we know details is not nil, safely extract the values
        x = details["x"] as? CGFloat ?? 0
        y = details["y"] as? CGFloat ?? 0
        width = details["width"] as? CGFloat ?? UIScreen.main.bounds.width
        height = details["height"] as? CGFloat ?? UIScreen.main.bounds.height
      }
      
      let initialImages = images.enumerated().compactMap { index, dict -> LightboxImage? in
          guard let urlString = dict["imageUrl"] as? String, let url = URL(string: urlString) else {
            return nil // Skip items without a valid URL
          }
          let text = dict["text"] as? String ?? ""
          let videoUrl = dict["videoUrl"] as? String ?? ""
          return LightboxImage( imageURL: url, text: text, videoUrl: videoUrl)
      }
      
        LightboxConfig.preload = 1
        LightboxConfig.loadImage = { imageView, _URL, completion in
        DispatchQueue.main.async {
          
          let urlString = _URL.absoluteString
          imageView.sd_setImage(with: _URL, options: [.highPriority, .retryFailed]) { image, error, cacheType, imageURL in
            // Check if the larger image was successfully loaded
            if let error = error {
              print("Error loading larger image: \(error.localizedDescription)")
            } else {
              print("Image loaded successfully from \(imageURL?.absoluteString ?? "unknown URL")")
            }
            completion?(image) // Call completion whether the load was successful or not
          }
        }
      }
        
        let controller = LightboxController(images: initialImages, startIndex: startingIndex)
        controller.dynamicBackground = true
        controller.modalPresentationStyle = .fullScreen
        controller.hero.isEnabled = true
        controller.hero.modalAnimationType = .none
      
        controller.view.hero.modifiers = [
            .position(CGPoint(x: x + width / 2, y: y + height / 2)),
            .scale(x:0.5 , y:0.25) // Start scaled down to match the component's size
        ]


             
        
        // Set up delegates to handle image loading dynamically
        controller.pageDelegate = self
        
        // Assuming you have access to the root view controller
        DispatchQueue.main.async {
            if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
                rootVC.present(controller, animated: true, completion: nil)
            }
        }
        
        lightboxController = controller
    }
    
    @objc
    static func requiresMainQueueSetup() -> Bool {
        return true
    }
}

// MARK: - LightboxControllerPageDelegate
extension HorizontalNativeGallery: LightboxControllerPageDelegate {
    func lightboxController(_ controller: LightboxController, didMoveToPage page: Int) {
      
    }}
