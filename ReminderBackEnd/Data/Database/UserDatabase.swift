//
//  UserDatabase.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation
import SQLite3

class UserDatabase {
    static var database: SQLite?
    
    init() {
        while connect() == false {
            print("Reconnecting to DB...")
            sleep(1)
        }
        Constant.updateFromDB()
    }
    
    
    private var createStatement: String {
        """
        CREATE TABLE User(
        username VARCHAR PRIMARY KEY NOT NULL,
        password VARCHAR NOT NULL,
        image VARCHAR
        );
        """
    }
    
    private var insertStatement: String {
        """
        INSERT INTO User(username, password, image)
        VALUES (?, ?, ?);
        """
    }
    
    private var selectStatement: String {
        """
        SELECT password FROM User WHERE username = ?;
        """
    }
    
    private var updateStatement: String {
        """
        UPDATE ? SET password = ?
        WHERE username = ?;
        """
    }
    
    private var deleteStatement: String {
        """
        DELETE FROM User
        WHERE username = ?;
        """
    }
    
    private func connect() -> Bool {
        var result = true
        let databaseFolder = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask)[0].appendingPathComponent(Constant.DB_FOLDER)
        
        do {
            try FileManager.default.createDirectory(at: databaseFolder, withIntermediateDirectories: true, attributes: nil)
        } catch let error {
            print("Failed to create directory while connecting to database")
            print(error)
            return false
        }
        let DB_PATH = databaseFolder.appendingPathComponent("User.sqlite").relativePath

        do {
            /// Connecting to the SQLite file
            if Self.database == nil {
                Self.database = try SQLite.connect(path: DB_PATH)
            }
            
            if let database = Self.database {
                /// Creating the table
                try database.createTable(createStatement: createStatement)
                print("User table created successfully")
                return result
            } else {
                print("No database connected -- unexpected error")
                result = false
                return result
            }
        } catch SQLiteError.tableCreationFailure(message: _) {
            print("Table already exists")
            return result
        } catch SQLiteError.connectionError(message: let error) {
            print("SQL connection failed")
            print(error)
            result = false
            return result
        } catch SQLiteError.stepError(message: let error) {
            print("User table creation failed")
            print(error)
            result = false
            return result
        } catch SQLiteError.bindError(message: let error) {
            print("Bind error while creating database")
            print(error)
            result = false
            return result
        } catch SQLiteError.preparationError(message: let error) {
            print("Preparation error while creating database")
            print(error)
            result = false
            return result
        } catch let error {
            print("Unexpected error occured while initiating database")
            print(error)
            result = false
            return result
        }
    }
    
    func insert(username: String, password: String, imageURL: URL?) -> Bool {
        var result = true
        do {
            if let database = Self.database {
                let insertSql = try database.prepareStatement(sql: insertStatement)
                defer {
                    sqlite3_finalize(insertSql)
                }
                
                
                let usernameString = username as NSString
                guard let encodedPassword = password.data(using: .utf8)?.base64EncodedString() else {
                    print("Error in encoding to base64")
                    return false
                }
                let passwordString = encodedPassword as NSString
                
                let imageFolder = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask)[0].appendingPathComponent(Constant.DB_FOLDER).appendingPathComponent(Constant.IMAGE_FOLDER)
                do {
                    try FileManager.default.createDirectory(at: imageFolder, withIntermediateDirectories: true, attributes: nil)
                } catch let error {
                    print("Failed to create directory while inserting user image to database")
                    print(error)
                    return false
                }
                var localImageURL: URL? = nil
                if let imageURL = imageURL {
                    let destinationURL = imageFolder.appendingPathComponent(imageURL.lastPathComponent)
                    do {
                        try FileManager.default.copyItem(at: imageURL, to: destinationURL)
                    } catch let error {
                        print("Some error occured while copying image to local folder.")
                        print(error)
                    }
                    localImageURL = destinationURL
                }
                let imageString = (localImageURL?.relativePath) as NSString?
                
                guard sqlite3_bind_text(insertSql, 1, usernameString.utf8String, -1, nil) == SQLITE_OK &&
                        sqlite3_bind_text(insertSql, 2, passwordString.utf8String, -1, nil) == SQLITE_OK &&
                        sqlite3_bind_text(insertSql, 3, imageString?.utf8String, -1, nil) == SQLITE_OK
                else {
                    throw SQLiteError.bindError(message: database.errorMessage)
                }
                /// Executing the query
                guard sqlite3_step(insertSql) == SQLITE_DONE else {
                    throw SQLiteError.stepError(message: database.errorMessage)
                }
                
                print("Successfully inserted row.")
                return result
            } else {
                print("No database connection")
                result = false
                return result
            }
        } catch SQLiteError.stepError(message: let error) {
            print("Cannot create entry in User table")
            print(error)
            return false
        } catch SQLiteError.bindError(message: let error) {
            print("Cannot create entry in User table")
            print(error)
            return result
        } catch SQLiteError.preparationError(message: let error) {
            print("Cannot create entry in User table")
            print(error)
            return false
        } catch let error {
            print("Cannot create entry in User table")
            print(error)
            return false
        }
    }
    
    func getPassword(forUsername username: String) -> String? {
        do {
            if let database = Self.database {
                /// Preparing the query
                let selectSql = try database.prepareStatement(sql: selectStatement)
                defer {
                    sqlite3_finalize(selectSql)
                }
                
                let usernameString = username as NSString
                guard sqlite3_bind_text(selectSql, 1, usernameString.utf8String, -1, nil) == SQLITE_OK else {
                    print("Failure in binding id in SQL statement while retrieving from User table")
                    print(database.errorMessage)
                    return nil
                }
                /// Executing the query
                guard sqlite3_step(selectSql) == SQLITE_ROW else {
                    print("Failure in retrieving from User table, no rows found")
                    print(database.errorMessage)
                    return nil
                }
                guard let result = sqlite3_column_text(selectSql, 0) else {
                    print("Failure in retrieving from User table, no data found")
                    print(database.errorMessage)
                    return nil
                }
                /// Converting result of cString to the object after decoding from base64
                let encodedPassword = String(cString: result)
                print("Successfully retrieved row.")
                guard let data = Data(base64Encoded: encodedPassword) else {
                    print("Error in decoding from base64")
                    return nil
                }
                guard let password = String(data: data, encoding: .utf8) else {
                    print("Error in decoding from base64")
                    return nil
                }
                return password
            } else {
                print("No database connection")
                return nil
            }
        } catch let error {
            print("Error while retrieving row from User table")
            print(error)
            return nil
        }
    }
    
    func getAllUsers() -> [User] {
        let selectAllStatement: String =
        """
        SELECT * FROM User;
        """
        var userList: [User] = []
        do {
            if let database = Self.database {
                /// Preparing the query
                let selectSql = try database.prepareStatement(sql: selectAllStatement)
                defer {
                    sqlite3_finalize(selectSql)
                }
                /// Executing the query
                while sqlite3_step(selectSql) == SQLITE_ROW {
                    /// Retrieving the data of the first row from the result
                    guard let username = sqlite3_column_text(selectSql, 0) else {
                        continue
                    }
                    guard let encodedCStringPassword = sqlite3_column_text(selectSql, 1) else {
                        continue
                    }
                    let encodedPassword = String(cString: encodedCStringPassword)
                    guard let data = Data(base64Encoded: encodedPassword) else {
                        continue
                    }
                    guard let password = String(data: data, encoding: .utf8) else {
                        continue
                    }
                    let imageURL = URL(string: String(cString: sqlite3_column_text(selectSql, 2)))
                    let user = User(username: String(cString: username), password: password, imageURL: imageURL)
                    userList.append(user)
                }
                return userList
            } else {
                print("No database connection")
                return []
            }
        } catch let error {
            print("Error while retrieving row from Reminder table")
            print(error)
            return []
        }
    }
    
    func update(password: String, for username: String) -> Bool {
        do {
            if let database = Self.database {
                let updateSql = try database.prepareStatement(sql: updateStatement)
                defer {
                    sqlite3_finalize(updateSql)
                }
                
                let usernameString = username as NSString
                guard let encodedPassword = password.data(using: .utf8)?.base64EncodedString() else {
                    print("Error in encoding to base64")
                    return false
                }
                let passwordString = encodedPassword as NSString
                
                guard sqlite3_bind_text(updateSql, 1, usernameString.utf8String, -1, nil) == SQLITE_OK &&
                        sqlite3_bind_text(updateSql, 2, passwordString.utf8String, -1, nil) == SQLITE_OK
                else {
                    throw SQLiteError.bindError(message: database.errorMessage)
                }
                
                guard sqlite3_step(updateSql) == SQLITE_DONE else {
                    throw SQLiteError.stepError(message: database.errorMessage)
                }
                print("Successfully updated row.")
                return true
            } else {
                print("No database connection")
                return false
            }
        } catch SQLiteError.stepError(message: let error) {
            print("Failed to update a row in User table")
            print(error)
            return false
        } catch let error {
            print("Failed to update a row in User table")
            print(error)
            return false
        }
    }
    
    func delete(username: String) -> Bool {
        do {
            if let database = Self.database {
                let deleteSql = try database.prepareStatement(sql: deleteStatement)
                defer {
                    sqlite3_finalize(deleteSql)
                }
                
                let usernameString = username as NSString
                
                guard sqlite3_bind_text(deleteSql, 1, usernameString.utf8String, -1, nil) == SQLITE_OK
                else {
                    throw SQLiteError.bindError(message: database.errorMessage)
                }
                
                guard sqlite3_step(deleteSql) == SQLITE_DONE else {
                    throw SQLiteError.stepError(message: database.errorMessage)
                }
                print("Successfully deleted row.")
                return true
            } else {
                print("No database connection")
                return false
            }
        } catch SQLiteError.stepError(message: let error) {
            print("Failed to delete a row in User table")
            print(error)
            return false
        } catch let error {
            print("Failed to delete a row in User table")
            print(error)
            return false
        }
    }
}
