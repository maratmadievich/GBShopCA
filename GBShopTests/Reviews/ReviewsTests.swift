//
//  ReviewsTests.swift
//  GBShopTests
//
//  Created by Марат Нургалиев on 07/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import XCTest
import Alamofire
@testable import GBShop

class ReviewsTests: XCTestCase {
    
    let expectation = XCTestExpectation(description: "Тестирование методов заказов")
    
    var requestFactory: RequestFactory!
    
    var idUser: Int!
    var idReview: Int!
    var idProduct: Int!
    var pageNumber: Int!
    var reviewText: String!
    
    
    override func setUp() {
        
        requestFactory = RequestFactory()
        
        idUser = 1
        idReview = 1
        idProduct = 1
        pageNumber = 1
        reviewText = "Новый отзыв"
    }
    
    override func tearDown() {
        idUser = nil
        idReview = nil
        idProduct = nil
        reviewText = nil
        pageNumber = nil
        requestFactory = nil
    }
    
    func testGetReviews() {
        
        let reviewsRequest = requestFactory.makeGetReviewsRequestFatory()
        
        reviewsRequest.getReviews(idProduct: idProduct, pageNumber: pageNumber) { response in
            
            switch response.result {
                
            case .success(let reviewResult):
                
                self.checkReviewsResult(reviewResult)
                
                break
                
            case .failure(let error):
                
                XCTFail("ReviewsTests: \(error.localizedDescription)")
            }
            
            self.expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    
    private func checkReviewsResult(_ reviewResult: ReviewsResult) {
        
        if reviewResult.maxRowsCount < 0 {
            XCTFail("ReviewsTests: неверно указано мах. количество строк")
        }
        if reviewResult.pageNumber < 0 {
            XCTFail("ReviewsTests: неверно указан номер страницы")
        }
        
    }
    
    
    func testAddReview() {
        
        let addReviewRequest = requestFactory.makeAddReviewRequestFatory()
        
        addReviewRequest.addReview(idUser: idUser, idProduct: idProduct, text: reviewText) { response in
            
            switch response.result {
                
            case .success(let addReviewResult):
                
                self.checkAddReviewResult(addReviewResult)
                
                break
                
            case .failure(let error):
                
                XCTFail("ReviewsTests: \(error.localizedDescription)")
            }
            
            self.expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    
    private func checkAddReviewResult(_ addReviewResult: AddReviewResult) {
        
        if addReviewResult.result != 1 {
            
            XCTFail("ReviewsTests: неверный ответ от сервера")
        }
        
        if addReviewResult.message.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            
            XCTFail("ReviewsTests: ответ от сервера не корректен")
        }
        
    }
    
    
    func testRemoveReview() {
        
        let removeReviewRequest = requestFactory.makeRemoveReviewRequestFatory()
        
        removeReviewRequest.removeReview(id: idReview) { response in
            
            switch response.result {
                
            case .success(let removeReviewResult):
                
                self.checkRemoveReviewResult(removeReviewResult)
                
                break
                
            case .failure(let error):
                
                XCTFail("ReviewsTests: \(error.localizedDescription)")
            }
            
            self.expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    
    private func checkRemoveReviewResult(_ removeReviewResult: RemoveReviewResult) {
        
        if removeReviewResult.result != 1 {
            
            XCTFail("ReviewsTests: неверный ответ от сервера")
        }
        
    }
    
}


