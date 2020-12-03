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

class STAttribute<T> {

    /// The attribute OID
    let oid: Oid<T>

	/// The attribute's current value
	var value: T?

	/// The timestamp associated with the attribute's current value
	var timestamp: Date?
	
    init(_ oid: Oid<T>) {
		self.oid = oid
	}
}
