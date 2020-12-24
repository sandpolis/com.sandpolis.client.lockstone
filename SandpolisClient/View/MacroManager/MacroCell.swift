//============================================================================//
//                                                                            //
//                         Copyright © 2015 Sandpolis                         //
//                                                                            //
//  This source file is subject to the terms of the Mozilla Public License    //
//  version 2. You may not use this file except in compliance with the MPL    //
//  as published by the Mozilla Foundation.                                   //
//                                                                            //
//============================================================================//
import UIKit
import FirebaseFirestore

/// A table entry representing a macro
class MacroCell: UITableViewCell {

	@IBOutlet weak var name: UILabel!
	@IBOutlet weak var type: UILabel!
	@IBOutlet weak var size: UILabel!

	func setContent(_ macro: DocumentSnapshot) {
		// Macro name
		name.text = macro["name"] as? String

		// Macro size
		if let scriptLength = (macro["script"] as? String)?.count {
			size.text = FormatUtil.formatFileSize(Int64(scriptLength))
		} else {
			size.text = "0 bytes"
		}

		// Macro type
		type.text = macro["type"] as? String
	}
}
