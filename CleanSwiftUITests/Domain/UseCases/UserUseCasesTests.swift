//
//  UserUseCasesTests.swift
//  CleanSwiftUITests
//
//  Created by Tuan Truong on 23/03/2023.
//

import XCTest
import Combine
@testable import CleanSwiftUI

final class UserUseCasesTests: XCTestCase, AddUser, GetUsers, DeleteUser, UpdateUser {
    var userGateway: UserGatewayProtocol { mockUserGateway }
    private var mockUserGateway: MockUserGateway!
    
    // MARK: - Add users
    func test_addUser_success() throws {
        let user = User.stub
        mockUserGateway = MockUserGateway(expected: [.addUser(user: user)])
        mockUserGateway.addUserResult = Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
        
        let _ = try awaitPublisher(addUser(user))
        
        mockUserGateway.verify()
    }
    
    func test_addUser_failed() throws {
        let user = User.stub
        let mockError = MockError()
        mockUserGateway = MockUserGateway(expected: [.addUser(user: user)])
        mockUserGateway.addUserResult = Fail(error: mockError).eraseToAnyPublisher()
        
        do {
            let _ = try awaitPublisher(addUser(user))
        } catch {
            XCTAssert(error.isEqual(to: mockError))
        }
        
        mockUserGateway.verify()
    }
    
    // MARK: - Get users
    func test_getUsers_success() throws {
        let users = [User.stub]
        mockUserGateway = MockUserGateway(expected: [.getAllUsers])
        mockUserGateway.getAllUsersResult = Just(users).setFailureType(to: Error.self).eraseToAnyPublisher()
        
        let result = try awaitPublisher(getUsers())
        
        mockUserGateway.verify()
        XCTAssertEqual(result, users)
    }
    
    func test_getUsers_failed() throws {
        let mockError = MockError()
        mockUserGateway = MockUserGateway(expected: [.getAllUsers])
        mockUserGateway.getAllUsersResult = Fail(error: mockError).eraseToAnyPublisher()
        
        do {
            let _ = try awaitPublisher(getUsers())
        } catch {
            XCTAssert(error.isEqual(to: mockError))
        }
        
        mockUserGateway.verify()
    }
    
    // MARK: - Delete user
    
    func test_deleteUser_success() throws {
        let user = User.stub
        mockUserGateway = MockUserGateway(expected: [.deleteUser(id: user.id)])
        mockUserGateway.deleteUserResult = Just(user).setFailureType(to: Error.self).eraseToAnyPublisher()
        
        let result = try awaitPublisher(deleteUser(byID: user.id))
        
        XCTAssertEqual(result, user)
        mockUserGateway.verify()
    }
    
    func test_deleteUser_failed() throws {
        let user = User.stub
        let mockError = MockError()
        mockUserGateway = MockUserGateway(expected: [.deleteUser(id: user.id)])
        mockUserGateway.deleteUserResult = Fail(error: mockError).eraseToAnyPublisher()
            
        do {
            let _ = try awaitPublisher(deleteUser(byID: user.id))
        } catch {
            XCTAssert(error.isEqual(to: mockError))
        }
        
        mockUserGateway.verify()
    }
    
    // MARK: - Update user
    func test_updateUser_success() throws {
        let user = User.stub
        mockUserGateway = MockUserGateway(expected: [.updateUser(user: user)])
        mockUserGateway.updateUserResult = Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
        
        let _ = try awaitPublisher(updateUser(user))
        
        mockUserGateway.verify()
    }
    
    func test_updateUser_failed() throws {
        let user = User.stub
        let mockError = MockError()
        mockUserGateway = MockUserGateway(expected: [.updateUser(user: user)])
        mockUserGateway.updateUserResult = Fail(error: mockError).eraseToAnyPublisher()
        
        do {
            let _ = try awaitPublisher(updateUser(user))
        } catch {
            XCTAssert(error.isEqual(to: mockError))
        }
        
        mockUserGateway.verify()
    }
}
