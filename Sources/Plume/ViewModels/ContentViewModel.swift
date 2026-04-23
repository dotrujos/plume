//
//  ContentViewModel.swift
//  Plume
//
//  Created by Gabriel Araújo on 23/04/26.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var files: [File] = []
    @Published var source: String = """
        \\documentclass{article}
        \\begin{titlepage}
            \\title{Meu Documento LaTeX}
            \\author{Gabriel}
        \\end{titlepage}
        \\begin{document}
            \\maketitle
            Olá, este é o editor Plume!
        \\end{document}
        """
    
    private let fileController = FileController()
    let samplePDF = URL(string: "https://www.thecampusqdl.com/uploads/files/pdf_sample_2.pdf")
    
    func initialLoad() {
        // Ajuste o caminho conforme necessário para seus testes
        let path = URL(string: "/Users/gabrielaraujo/Downloads")!
        self.files = fileController.getContentsOfDirectory(url: path)
    }
    
    func loadSubFiles(for parentFile: File) {
        let subFiles = fileController.getContentsOfDirectory(url: parentFile.url)
        
        // Se for nível raiz
        if let index = files.firstIndex(where: { $0.id == parentFile.id }) {
            files[index].contents = subFiles
        } else {
            // Busca recursiva no estado para pastas profundas
            updateNestedFile(in: &files, targetId: parentFile.id, with: subFiles)
        }
    }

    private func updateNestedFile(in list: inout [File], targetId: URL, with newContent: [File]) {
        for i in list.indices {
            if list[i].url == targetId {
                list[i].contents = newContent
                return
            }
            if list[i].contents != nil {
                updateNestedFile(in: &list[i].contents!, targetId: targetId, with: newContent)
            }
        }
    }
    
    var lineCount: Int {
        source.components(separatedBy: .newlines).count
    }
}
