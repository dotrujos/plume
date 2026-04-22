//
//  ContentView.swift
//  Plume
//
//  Created by Gabriel Araújo on 15/04/26.
//

import SwiftUI
import CodeEditor

struct ContentView: View {
    @State private var source: String = """
        \\documentclass{article}
        \\begin{titlepage}
            \\title{Meu Documento LaTeX}
            \\author{Gabriel}
        \\end{titlepage}
        \\begin{document}
            \\makefile
            Olá, este é o editor Plume!
        \\end{document}
        """
    
    let samplePDF = URL(string: "https://www.thecampusqdl.com/uploads/files/pdf_sample_2.pdf")
    var body: some View {
        NavigationSplitView {
            List {
                Label("main.tex", systemImage: "doc.text")
            }
            .navigationTitle("Projeto atual")
        } content: {
            VStack(spacing: 0) {
                CodeEditorViewRepresentable(text: $source)
                    .frame(minWidth: 400, minHeight: 300)
                
                HStack {
                    Text("Linhas: \(source.components(separatedBy: .newlines).count)")
                    Spacer()
                    Text("UTF-8")
                }
                .font(.caption)
                .padding(8)
                .background(Color(NSColor.windowBackgroundColor))
            }
        } detail: {
            Group {
                if let url = samplePDF {
                    PreviewPDFViewRepresentable(url: url)
                } else {
                    ContentUnavailableView(
                        "Nenhum pDF",
                        systemImage: "pdfselection",
                        description: Text("Compile o código para gerar o documento.")
                    )
                }
            }
            .navigationTitle("Preview")
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button {
                    print("Compile Action")
                } label: {
                    Label("Compilar", systemImage: "play.fill")
                }
                
            }
        }
    }
}
