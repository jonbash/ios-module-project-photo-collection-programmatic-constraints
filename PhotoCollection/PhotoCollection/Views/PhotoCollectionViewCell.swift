//
//  PhotoCollectionViewCell.swift
//  PhotoCollection
//
//  Created by Spencer Curtis on 8/2/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    var photo: Photo? {
        didSet {
            updateViews()
        }
    }
    
    var imageView: UIImageView!
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpSubViews()
    }
    
    func updateViews() {
        guard let photo = photo,
            let image = UIImage(data: photo.imageData)
            else { return }
        
        imageView.image = image
        titleLabel.text = photo.title
    }
    
    private func setUpSubViews() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        
        // Image Constraints
        
        let imageTopConstraint = NSLayoutConstraint(
            item: imageView,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1,
            constant: 0
        )
        let imageLeadingConstraint = NSLayoutConstraint(
            item: imageView,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1,
            constant: 0
        )
        let imageTrailingConstraint = NSLayoutConstraint(
            item: imageView,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self,
            attribute: .trailing,
            multiplier: 1,
            constant: 0
        )
        let imageHeightConstraint = NSLayoutConstraint(
            item: imageView,
            attribute: .height,
            relatedBy: .lessThanOrEqual,
            toItem: imageView,
            attribute: .width,
            multiplier: 1,
            constant: 0
        )
        NSLayoutConstraint.activate([
            imageTopConstraint,
            imageLeadingConstraint,
            imageTrailingConstraint,
            imageHeightConstraint
        ])
        imageView.setContentHuggingPriority(
            imageView.contentHuggingPriority(for: .vertical) + 1,
            for: .vertical
        )
        imageView.setContentCompressionResistancePriority(
            imageView.contentCompressionResistancePriority(for: .vertical) - 1,
            for: .vertical
        )
        
        // Title Label Constraints
        
        let titleLabelTopConstraint = NSLayoutConstraint(
            item: titleLabel,
            attribute: .top,
            relatedBy: .greaterThanOrEqual,
            toItem: imageView,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        )
        let titleLabelLeadingConstraint = NSLayoutConstraint(
            item: titleLabel,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1,
            constant: 2
        )
        let titleLabelTrailingConstraint = NSLayoutConstraint(
            item: titleLabel,
            attribute: .trailing,
            relatedBy: .greaterThanOrEqual,
            toItem: self,
            attribute: .trailing,
            multiplier: 1,
            constant: 2
        )
        let titleLabelBottomConstraint = NSLayoutConstraint(
            item: titleLabel,
            attribute: .bottom,
            relatedBy: .greaterThanOrEqual,
            toItem: self,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        )
        NSLayoutConstraint.activate([
            titleLabelTopConstraint,
            titleLabelBottomConstraint,
            titleLabelLeadingConstraint,
            titleLabelTrailingConstraint
        ])
        titleLabel.setContentCompressionResistancePriority(
            titleLabel.contentCompressionResistancePriority(for: .vertical) + 1,
            for: .vertical
        )
        titleLabel.setContentCompressionResistancePriority(
            titleLabel.contentCompressionResistancePriority(for: .horizontal) + 1,
            for: .horizontal
        )
        titleLabel.adjustsFontSizeToFitWidth = true
        
        self.imageView = imageView
        self.titleLabel = titleLabel
    }
}
