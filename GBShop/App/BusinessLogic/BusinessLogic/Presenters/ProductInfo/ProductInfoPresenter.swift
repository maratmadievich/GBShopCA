//
//  ProductInfoPresenter.swift
//  GBShop
//
//  Created by Марат Нургалиев on 27/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol ProductInfoPresenter {
    
    var router: ProductInfoRouter { get }
    var rowsCount: Int { get }
    
    init (view: ProductInfoView, model: ProductInfoModel, router: ProductInfoRouter)
    
    func viewDidLoad()
    func getReviewRows()
    func configure(cell: ProductInfoCellView, forRow row: Int)
}

class ProductInfoPresenterImplementation: ProductInfoPresenter {
 
    fileprivate weak var view: ProductInfoView?
    private var model: ProductInfoModel
    internal var router: ProductInfoRouter
    
    private var isLoad: Bool = false
    private let requestFactory = RequestFactory()
    
    public var rowsCount: Int {
        return model.reviews.count
    }
    
    
    required init(view: ProductInfoView, model: ProductInfoModel, router: ProductInfoRouter) {
        self.view = view
        self.model = model
        self.router = router
    }
    
    //MARK: - Публичные функции
    public func viewDidLoad() {
        showProductData()
        callGetReviewsRequest()
    }
    
    public func getReviewRows() {
        if !isLoad && model.maxReviewsCount > model.reviews.count {
            callGetReviewsRequest()
        }
    }
    
    public func configure(cell: ProductInfoCellView, forRow row: Int) {
        let review = model.reviews[row]
        cell.setUserName(text: review.userName)
        cell.setReview(text: review.text)
    }
    
    //MARK: - Закрытые функции
    private func callGetReviewsRequest() {
        changeLoad(isLoad: true)
        
        let getReviewsRequest = requestFactory.makeGetReviewsRequestFatory()
        getReviewsRequest.getReviews(idProduct: model.product.id, pageNumber: model.pageNumber) {
            [unowned self] response in
            
            self.changeLoad(isLoad: false)
            switch response.result {
            case .success(let getReviewsResponse):
                self.model.reviews.append(contentsOf: getReviewsResponse.reviews)
                self.model.pageNumber += 1
                self.model.maxReviewsCount = getReviewsResponse.maxRowsCount
                DispatchQueue.main.async {
                    if let view = self.view {
                        view.refreshReviews()
                    }
                }
               
            case .failure(let error):
                DispatchQueue.main.async {
                    if let view = self.view {
                        view.showError(text: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    private func showProductData() {
        guard let view = view else {
            return
        }
        view.setProductName(text: model.product.name)
        view.setProductPrice(text: "Цена: \(model.product.price)р")
    }
    
    private func changeLoad(isLoad: Bool) {
        self.isLoad = isLoad
        if let view = view {
            isLoad ? view.startLoading() : view.finishLoading()
        }
        
    }
    
}


