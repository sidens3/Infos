//
//  NewsListViewModel.swift
//  Infos
//
//  Created by Михаил Зиновьев on 29.03.2023.
//

import Foundation

enum NewsListElement {
    case search
    case news(Article)
}

enum NewsListSection: Equatable {
    case headers(_ elements: [NewsListElement])
    case basicElements(_ elements: [NewsListElement])
    
    var elements: [NewsListElement] {
        switch self {
        case .headers(let elements),
                .basicElements(let elements):
            return elements
        }
    }
    
    static func == (lhs: NewsListSection, rhs: NewsListSection) -> Bool {
        switch (lhs, rhs) {
        case (.headers, .headers),
            (.basicElements, .basicElements):
            return true
        default:
            return false
        }
    }
}

protocol NewsListViewModeling {
    func setUpdateHandler(_ handler: (() -> Void)?)
    func setBasicElementsUpdateHandler(_ handler: @escaping ((Int) -> Void))
    func setUpdateIndicatorHandler(_ handler: @escaping ((Bool) -> Void))
    func setSelectNewsHandler(_ handler: @escaping ((Article) -> Void))
    func setErrorHandler(_ handler: ((String) -> Void)?)
    
    func numberOfSections() -> Int
    func numberOfElements(in section: Int) -> Int
    func getElement(at index: Int, section: Int) -> NewsListElement
    func refresh()
    
    func makeSearch(for text: String)
    func selectNews(by index: Int)
}

class NewsListViewModel: BaseViewModel {
    
    private enum Constants {
        static let sthWentWrongErrorMessage = "Ой, что-то пошло не так"
        static let minSearchCharactersCount = 2
        static let searchDelayTimeInterval: DispatchTimeInterval = .milliseconds(500)
        static let defaultSearchText = "Недавнее"
    }
    
    private let networkManager: NewsManaging
    
    private var newsWorkItem: DispatchWorkItem?
    
    private var updateHandler: (() -> Void)?
    private var basicElementsUpdateHandler: ((Int) -> Void)?
    private var updateIndicatorHandler: ((Bool) -> Void)?
    private var selectNewsHandler: ((Article) -> Void)?
    private var errorHandler: ((String) -> Void)?
    private var sections = [NewsListSection]()
    
    private var searchText: String = Constants.defaultSearchText {
        didSet {
            newsWorkItem?.cancel()
            makeSearch(for: searchText)
        }
    }
    
    private var totalResults: Int = 0
    private var articles: [Article] = [] {
        didSet {
            updateBasicElements()
        }
    }
    
    // MARK: Init
    init(networkManager: NewsManaging) {
        self.networkManager = networkManager
        
        super.init()
    }
}

// MARK: NewsListViewModeling
extension NewsListViewModel: NewsListViewModeling {
    
    func setUpdateHandler(_ handler: (() -> Void)?) {
        updateHandler = handler
    }
    
    func setBasicElementsUpdateHandler(_ handler: @escaping ((Int) -> Void)) {
        basicElementsUpdateHandler = handler
    }
    
    func setUpdateIndicatorHandler(_ handler: @escaping ((Bool) -> Void)) {
        updateIndicatorHandler = handler
    }
    
    func setSelectNewsHandler(_ handler: @escaping ((Article) -> Void)) {
        selectNewsHandler = handler
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
        updateSections()
        resetSearchText()
        
        updateIndicatorHandler?(true)
        updateHandler?()
    }
    
    func makeSearch(for text: String) {
        guard text.count > Constants.minSearchCharactersCount else { return }
        let workItem = DispatchWorkItem { [weak self] in
            self?.getNews(for: text)
        }
        newsWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.searchDelayTimeInterval, execute: workItem)
    }
    
    func selectNews(by index: Int) {
        guard articles.count > index else { return }
        selectNewsHandler?(articles[index])
    }
}

// MARK: Private
private extension NewsListViewModel {
    
    func getHeaderElements() -> [NewsListElement] {
        var headerElements: [NewsListElement] = []
        headerElements.append(.search)
        return headerElements
    }
    
    func getBasicElements() -> [NewsListElement] {
        return articles.map { .news($0) }
    }
    
    func updateSections() {
        var tempSections = [NewsListSection]()
        
        tempSections.append(.headers(getHeaderElements()))
        tempSections.append(.basicElements(getBasicElements()))
        
        sections = tempSections
    }
    
    func resetSearchText() {
        searchText.removeAll()
        makeSearch(for: Constants.defaultSearchText)
    }
    
    func updateBasicElements() {
        guard let basicElementsSectionIndex = sections.firstIndex(where: { $0 == .basicElements([]) }) else { return }
        refreshBasicElements(on: basicElementsSectionIndex)
        basicElementsUpdateHandler?(basicElementsSectionIndex)
    }

    func refreshBasicElements(on index: Int) {
        sections[index] = .basicElements(getBasicElements())
    }
    
    func getNews(for text: String) {
        updateIndicatorHandler?(true)
        networkManager.requestNews(query: text) { [weak self] result in
            switch result {
            case .success(let value):
                self?.articles = value.articles
                self?.totalResults = value.totalResults
                self?.updateIndicatorHandler?(false)
            case .failure(let error):
                self?.errorHandler?(error.localizedDescription)
                self?.updateIndicatorHandler?(false)
            }
        }
    }
}

