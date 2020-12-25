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

/// A cell representing a directory
class FolderCell: UITableViewCell {

	@IBOutlet weak var icon: UIImageView!
	@IBOutlet weak var name: UILabel!

	func setContent(_ file: Plugin_Filesystem_Msg_FileListlet) {
		// Directory name
		name.text = file.name
	}
}
