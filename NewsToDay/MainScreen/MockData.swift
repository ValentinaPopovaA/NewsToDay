import Foundation

struct MockData {
    static let shared = MockData()
    
    private let category: ListSection = {
        .category([.init(title: "Random", subtitle: "", image: ""),
                   .init(title: "Sports", subtitle: "", image: ""),
                   .init(title: "Gaming", subtitle: "", image: ""),
                   .init(title: "Politics", subtitle: "", image: ""),
                   .init(title: "Life", subtitle: "", image: ""),
                   .init(title: "Science", subtitle: "", image: ""),
                   .init(title: "Animals", subtitle: "", image: "")
        ])
    }()
    
    private let newsPreview: ListSection = {
        .newsPreview([.init(title: "Politics", subtitle: "The latest situation in the presidential election", image: "moscow"),
                      .init(title: "Science", subtitle: "A Simple Trick For Creating Color Palettes Quickly", image: "new-york"),
                      .init(title: "Art", subtitle: "Six steps to creating a color palette", image: "tokio")
                      
        ])
    }()
    
    var pageData: [ListSection] {
        [category, newsPreview]
    }
}
