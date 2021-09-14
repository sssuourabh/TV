//
//  TVShowView.swift
//  TVShowManager
//
//  Created by Sourabh Singh on 13/09/21.
//

import Foundation
import UIKit
import Carbon
import Cartography

class TVShowView: UIView {

    let showNameLabel = UILabel()
    let releaseYearLabel = UILabel()
    let seasonsLabel = UILabel()
    //let deleteButton = UIButton
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        let margin: CGFloat = 8.0
        showNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        showNameLabel.numberOfLines = 0
        for label in [showNameLabel, releaseYearLabel, seasonsLabel] {
            label.textColor = .gray
            label.setContentCompressionResistancePriority(.required, for: .vertical)
        }
        
        let containerView = UIView()
        containerView.addDropShadow()
        containerView.addSubview(showNameLabel)
        containerView.addSubview(releaseYearLabel)
        containerView.addSubview(seasonsLabel)
        containerView.layer.cornerRadius = 5
        containerView.backgroundColor = .white
        
        addSubview(containerView)
        Cartography.constrain(containerView, showNameLabel, releaseYearLabel, seasonsLabel) {
            $0.edges == $0.superview!.edges.inseted(by: margin)
            
            $1.top == $1.superview!.top + margin*2
            $1.leading == $1.superview!.leading + margin
            $1.trailing == $1.superview!.trailing - margin
            
            $2.top == $1.bottom + margin
            $2.leading == $1.leading
            $2.trailing == $1.trailing
            
            $3.top == $2.bottom + margin
            $3.leading == $2.leading
            $3.trailing == $2.trailing
            $3.bottom == $3.superview!.bottom - margin*2
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct TVShowViewItemComponent: IdentifiableComponent {
    
    let tvShow: TVShow
    
    init(tvShow: TVShow) {
        self.tvShow = tvShow
    }
    
    var id: String {
        "TVShowViewItem.TVShow"
    }

    public func renderContent() -> TVShowView {
        TVShowView()
    }

    public func render(in content: TVShowView) {
        content.showNameLabel.text = tvShow.title
        content.releaseYearLabel.text = "\(tvShow.years)"
        content.seasonsLabel.text = "\(tvShow.seasons)"
    }

    func referenceSize(in bounds: CGRect) -> CGSize? {
        return nil
    }
    
    func shouldContentUpdate(with next: TVShowViewItemComponent) -> Bool {
        return true
    }
}
