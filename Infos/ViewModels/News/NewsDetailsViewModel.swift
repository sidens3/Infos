//
//  NewsDetailsViewModel.swift
//  Infos
//
//  Created by Михаил Зиновьев on 01.04.2023.
//

import Foundation

enum NewsDetailsElement {
    case image(String)
    case title(String)
    case description(String)
    case content(String)
}

enum NewsDetailsSection {
    
    case basicElements(_ elements: [NewsDetailsElement])
    
    var elements: [NewsDetailsElement] {
        switch self {
        case .basicElements(let elements):
            return elements
        }
    }
}

protocol NewsDetailsViewModeling {
    func setUpdateHandler(_ handler: (() -> Void)?)
    func setUpdateIndicatorHandler(_ handler: @escaping ((Bool) -> Void))
    func setErrorHandler(_ handler: ((String) -> Void)?)
    func numberOfSections() -> Int
    func numberOfElements(in section: Int) -> Int
    func getElement(at index: Int, section: Int) -> NewsDetailsElement
    func refresh()
}

class NewsDetailsViewModel: BaseViewModel {
    
    private enum Constants {
        static let sthWentWrongErrorMessage = "Ой, что-то пошло не так"
    }
    
    private var updateHandler: (() -> Void)?
    private var updateIndicatorHandler: ((Bool) -> Void)?
    private var errorHandler: ((String) -> Void)?
    private let data: Article
    private var sections = [NewsDetailsSection]()
    
    // MARK: Init
    init(data: Article) {
        self.data = data
        super.init()
    }
}

// MARK: NewsDetailsViewModeling
extension NewsDetailsViewModel: NewsDetailsViewModeling {
    
    func setUpdateHandler(_ handler: (() -> Void)?) {
        updateHandler = handler
    }
    
    func setUpdateIndicatorHandler(_ handler: @escaping ((Bool) -> Void)) {
        updateIndicatorHandler = handler
    }
    
    func setErrorHandler(_ handler: ((String) -> Void)?) {
        errorHandler = handler
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfElements(in section: Int) -> Int {
        guard sections.indices.contains(section) else {
            return 0
        }
        return sections[section].elements.count
    }
    
    func getElement(at index: Int, section: Int) -> NewsDetailsElement {
        return sections[section].elements[index]
    }
    
    func refresh() {
        var tempSections = [NewsDetailsSection]()
        
        tempSections.append(.basicElements(basicElements()))
        
        sections = tempSections
        updateIndicatorHandler?(true)
        updateHandler?()
    }
}

// MARK: Private
private extension NewsDetailsViewModel {
    
    func basicElements() -> [NewsDetailsElement] {
        var basicElements = [NewsDetailsElement]()
        
        if let imageUrlString = data.urlToImage {
            basicElements.append(.image(imageUrlString))
        }
        
        basicElements.append(.title(data.title))
        
        if let description = data.description {
            basicElements.append(.description(description))
        }
        
        if let content = data.content {
            basicElements.append(.content(content))
        }
        
        return basicElements
    }
}

