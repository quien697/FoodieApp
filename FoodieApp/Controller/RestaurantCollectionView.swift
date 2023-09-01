//
//  RestaurantCollectionView.swift
//  FoodieApp
//
//  Created by Quien on 2023-08-31.
//

import UIKit

private let itemSpacing: CGFloat = 8
private let sectionInsets: UIEdgeInsets = .init(top: 6, left: 12, bottom: 6, right: 12)

class RestaurantCollectionView: UICollectionView {
  
  var restaurants = [Restaurant]()
  var isOneColumnLayout = false {
    didSet {
      DispatchQueue.main.async { self.reloadSections(IndexSet(integer: 0)) }
    }
  }
  
  private let cellId = "RestaurantCell"
  
  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(initUI),
      name: FoodieController.restaurantsUpdatedNotification,
      object: nil
    )
  }
  
  convenience init() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = itemSpacing
    layout.minimumInteritemSpacing = itemSpacing
    self.init(frame: .zero, collectionViewLayout: layout)
    dataSource = self
    delegate = self
    register(RestaurantCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    backgroundColor = .systemGray6
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateRestaurants(_ restaurants: [Restaurant]) {
    self.restaurants = restaurants
    DispatchQueue.main.async { self.reloadSections(IndexSet(integer: 0)) }
  }
  
  @objc private func initUI() {
    restaurants = FoodieController.shared.restaurants
    DispatchQueue.main.async { self.reloadSections(IndexSet(integer: 0)) }
  }
  
}

// MARK: - UICollectionViewDataSource
extension RestaurantCollectionView : UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return restaurants.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RestaurantCollectionViewCell
    let restaurant = restaurants[indexPath.row]
    if let imageURL = restaurant.imageURL {
      FoodieController.shared.fetchImage(url: imageURL) {
        guard let image = $0 else { return }
        DispatchQueue.main.async {
          if let currentIndexPath = self.indexPath(for: cell), currentIndexPath != indexPath { return }
          cell.imageView.image = image
        }
      }
    }
    cell.nameLabel.text = restaurant.name
    cell.costLabel.text = Array(repeating: "$", count: restaurant.cost).reduce("", +)
    cell.timeCategoriesLabel.text = restaurant.timeCategories.joined(separator: ", ")
    cell.foodCategoriesLabel.text = restaurant.foodCategories.joined(separator: ", ")
    return cell
  }
  
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RestaurantCollectionView : UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.frame.width / 2 - 16
    return CGSize.init(width: (isOneColumnLayout) ? width * 2 + 8 : width, height: width + 45)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }
  
}
