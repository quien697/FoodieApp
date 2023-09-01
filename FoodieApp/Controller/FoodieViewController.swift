//
//  ViewController.swift
//  FoodieApp
//
//  Created by Quien on 2023-08-31.
//

import UIKit

protocol FoodieDelegate {
  func filterItem(_ restaurants: [Restaurant])
}

class FoodieViewController: UIViewController {
  
  private let filterBarCollectionView: FilterBarCollectionView = {
    let filterBarCV = FilterBarCollectionView()
    filterBarCV.translatesAutoresizingMaskIntoConstraints = false
    filterBarCV.constraintHeight(equalToConstant: 60)
    return filterBarCV
  }()
  
  private let restaurantCollectionView: RestaurantCollectionView = {
    let restaurantCV = RestaurantCollectionView()
    restaurantCV.translatesAutoresizingMaskIntoConstraints = false
    return restaurantCV
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemGray6
    navigationController?.navigationBar.prefersLargeTitles = false
    navigationController?.navigationBar.barTintColor = .tertiarySystemBackground
    navigationItem.rightBarButtonItem = .init(
      image: UIImage.init(systemName: "rectangle.grid.2x2"),
      style: UIBarButtonItem.Style.plain,
      target: self,
      action: #selector(layoutChange)
    )
    navigationItem.title = "Foodie"
    navigationItem.largeTitleDisplayMode = .never
    
    setupFilterBarCollectionView()
    setupRestaurantCollectionView()
  }
  
  private func setupFilterBarCollectionView() {
    view.addSubview(filterBarCollectionView)
    filterBarCollectionView.foodieDelegate = self
    filterBarCollectionView.anchors(
      topAnchor: view.safeAreaLayoutGuide.topAnchor,
      bottomAnchor: nil,
      leadingAnchor: view.safeAreaLayoutGuide.leadingAnchor,
      trailingAnchor: view.safeAreaLayoutGuide.trailingAnchor
    )
  }
  
  private func setupRestaurantCollectionView() {
    view.addSubview(restaurantCollectionView)
    restaurantCollectionView.anchors(
      topAnchor: filterBarCollectionView.bottomAnchor,
      bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
      leadingAnchor: view.safeAreaLayoutGuide.leadingAnchor,
      trailingAnchor: view.safeAreaLayoutGuide.trailingAnchor
    )
  }
  
  @objc private func layoutChange() {
    restaurantCollectionView.isOneColumnLayout = !restaurantCollectionView.isOneColumnLayout
    navigationItem.rightBarButtonItem?.image = UIImage.init(systemName: (restaurantCollectionView.isOneColumnLayout) ? "rectangle.grid.1x2" : "rectangle.grid.2x2")
  }
  
}

extension FoodieViewController : FoodieDelegate {
  
  func filterItem(_ restaurants: [Restaurant]) {
    restaurantCollectionView.updateRestaurants(restaurants)
  }
  
}
