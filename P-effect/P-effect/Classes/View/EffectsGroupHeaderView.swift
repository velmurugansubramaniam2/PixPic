//
//  EffectViewHeader.swift
//  P-effect
//
//  Created by AndrewPetrov on 2/8/16.
//  Copyright © 2016 Yalantis. All rights reserved.
//

import Foundation

class EffectsGroupHeaderView: UICollectionReusableView {
    
    static let identifier = "EffectsGroupHeaderViewIdentifier"
    static var nib: UINib? {
        let nib = UINib(nibName: String(self), bundle: nil)
        return nib
    }
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var label: UILabel!
    
    private var completion: (() -> Bool)!
    
    func configureWith(group group: EffectsGroup, completion: (() -> Bool)) {
        downloadImageFromFile(group.image)
        label.text = group.label
        self.completion = completion
        
        let recognizer = UITapGestureRecognizer(target: self, action: "toggleGroup")
        addGestureRecognizer(recognizer)
    }
    
    private func downloadImageFromFile(file: PFFile) {
        ImageLoaderService.getImageForContentItem(file) { image, error in
            if let image = image {
                self.imageView.image = image.imageWithRenderingMode(.AlwaysTemplate)
                self.imageView.tintColor = UIColor.whiteColor()
            } else {
                print("\(error)")
            }
        }
    }
    
    func toggleGroup() {
        let isSelected = completion()
        let color = isSelected ? UIColor.appBlueColor : UIColor.whiteColor()
        UIView.animateWithDuration(
            0.2,
            delay: 0,
            options: [.CurveLinear, .BeginFromCurrentState],
            animations: {
                self.imageView.tintColor = color
            },
            completion: nil
        )
    }
    
}
