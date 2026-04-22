//
//  PreviewPDFViewRepresentable.swift
//  Plume
//
//  Created by Gabriel Araújo on 22/04/26.
//

import AppKit
import SwiftUI
import PDFKit

struct PreviewPDFViewRepresentable: NSViewRepresentable {
    let url: URL
    
    func makeNSView(context: Context) -> PDFView {
        let pdfView = PDFView()
        
        pdfView.document = PDFDocument(url: self.url)
        
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displaysPageBreaks = true
        
        return pdfView
    }
    
    func updateNSView(_ nsView: PDFView, context: Context) {
        if nsView.document?.documentURL != url {
            nsView.document = PDFDocument(url: url)
        }
    }
}
