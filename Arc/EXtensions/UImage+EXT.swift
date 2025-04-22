//
//  UImage+EXT.swift
//  Arc
//
//  Created by Ahmed El Gndy on 22/04/2025.
//

import UIKit
import CoreImage.CIFilterBuiltins

extension UIImage {

    func blur(radius: Float) -> UIImage? {
          guard let ciImage = CIImage(image: self) else { return nil }

          let blurFilter = CIFilter.gaussianBlur()
          blurFilter.setValue(ciImage, forKey: kCIInputImageKey)
          blurFilter.setValue(radius, forKey: kCIInputRadiusKey)

          guard let outputImage = blurFilter.outputImage else { return nil }

          // Crop to original size
          let croppedImage = outputImage.cropped(to: ciImage.extent)

          let context = CIContext()
          if let cgImage = context.createCGImage(croppedImage, from: croppedImage.extent) {
              return UIImage(cgImage: cgImage)
          }

          return nil
      }
}
