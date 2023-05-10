//
//  Product.swift
//  swift-ui-product-shop
//
//  Created by Kautilya Save on 5/10/23.
//

import Foundation



struct ProductsAPI: Codable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}




struct Product: Codable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
}


/**
 
 "products": [
 {
   "id": 1,
   "title": "iPhone 9",
   "description": "An apple mobile which is nothing like apple",
   "price": 549,
   "discountPercentage": 12.96,
   "rating": 4.69,
   "stock": 94,
   "brand": "Apple",
   "category": "smartphones",
   "thumbnail": "https://i.dummyjson.com/data/products/1/thumbnail.jpg",
   "images": [
     "https://i.dummyjson.com/data/products/1/1.jpg",
     "https://i.dummyjson.com/data/products/1/2.jpg",
     "https://i.dummyjson.com/data/products/1/3.jpg",
     "https://i.dummyjson.com/data/products/1/4.jpg",
     "https://i.dummyjson.com/data/products/1/thumbnail.jpg"
   ]
 },
 */
