import XCTest

class LoginUnitTestsUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        
        continueAfterFailure = false

        // print("\n= = = = = = setUpWithError = = = = = =\n")
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        // print("\n~ ~ ~ ~ ~ ~ ~ tearDownWithError ~ ~ ~ ~ ~ ~ ~ ~\n")
    }
    
//    func testExample() throws {
        // UI tests must launch the application that they test.
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
    
    func testEmailPass1() throws {
        //MARK: заведомо неверные логин и пароль
        
        let app = XCUIApplication()
        app.launch()
        
        let emailTextField = app.textFields["email"]
        let passwordTextField = app.textFields["password"]
        let button = app.buttons["войти"].staticTexts["войти"]
        
        emailTextField.press(forDuration: 0.1)
        emailTextField.typeText("invalid@email")
        
        passwordTextField.press(forDuration: 0.1)
        passwordTextField.typeText("qwerty")
        
        button.tap()
        
        let errorStaticText = app.staticTexts["error"]
        XCTAssertTrue(errorStaticText.exists, "Fail validation")
    }
    
    func testEmailPass2() throws {
        //MARK: верный логин и неверный пароль
        
        let app = XCUIApplication()
        app.launch()
        
        let emailTextField = app.textFields["email"]
        let passwordTextField = app.textFields["password"]
        let button = app.buttons["войти"].staticTexts["войти"]
        
        emailTextField.press(forDuration: 0.1)
        emailTextField.typeText("invalid@email")
        emailTextField.clearAndtypeText("valid@email.com")
        
        passwordTextField.press(forDuration: 0.1)
        passwordTextField.typeText("qwerty")
        passwordTextField.clearAndtypeText("Ytrewq")
        button.tap()
        
        /*
        let errorStaticText = app.staticTexts["error"]
         
        // XCTAssertFalse потому что в staticTexts будет сообщение с рекомендацией для пароля
        XCTAssertFalse(errorStaticText.exists, "Fail validation")
        */
        
        let message = app.staticTexts["Enter min 6 sym include 1 upper, 1 lowercase character and 1 num"]
        XCTAssertTrue(message.exists)
    }
    
    func testEmailPass3() throws {
        //MARK: верный логин и пароль
        
        let app = XCUIApplication()
        app.launch()
        
        let emailTextField = app.textFields["email"]
        let passwordTextField = app.textFields["password"]
        let button = app.buttons["войти"].staticTexts["войти"]
        
        emailTextField.press(forDuration: 0.1)
        emailTextField.typeText("valid@email.com")
        
        passwordTextField.press(forDuration: 0.1)
        passwordTextField.typeText("Ytrewq")
        button.tap()

        passwordTextField.clearAndtypeText("Ytrewq1")
        button.tap()
        
        let successStaticText = app.staticTexts["success"]
        XCTAssertTrue(successStaticText.exists, "Success validation")
    }
        
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                
                // XCUIApplication().launch() // после тестов перезапускает приложение еще несколько раз

                XCUIApplication().terminate()
            }
        }
    }
}
extension XCUIElement {

    func clearAndtypeText(_ text: String) {
        guard let valueString = self.value as? String else {
            // попытка ввести текст не в текстовое поле
            XCTFail("clearAndtypeText FAIL")
            return
        }

        self.tap()

        let eraser = String(repeating: XCUIKeyboardKey.delete.rawValue, count: valueString.count)

        self.typeText(eraser)
        self.typeText(text)
    }
}
