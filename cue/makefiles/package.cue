package makefiles

import "tool/file"

#Directory: {
	#Path:     _
	#Contents: _
	#Files: {
		for k, v in #Contents
		let _isFile = bool & ( *v.#IsAFile | false)
		let _dir = #Path
		let _filename = k
		let _filepath = {
			if _dir == "." {_filename}
			if _dir != "." {"\(_dir)/\(_filename)"}
		} {
			if _isFile {
				"\(_filepath)": v & {
					#Path:     _dir
					#Filename: _filename
				}
				if _dir != "." {
					"\(_dir)/": file.MkdirAll & {path: _dir}
				}
			}
			if !_isFile {
				"found-\(_filepath)": true
				{#Directory & {#Path: "\(_filepath)", #Contents: v}}.#Files
			}
		}
		...
	}
}

#File: {
	#IsAFile:  true
	#Path:     string
	#Filename: string
	#FilePath: "\(#Path)/\(#Filename)"
	...
}
