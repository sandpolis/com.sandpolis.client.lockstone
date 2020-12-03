//============================================================================//
//                                                                            //
//                Copyright © 2015 - 2020 Subterranean Security               //
//                                                                            //
//  This source file is subject to the terms of the Mozilla Public License    //
//  version 2. You may not use this file except in compliance with the MPL    //
//  as published by the Mozilla Foundation at:                                //
//                                                                            //
//    https://mozilla.org/MPL/2.0                                             //
//                                                                            //
//=========================================================S A N D P O L I S==//
import Foundation
import UIKit
import NIOSSL

extension UIViewController {

	public func connect(address: String, _ completion: @escaping (SandpolisConnection?) ->()) {
		let connection = SandpolisConnection(address, 8768)
		connection.connectionFuture.whenSuccess {
			completion(connection)
		}
		connection.connectionFuture.whenFailure { (error: Error) in
			if let _ = error as? NIOSSLError {
				DispatchQueue.main.async {
					let alert = UIAlertController(title: "Continue connection?", message: "The server's certificate is invalid. If you continue, the connection is not guaranteed to be secure. To make a secure connection, install a valid certificate on the server.", preferredStyle: .alert)
					alert.addAction(UIAlertAction(title: "Continue", style: .destructive) { _ in
						let connection = SandpolisConnection(address, 8768, certificateVerification: .none)
						connection.connectionFuture.whenSuccess {
							completion(connection)
						}
						connection.connectionFuture.whenFailure { (error: Error) in
							self.alertError("Connection failure", error.localizedDescription)
							completion(nil)
						}
					})
					alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
						completion(nil)
					})

					self.present(alert, animated: true)
				}
			} else {
				self.alertError("Login failure", error.localizedDescription)
				completion(nil)
			}
		}
	}

	public func login(address: String, username: String, password: String, _ completion: @escaping (SandpolisConnection?) ->()) {
		connect(address: address) { connection in
			if let connection = connection {
				let login = connection.login(username, password)
				login.whenSuccess { rs in
					do {
						if try Core_Foundation_Outcome.init(serializedData: rs.payload).result {
							self.alertError("Login failure", "Invalid credentials")
							completion(nil)
						}
					} catch {
						self.alertError("Login failure", "Invalid server response")
						completion(nil)
					}
				}
				login.whenFailure { (error: Error) in
					self.alertError("Login failure", error.localizedDescription)
					completion(nil)
				}
			} else {
				completion(nil)
			}
		}
	}

	private func alertError(_ title: String, _ message: String) {
		DispatchQueue.main.async {
			let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default))
			self.present(alert, animated: true, completion: nil)
		}
	}
}
