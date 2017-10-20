import Foundation
import Security

public struct Keychain {

  /// This is used to identifier your service
  public static let bundleIdentifier: String = {
    return Bundle.main.bundleIdentifier ?? ""
  }()

  /// Actions that can be performed with Keychain, mostly for handling password
  enum Action {
    /// Insert an item into keychain
    case insert

    /// Fetch an item from keychain
    case fetch

    /// Delete an item from keychain
    case delete
  }

  // MARK: - Public methods


  /// Query password using account in a Keychain service
  ///
  /// - Parameters:
  ///   - account: The account, this is for kSecAttrAccount
  ///   - service: The service, this is for kSecAttrService
  ///   - accessGroup: The access group, this is for kSecAttrAccessGroup
  /// - Returns: The password
  public static func password(forAccount account: String,
                              service: String = bundleIdentifier,
                              accessGroup: String = "") -> String? {
    guard !service.isEmpty && !account.isEmpty else {
      return nil
    }

    var query = [
      kSecAttrAccount as String : account,
      kSecAttrService as String : service,
      kSecClass as String : kSecClassGenericPassword] as [String : Any]

    if !accessGroup.isEmpty {
      query[kSecAttrAccessGroup as String] = accessGroup
    }

    return Keychain.query(.fetch, query as [String : AnyObject]).1
  }


  /// Set the password for the account in a Keychain service
  ///
  /// - Parameters:
  ///   - password: The password string you want to set
  ///   - account: The account, this is for kSecAttrAccount
  ///   - service: The service, this is for kSecAttrService
  ///   - accessGroup: The access group, this is for kSecAttrAccessGroup
  /// - Returns: True if the password can be set successfully
  @discardableResult public static func setPassword(_ password: String, forAccount account: String, service: String = bundleIdentifier, accessGroup: String = "") -> Bool {
    guard !service.isEmpty && !account.isEmpty else {
      return false
    }

    var query = [
      kSecAttrAccount as String : account,
      kSecAttrService as String : service,
      kSecClass as String : kSecClassGenericPassword,
      kSecAttrAccessible as String : kSecAttrAccessibleAlways] as [String : Any]

    if !accessGroup.isEmpty {
      query[kSecAttrAccessGroup as String] = accessGroup
    }

    return Keychain.query(.insert, query as [String : AnyObject], password).0 == errSecSuccess
  }


  /// Delete password for the account in a Keychain service
  ///
  /// - Parameters:
  ///   - account: The account, this is for kSecAttrAccount
  ///   - service: The service, this is for kSecAttrService
  /// - Returns: True if the password can be safely deleted
  @discardableResult public static func deletePassword(forAccount account: String, service: String = bundleIdentifier, accessGroup: String = "") -> Bool {
    guard !service.isEmpty && !account.isEmpty else {
      return false
    }

    var query = [
      kSecAttrAccount as String: account,
      kSecAttrService as String : service,
      kSecClass as String : kSecClassGenericPassword
    ] as [String : Any]

    if !accessGroup.isEmpty {
      query[kSecAttrAccessGroup as String] = accessGroup
    }

    return Keychain.query(.delete, query as [String : AnyObject]).0 == errSecSuccess
  }

  // MARK: - Private methods


  /// A helper method to query Keychain based on some actions
  ///
  /// - Parameters:
  ///   - action: The action
  ///   - query: A dictionary containing keychain parameters
  ///   - password: The password
  /// - Returns: A tuple with status and returned password
  fileprivate static func query(_ action: Action, _ query: [String : AnyObject], _ password: String = "") -> (OSStatus, String) {
    let passwordData = password.data(using: String.Encoding.utf8)
    var returnPassword = ""
    var status = SecItemCopyMatching(query as CFDictionary, nil)
    var attributes = [String : AnyObject]()

    switch action {
    case .insert:
      switch status {
      case errSecSuccess:
        attributes[kSecValueData as String] = passwordData as AnyObject?
        status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
      case errSecItemNotFound:
        var query = query
        query[kSecValueData as String] = passwordData as AnyObject?
        status = SecItemAdd(query as CFDictionary, nil)
      default: break
      }
    case .fetch:
      var query = query
      query[kSecReturnData as String] = true as AnyObject?
      query[kSecMatchLimit as String] = kSecMatchLimitOne

      var result: CFTypeRef?
      status = SecItemCopyMatching(query as CFDictionary, &result)

      if let result = result as? Data,
        let password = String(data: result, encoding: String.Encoding.utf8) {
          returnPassword = password
      }
    case .delete:
      status = SecItemDelete(query as CFDictionary)
    }

    return (status, returnPassword)
  }
}
