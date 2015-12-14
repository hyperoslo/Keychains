import UIKit
import XCTest

class TestStash: XCTestCase {

  let service = "stash"
  let password = "banana45?!"
  let account = "John Hyperseed"

  override func tearDown() {
    Stash.delete(service, account: account)
  }

  func testAddingPasswordForService() {
    let success = Stash.setPassword(password, service: service, account: account)

    XCTAssertTrue(success)
  }

  func testUpdatePasswordForService() {
    Stash.setPassword(password, service: service, account: account)
    XCTAssertEqual(password, Stash.password(service, account: account))

    let newPassword = "apple641"
    let success = Stash.setPassword(newPassword, service: service, account: account)

    XCTAssertTrue(success)
    XCTAssertEqual(newPassword, Stash.password(service, account: account))
  }

  func testGetPasswordForService() {
    Stash.setPassword(password, service: service, account: account)

    XCTAssertEqual(password, Stash.password(service, account: account))
  }

  func testDeletePasswordForService() {
    XCTAssertTrue(Stash.setPassword(password, service: service, account: account))

    Stash.delete(service, account: account)

    XCTAssertNotEqual(password, Stash.password(service, account: account))
  }
}
