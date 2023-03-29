//
//  NewsListViewModel.swift
//  Infos
//
//  Created by Михаил Зиновьев on 29.03.2023.
//

import Foundation

enum NewsListElement {
case news
}

enum NewsListSection {
case headers(_ elements: [NewsListElement])
case basicElements(_ elements: [NewsListElement])
    
    var elements: [NewsListElement] {
        switch self {
        case .headers(let elements),
                .basicElements(let elements):
            return elements
        }
    }
}

protocol NewsListViewModeling {
    func setUpdateHandler(_ handler: (() -> Void)?)
    func setUpdateIndicatorHandler(_ handler: @escaping ((Bool) -> Void))
    func setErrorHandler(_ handler: ((String) -> Void)?)
    func numberOfSections() -> Int
    func numberOfElements(in section: Int) -> Int
    func getElement(at index: Int, section: Int) -> NewsListElement
    func refresh()
}

class NewsListViewModel: BaseViewModel {
    
    private enum Constants {
        static let sthWentWrongErrorMessage = "Ой, что-то пошло не так"
    }
    
    private var updateHandler: (() -> Void)?
    private var updateIndicatorHandler: ((Bool) -> Void)?
    private var errorHandler: ((String) -> Void)?
    private var sections = [NewsListSection]()
    
    // MARK: Init
//    init() {
//        super.init()
//    }
}

// MARK: NewsListViewModeling
extension NewsListViewModel: NewsListViewModeling {
    
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
    
    func getElement(at index: Int, section: Int) -> NewsListElement {
        return sections[section].elements[index]
    }
    
    func refresh() {
        var tempSections = [NewsListSection]()
        
        tempSections.append(.basicElements(basicElements()))
        
        sections = tempSections
        updateIndicatorHandler?(true)
        updateHandler?()
    }
}

// MARK: Private
private extension NewsListViewModel {
    
    func basicElements() -> [NewsListElement] {
        var basicElements = [NewsListElement]()
        
        basicElements.append(.news)
        
        return basicElements
    }
}

