package makefiles

import (
	"tool/file"
	"tool/http"
)

command: {
	let f = {#aDir & {#Path: ".", #Contents: files."."}}.#Files
	f, all_files: f
}

files: ".": {
	"test.1": #aFile & file.Create & {
		#Path:    _, #Filename: _, #FilePath: _
		filename: #FilePath
		contents: "some content\n"
	}
	foo: {
		"test.2": #aFile & {
			#Path:  _, #Filename: _, #FilePath: _
			create: file.Create & {
				$after:   command["\(#Path)/"]
				filename: #FilePath
				contents: "some other content\n"
			}
		}
	}
	bar: baz: {
		"a-uuid-from-a-website": #aFile & {
			#Path: _, #Filename: _, #FilePath: _
			fetch: http.Get & {
				url: "http://httpbin.org/uuid"
			}
			store: file.Create & {
				$after:   command["\(#Path)/"]
				filename: #FilePath
				contents: fetch.response.body
			}
		}
	}
}

///////////////////////////////////////////////////////
/// abstraced-away implementation detail below here ///
///////////////////////////////////////////////////////

#aDir: {
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
				{#aDir & {#Path: "\(_filepath)", #Contents: v}}.#Files
			}
		}
		...
	}
}

#aFile: {
	#IsAFile:  true
	#Path:     string
	#Filename: string
	#FilePath: "\(#Path)/\(#Filename)"
	...
}
