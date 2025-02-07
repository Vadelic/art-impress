////
////  ImageCharacteristicViewModelTests.swift
////  art-impress
////
////  Created by Vadim Komyshenets on 07.02.2025.
////
//
//
//import XCTest
//@testable import art_impress
//
//final class ImageCharacteristicViewModelTests: XCTestCase {
//    var viewModel: ImageCharacteristicViewModel!
//    var mockArtRemoteService: MockArtRemoteService!
//
//    override func setUpWithError() throws {
//        try super.setUpWithError()
//        
//        mockArtRemoteService = MockArtRemoteService()
//        viewModel = ImageCharacteristicViewModel()
//        ArtRemoteService.shared = mockArtRemoteService
//    }
//
//    override func tearDownWithError() throws {
//        ArtRemoteService.shared = nil
//        viewModel = nil
//        mockArtRemoteService = nil
//        try super.tearDownWithError()
//    }
//
//    func testFetchImageTagsSuccess() {
//        let expectation = XCTestExpectation(description: "Fetch image tags success")
//        
//        mockArtRemoteService.mockedCharacteristics = MockStore.characteristics
//        
//        viewModel.fetchImageTags()
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            XCTAssertNotNil(self.viewModel.characteristics)
//            XCTAssertEqual(self.viewModel.characteristics, MockStore.characteristics)
//            expectation.fulfill()
//        }
//        
//        wait(for: [expectation], timeout: 1.0)
//    }
//
//    func testFetchImageTagsFailure() {
//        let expectation = XCTestExpectation(description: "Fetch image tags failure")
//        
//        mockArtRemoteService.shouldReturnError = true
//        
//        viewModel.fetchImageTags()
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            XCTAssertNil(self.viewModel.characteristics)
//            expectation.fulfill()
//        }
//        
//        wait(for: [expectation], timeout: 1.0)
//    }
//}
//
//// Класс для мока сервиса
//class MockArtRemoteService: ArtRemoteServiceProtocol {
//    var mockedCharacteristics: CharacteristicResponse?
//    var shouldReturnError = false
//
//    func fetchImageProperties() -> AnyPublisher<CharacteristicResponse, Error> {
//        if let characteristics = mockedCharacteristics {
//            return Just(characteristics).setFailureType(to: Error.self).eraseToAnyPublisher()
//        } else if shouldReturnError {
//            return Fail(error: NSError(domain: "", code: 0, userInfo: nil)).eraseToAnyPublisher()
//        } else {
//            fatalError("No mocked data or error provided.")
//        }
//    }
//}
