import Foundation

struct BookModel: Decodable {
    /// ShowNewBook
    /// https://api.itbook.store/1.0/new
    enum NewBookKeys: String, CodingKey {
        case total

        case books

        case error
    }
    
    /// SearchBook
    /// https://api.itbook.store/1.0/search/{query(검색어)/{page}
    enum SearchBookKeys: String, CodingKey {
        case error
        
        case total
        
        case page
        
        case books
    }
    
    /// DetailBook
    /// https://api.itbook.store/1.0/books/{isbn13}
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
    
    var books: [BookItem]?

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
