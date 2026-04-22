//
//  LineNumberRulerView.swift
//  Plume
//
//  Created by Gabriel Araújo on 22/04/26.
//

import AppKit

class LineNumberRulerView: NSRulerView {
    
    private let font = NSFont.monospacedSystemFont(ofSize: 11, weight: .regular)
    
    override func drawHashMarksAndLabels(in rect: NSRect) {
        guard let textView = clientView as? NSTextView,
              let layoutManager = textView.layoutManager,
              let textContainer = textView.textContainer else { return }
        
        let contentString = textView.string as NSString
        let visibleRect = textView.visibleRect
        
        let glyphRange = layoutManager.glyphRange(forBoundingRect: visibleRect, in: textContainer)
        let charRange = layoutManager.characterRange(forGlyphRange: glyphRange, actualGlyphRange: nil)
        
        var index = charRange.location
        while index < NSMaxRange(charRange) {
            let lineRange = contentString.lineRange(for: NSRange(location: index, length: 0))
            let lineRect = layoutManager.lineFragmentRect(forGlyphAt: layoutManager.glyphIndexForCharacter(at: index), effectiveRange: nil)
            
            let yPoint = lineRect.origin.y + textView.textContainerInset.height - visibleRect.origin.y
            
            let lineNumber = contentString.substring(to: index).components(separatedBy: "\n").count
            let numberString = "\(lineNumber)" as NSString
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: font,
                .foregroundColor: NSColor.secondaryLabelColor
            ]
            
            let stringSize = numberString.size(withAttributes: attrs)
            let xPoint = ruleThickness - stringSize.width - 8
            
            numberString.draw(at: NSPoint(x: xPoint, y: yPoint), withAttributes: attrs)
            
            index = NSMaxRange(lineRange)
        }
    }
}
