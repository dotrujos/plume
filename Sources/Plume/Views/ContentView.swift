//
//  ContentView.swift
//  Plume
//
//  Created by Gabriel Araújo on 15/04/26.
//

import SwiftUI
import CodeEditor

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationSplitView {
            List {
                Section(header: Text("Projeto")) {
                    OutlineGroup(viewModel.files, id: \.self, children: \.contents) { file in
                        Label(
                            file.name,
                            systemImage: file.isDirectory ? "folder.fill" : "doc"
                        )
                        .onAppear {
                            if file.isDirectory && (file.contents?.isEmpty ?? false) {
                                viewModel.loadSubFiles(for: file)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Projeto atual")
        } content: {
            VStack(spacing: 0) {
                CodeEditorViewRepresentable(text: $viewModel.source)
                    .frame(minWidth: 400, minHeight: 300)
                
                HStack {
                    Text("Linhas: \(viewModel.lineCount)")
                    Spacer()
                    Text("UTF-8")
                }
                .font(.caption)
                .padding(8)
                .background(Color(NSColor.windowBackgroundColor))
            }
        } detail: {
            Group {
                if let url = viewModel.samplePDF {
                    PreviewPDFViewRepresentable(url: url)
                } else {
                    ContentUnavailableView(
                        "Nenhum PDF",
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
        .onAppear {
            viewModel.initialLoad()
        }
    }
}
