import XCTest
@testable import LoginUnitTests

class LoginUnitTestsTests: XCTestCase {
    
    var sut: ViewController!

    override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = ViewController()
        super.setUp()
    }

    override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }

//    func testExample() throws {
//    // This is an example of a functional test case.
//    // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
    
    func testEmail() throws {
        XCTAssertFalse(sut.validateEmail(candidate: "test"), "Wtf?")
        XCTAssertFalse(sut.validateEmail(candidate: "test@email"), "Invalid email")
        XCTAssertFalse(sut.validateEmail(candidate: "test@email.co,"), "Email doesn't correct")
        XCTAssert(sut.validateEmail(candidate: "test@email.com"), "Success! Valid email!")
        XCTAssertFalse(sut.validateEmail(candidate: "testemail.com"), "Not found @")
        XCTAssertFalse(sut.validateEmail(candidate: "еуые@уьфшд.сщь"), "Incorrect language layout")
        XCTAssertFalse(sut.validateEmail(candidate: "test@emailcom"), "please check email domain")
        XCTAssertFalse(sut.validateEmail(candidate: "test @email.com"), "there is a space in the email address?")
    }
    
    func testPass() throws {
        XCTAssertFalse(sut.validatePassword(candidate: " "), "Wtf?")
        XCTAssertFalse(sut.validatePassword(candidate: "123123"), "Please, shake alphabet book")
        XCTAssertFalse(sut.validatePassword(candidate: "123qwe"))
        XCTAssertFalse(sut.validatePassword(candidate: "qweqwe"))
        XCTAssertTrue(sut.validatePassword(candidate: "Qwe123"), "OK!")
    }

    func testPerformanceExample() throws {
    // This is an example of a performance test case.
        self.measure {
        // Put the code you want to measure the time of here.
        }
    }
}
