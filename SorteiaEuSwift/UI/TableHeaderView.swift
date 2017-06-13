//
//  TableHeaderView.swift
//  SorteiaEuSwift
//
//  Created by Yasmin Benatti on 13/06/17.
//  Copyright © 2017 Yasmin Benatti. All rights reserved.
//

import UIKit

class TableHeaderView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    private func setUpView() {
        let view = viewFromNibForClass()
        view.frame = bounds
        
        addSubview(view)
    }
    
    private func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView

        return view
    }

}
