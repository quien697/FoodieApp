//
//  FoodieController.swift
//  FoodieApp
//
//  Created by Quien on 2023-08-31.
//

import Foundation
import UIKit

class FoodieController {
  
  static let restaurantsUpdatedNotification = Notification.Name("FoodieController.restaurantDataUpdated")
  static let shared = FoodieController()
  
  static let TIME_INDEX = 0, FOOD_INDEX = 1
  
  private var restaurantByID = [Int: Restaurant]()
  private var restaurantByCategory = [[String: [Restaurant]]].init(repeating: [String : [Restaurant]](), count: 2)
  
  // MARK: - Getters
  
  private(set) var restaurants = [Restaurant]()
  
  var timeCategories: [String] {
    get { return restaurantByCategory[FoodieController.TIME_INDEX].keys.sorted() }
  }
  
  var foodCategories: [String] {
    get { return restaurantByCategory[FoodieController.FOOD_INDEX].keys.sorted() }
  }
  
  func restaurant(withID restaurantID: Int) -> Restaurant? {
    return restaurantByID[restaurantID]
  }
  
  func restaurants(in category: String, of type: Int) -> [Restaurant]? {
    return restaurantByCategory[type][category]
  }
  
  // MARK: - Data Interface
  
  func loadData() {
    FoodieController.shared.fetchRestaurants {
      self.processData($0)
    }
  }
  
  private func processData(_ restaurants: [Restaurant]) {
    restaurantByID.removeAll()
    restaurantByCategory[FoodieController.TIME_INDEX].removeAll()
    restaurantByCategory[FoodieController.FOOD_INDEX].removeAll()
    
    self.restaurants = restaurants
    for restaurant in restaurants {
      restaurantByID[restaurant.id] = restaurant
      for time in restaurant.timeCategories {
        restaurantByCategory[FoodieController.TIME_INDEX][time, default: []].append(restaurant)
      }
      for food in restaurant.foodCategories {
        restaurantByCategory[FoodieController.FOOD_INDEX][food, default: []].append(restaurant)
      }
    }
    
    DispatchQueue.main.async {
      NotificationCenter.default.post(name: FoodieController.restaurantsUpdatedNotification, object: nil)
    }
  }
  
  func fetchRestaurants(completion: @escaping ([Restaurant]) -> Void) {
    completion(sampleRestaurants())
  }
  
  func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let data = data, let image = UIImage(data: data) {
        completion(image)
      } else {
        completion(nil)
      }
    }
    task.resume()
  }
  
}

