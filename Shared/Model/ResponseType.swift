// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let start, welcomeNumFound, numFound: Int
    let docs: [Doc]

    enum CodingKeys: String, CodingKey {
        case start
        case welcomeNumFound = "num_found"
        case numFound, docs
    }
}

// MARK: - Doc
struct Doc: Codable, Identifiable {
    let id: String
    let titleSuggest: String
    let editionKey: [String]
    let coverI: Int?
    let isbn: [String]?
    let hasFulltext: Bool
    let text, authorName, seed: [String]
    let oclc: [String]?
    let authorKey: [String]
    let subject: [String]?
    let title: String
    let publishDate: [String]
    let type: String
    let ebookCountI: Int
    let publishPlace: [String]
    let editionCount: Int
    let lcc: [String]?
    let publisher, language: [String]
    let lastModifiedI: Int
    let coverEditionKey: String?
    let publishYear: [Int]?
    let firstPublishYear: Int?
    let idDnb: [String]?
    let subtitle: String?
    let place: [String]?
    var pages: String? = ""
    var numberOfPages: String?
    var isCorrect: Bool?

    
    enum CodingKeys: String, CodingKey {
        case titleSuggest = "title_suggest"
        case id = "key"
        case editionKey = "edition_key"
        case coverI = "cover_i"
        case isbn
        case hasFulltext = "has_fulltext"
        case text
        case authorName = "author_name"
        case seed, oclc
        case authorKey = "author_key"
        case subject, title
        case publishDate = "publish_date"
        case type
        case ebookCountI = "ebook_count_i"
        case publishPlace = "publish_place"
        case editionCount = "edition_count"
        case lcc, publisher, language
        case lastModifiedI = "last_modified_i"
        case coverEditionKey = "cover_edition_key"
        case publishYear = "publish_year"
        case firstPublishYear = "first_publish_year"
        case idDnb = "id_dnb"
        case subtitle, place
        case pages
        case numberOfPages = "number_of_pages"
        case isCorrect
    }
}
