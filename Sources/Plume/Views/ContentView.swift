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
    
    var body: some View {
        NavigationSplitView {
            List {
                Label("main.tex", systemImage: "doc.text")
            }
            .navigationTitle("Projeto atual")
        } detail: {
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
