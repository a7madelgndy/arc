//
//  ImageAttributeTransformer.swift
//  Arc
//
//  Created by Ahmed El Gndy on 27/04/2025.
//

import UIKit
class ImageAttributeTransformer:NSSecureUnarchiveFromDataTransformer {
    //1
      override static var allowedTopLevelClasses: [AnyClass] {
        [UIImage.self]
      }
    
    
    //2
    static func register() {
        let className =
            String(describing: ImageAttributeTransformer.self)
          let name = NSValueTransformerName(className)
          let transformer = ImageAttributeTransformer()
        print("Transformer loaded")

          ValueTransformer.setValueTransformer(
            transformer, forName: name)
        }
    }
