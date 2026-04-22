//
//  CodeEditor.swift
//  Plume
//
//  Created by Gabriel Araújo on 22/04/26.
//

import AppKit
import SwiftUI

struct CodeEditorViewRepresentable: NSViewRepresentable {
    @Binding var text: String
    
    private let highlighter = SyntaxHighlighter()
    
    func makeNSView(context: Context) -> NSScrollView {
        let scrollView = NSScrollView()
        scrollView.wantsLayer = true
        scrollView.hasVerticalScroller = true
        scrollView.drawsBackground = true
        
        let textView = NSTextView(frame: .zero)
        textView.delegate = context.coordinator
        textView.isRichText = false
        textView.allowsUndo = true
        textView.autoresizingMask = [.width]
        textView.isVerticallyResizable = true
        textView.backgroundColor = .textBackgroundColor
        textView.insertionPointColor = .textColor
        textView.drawsBackground = true
        textView.isAutomaticQuoteSubstitutionEnabled = false
        textView.isAutomaticDashSubstitutionEnabled = false
        
        let lineNumberView = LineNumberRulerView(scrollView: scrollView, orientation: .verticalRuler)
        lineNumberView.clientView = textView
        lineNumberView.ruleThickness = 40
        
        scrollView.verticalRulerView = lineNumberView
        scrollView.hasVerticalRuler = true
        scrollView.rulersVisible = true
        scrollView.documentView = textView
        return scrollView
    }
    
    func updateNSView(_ nsView: NSScrollView, context: Context) {
        guard let textView = nsView.documentView as? NSTextView else { return }
        
        if textView.string != text {
            textView.textStorage?.setAttributedString(highlighter.highlight(code: text))
        }
        
        nsView.verticalRulerView?.needsDisplay = true
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, NSTextViewDelegate {
        var parent: CodeEditorViewRepresentable
        
        init(_ parent: CodeEditorViewRepresentable) {
            self.parent = parent
        }
        
        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else { return }
            
            self.parent.text = textView.string
            
            let selectedRange = textView.selectedRange()
            textView.textStorage?.setAttributedString(parent.highlighter.highlight(code: textView.string))
            textView.setSelectedRange(selectedRange)
        }
    }
}
