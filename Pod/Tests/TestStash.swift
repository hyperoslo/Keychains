import UIKit
import XCTest

class TestStash: XCTestCase {

  let service = "stash"
  let password = "banana45?!"
  let account = "John Hyperseed"

  func testAddingPasswordForService() {
    let success = Stash.setPassword(password, service: service, account: account)

    XCTAssertTrue(success)

    Stash.delete(service, account: account)
  }

  func testUpdatePasswordForService() {
    let newPassword = "apple641"
    let success = Stash.setPassword(newPassword, service: service, account: account)

    XCTAssertTrue(success)
    XCTAssertEqual(newPassword, Stash.password(service, account: account))

    Stash.delete(service, account: account)
  }

  func testGetPasswordForService() {
    Stash.setPassword(password, service: service, account: account)

    XCTAssertEqual(self.password, Stash.password(service, account: account))

    Stash.delete(service, account: account)
  }

  func testDeletePasswordForService() {
    XCTAssertTrue(Stash.setPassword(password, service: service, account: account))

    Stash.delete(service, account: account)

    XCTAssertNotEqual(self.password, Stash.password(service, account: account))
  }
}
