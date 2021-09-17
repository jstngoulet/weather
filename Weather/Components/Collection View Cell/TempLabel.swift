//
//  TempLabel.swift
//  Weather
//
//  Created by Justin Goulet on 9/16/21.
//

import UIKit

/**
 Creates a stack view with a large text and small text
 */
class TempLabel: UIView {
    
    private lazy var largeTitle: UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        lbl.textAlignment = .center
        lbl.textColor = .gray
        return lbl
    }()
    
    private lazy var smallTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.preferredFont(forTextStyle: .headline)
        lbl.textAlignment = .center
        lbl.textColor = .darkText
        return lbl
    }()
    
    init(withTitle title: String, detail: String) {
        super.init(frame: .zero)
        build()
        set(title: title, detail: detail)
    }
    
    required init?(coder: NSCoder) {
        fatalError("TODO: Not yet complete")
    }

}

//  MARK: - Build the view
private extension TempLabel {
    
    func build() {
        addViews()
        setContraints()
    }
    
    func addViews() {
        addChildren([
            largeTitle
            , smallTitle
        ])
    }
    
    func setContraints() {
        largeTitle.autoPinEdgesToSuperviewEdges(
            with: Constants.offset.insetValue,
            excludingEdge: .bottom
        )
        smallTitle.autoPinEdgesToSuperviewEdges(
            with: Constants.offset.insetValue,
            excludingEdge: .top
        )
        smallTitle.autoPinEdge(.top, to: .bottom, of: largeTitle,
                               withOffset: Constants.offset)
    }
    
}

//  MARK: - Accessors and Mutators
extension TempLabel {
    
    /// Sets the title and detail of the view
    /// - Parameters:
    ///   - title:      The title, large, in the top label
    ///   - detail:     The detail, small, in the bottom label
    func set(title: String, detail: String) {
        set(title: title)
        set(detail: detail)
    }
    
    /// Sets the title in the view
    /// - Parameter title: The title text to set
    func set(title: String) {
        self.largeTitle.text = title
    }
    
    /// Sets the detail description
    /// - Parameter detail: The detail description to set on the small text
    func set(detail: String) {
        self.smallTitle.text = detail
    }
    
}
