import Foundation

struct BookModel: Codable {

    enum NewBookKeys: String, CodingKey {
        case total

        case books

        case error
    }
    
    enum SearchBookKeys: String, CodingKey {
        case error
        
        case total
        
        case page
        
        case books
    }
    
    enum DetailBookKeys: String, CodingKey {
        case error
        
        case title

        case subtitle
        
        case authors
        
        case publisher
        
        case language
        
        case isbn10

        case isbn13
        
        case pages
        
        case year
        
        case rating
        
        case desc

        case price

        case image

        case url
        
        case pdf
    }
    
    var total: String?

    var page: String?

    var books: [[String: String]]?

    var error: String?

    var title: String?

    var subtitle: String?

    var authors: String?

    var publisher: String?

    var language: String?

    var isbn10: String?

    var isbn13: String?

    var pages: String?

    var year: String?

    var rating: String?

    var desc: String?

    var price: String?

    var image: String?

    var url: String?

    var pdf: [String: String]?
}
