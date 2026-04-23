//
//  FileController.swift
//  Plume
//
//  Created by Gabriel Araújo on 23/04/26.
//

import Foundation

class FileController: ObservableObject {
    func getContentsOfDirectory(url: URL) -> [File] {
        let fileManager = FileManager.default
        do {
            let items = try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: [.isDirectoryKey])
            
            return items.compactMap { itemUrl in
                let resourceValues = try? itemUrl.resourceValues(forKeys: [.isDirectoryKey])
                let isDirectory = resourceValues?.isDirectory ?? false
                let filename = itemUrl.lastPathComponent
                
                if filename.hasPrefix(".") { return nil }
                
                return File(
                    url: itemUrl,
                    isDirectory: isDirectory,
                    name: filename,
                    contents: isDirectory ? [] : nil
                )
            }.sorted { $0.isDirectory && !$1.isDirectory }
        } catch {
            return []
        }
    }
}
