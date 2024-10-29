import Foundation

struct MockData {
    static let shared = MockData()
    
    private let category: ListSection = {
        .category([.init(title: "RANDOM", subtitle: "", image: ""),
                   .init(title: "SPORTS", subtitle: "", image: ""),
                   .init(title: "GAMING", subtitle: "", image: ""),
                   .init(title: "POLITICS", subtitle: "", image: ""),
                   .init(title: "LIFE", subtitle: "", image: ""),
                   .init(title: "SCIENCE", subtitle: "", image: ""),
                   .init(title: "ANIMALS", subtitle: "", image: "")
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
