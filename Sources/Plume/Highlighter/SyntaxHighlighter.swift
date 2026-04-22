//
//  SyntaxHighlighter.swift
//  Plume
//
//  Created by Gabriel Araújo on 22/04/26.
//

import AppKit

class SyntaxHighlighter {
    func highlight(code: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: code)
        let range = NSRange(location: 0, length: code.utf16.count)
        
        attributedString.addAttribute(.foregroundColor, value: NSColor.textColor, range: range)
        attributedString.addAttribute(.font, value: NSFont.monospacedSystemFont(ofSize: 13, weight: .regular), range: range)
        
        let patterns: [String: NSColor] = [
            "\\\\[a-zA-Z]+": .systemPurple,
            "\\%.*": .systemGreen,
            "\\$.*?\\$": .systemGray,
            "\\[.*?\\]": .systemOrange
        ]
        
        for (pattern, color) in patterns {
            if let regex = try? NSRegularExpression(pattern: pattern) {
                let matches = regex.matches(in: code, range: range)
                for match in matches {
                    attributedString.addAttribute(.foregroundColor, value: color, range: match.range)
                }
            }
        }
        
        return attributedString
    }
}
