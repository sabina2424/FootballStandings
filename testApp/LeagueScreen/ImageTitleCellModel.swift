//
//  ImageTitleCellModel.swift
//  testApp
//
//  Created by 003995_Mac on 21.06.22.
//

import Foundation

 struct Item {
     var image: String?
     var titleLabel: String?
     var items: [String]?
     
     init(image: String? = nil,
          titleLabel: String? = nil,
          items: [String]? = nil) {
         self.titleLabel = titleLabel
         self.image = image
         self.items = items
     }
 }
