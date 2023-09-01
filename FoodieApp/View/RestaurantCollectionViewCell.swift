//
//  RestaurantCollectionViewCell.swift
//  FoodieApp
//
//  Created by Quien on 2023-08-31.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
  
  let imageView: UIImageView = {
    let iv = UIImageView()
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.contentMode = .scaleAspectFill
    iv.layer.masksToBounds = true
    return iv
  }()
  
  let nameLabel: UILabel = {
    let nl = UILabel()
    nl.font = UIFont.systemFont(ofSize: 15, weight: .bold)
    nl.adjustsFontSizeToFitWidth = true
    nl.allowsDefaultTighteningForTruncation = true
    nl.minimumScaleFactor = 0.75
    return nl
  }()
  
  let costLabel: UILabel = {
    let cl = UILabel()
    cl.font = UIFont.systemFont(ofSize: 10)
    cl.textAlignment = .right
    return cl
  }()
  
  let timeCategoriesLabel: UILabel = {
    let tcl = UILabel()
    tcl.font = UIFont.systemFont(ofSize: 12)
    tcl.adjustsFontSizeToFitWidth = true
    tcl.allowsDefaultTighteningForTruncation = true
    tcl.minimumScaleFactor = 0.75
    return tcl
  }()
  
  let foodCategoriesLabel: UILabel = {
    let fcl = UILabel()
    fcl.font = UIFont.systemFont(ofSize: 12)
    fcl.adjustsFontSizeToFitWidth = true
    fcl.allowsDefaultTighteningForTruncation = true
    fcl.minimumScaleFactor = 0.75
    return fcl
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemBackground
    let cvSize = contentView.bounds.size
    contentView.addSubview(imageView)
    contentView.addSubview(nameLabel)
    contentView.addSubview(costLabel)
    contentView.addSubview(timeCategoriesLabel)
    contentView.addSubview(foodCategoriesLabel)
    
    imageView.matchParent(padding: .init(top: 0, left: 0, bottom: cvSize.height * 0.35, right: 0))
    nameLabel.anchors(
      topAnchor: imageView.bottomAnchor,
      bottomAnchor: nil,
      leadingAnchor: contentView.leadingAnchor,
      trailingAnchor: contentView.trailingAnchor,
      padding: .init(top: 6, left: 6, bottom: 0, right: cvSize.width * 0.2)
    )
    costLabel.anchors(
      topAnchor: imageView.bottomAnchor,
      bottomAnchor: nil,
      leadingAnchor: nameLabel.trailingAnchor,
      trailingAnchor: contentView.trailingAnchor,
      padding: .init(top: 10, left: 6, bottom: 0, right: 6)
    )
    timeCategoriesLabel.anchors(
      topAnchor: costLabel.bottomAnchor,
      bottomAnchor: nil,
      leadingAnchor: contentView.leadingAnchor,
      trailingAnchor: contentView.trailingAnchor,
      padding: .init(top: 10, left: 6, bottom: 0, right: 6)
    )
    foodCategoriesLabel.anchors(
      topAnchor: timeCategoriesLabel.bottomAnchor,
      bottomAnchor: nil,
      leadingAnchor: contentView.leadingAnchor,
      trailingAnchor: contentView.trailingAnchor,
      padding: .init(top: 4, left: 6, bottom: 0, right: 6)
    )
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
