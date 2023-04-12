//
//  FlickrImages.swift
//  DogsCollectionView
//
//  Created by Sensehack on 3/26/21.
//
import Foundation

// MARK: - Flickr
struct Flickr: Codable {
    let title: String
    let link: String
    let description: String
    let modified: String
    let generator: String
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let title: String
    let link: String
    let media: Media
    let date_taken: String // Doesn't parse properly?
    let description: String
    let published: String
    let author, author_id, tags: String
}

// MARK: - Media
struct Media: Codable {
    let m: String
}


/*
 {
     "title": "Recent Uploads tagged puppy",
     "link": "https://www.flickr.com/photos/tags/puppy/",
     "description": "",
     "modified": "2021-03-26T16:52:41Z",
     "generator": "https://www.flickr.com",
     "items": [
         {
             "title": "The Eternal Optimist",
             "link": "https://www.flickr.com/photos/veeg/51073944721/",
             "media": {
                 "m": "https://live.staticflickr.com/65535/51073944721_b6a03c983a_m.jpg"
             },
             "date_taken": "2021-03-14T17:28:03-08:00",
             "description": " <p><a href=\"https://www.flickr.com/people/veeg/\">sunsetbeach</a> posted a photo:</p> <p><a href=\"https://www.flickr.com/photos/veeg/51073944721/\" title=\"The Eternal Optimist\"><img src=\"https://live.staticflickr.com/65535/51073944721_b6a03c983a_m.jpg\" width=\"240\" height=\"160\" alt=\"The Eternal Optimist\" /></a></p> ",
             "published": "2021-03-26T16:52:41Z",
             "author": "nobody@flickr.com (\"sunsetbeach\")",
             "author_id": "64658910@N00",
             "tags": "parsley foodplease puppy staffy snacks"
         },
 
 
 */
