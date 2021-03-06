//
//  FlashFormItemGroup.swift
//  FlashForm
//
//  Created by ios on 2018/10/16.
//  Copyright © 2018 ios. All rights reserved.
//

import Foundation

open class FlashFormItemGroup {
    
    var headerView: UIView?
    var footerView: UIView?
    
    var titleLabel: UILabel?
    
    var footerLabel: UILabel?
    
    var items: [FlashFormItem]!
    public var headerHeight: CGFloat?
    public var key: String?
    
    public var title: String? {
        didSet {
            if title != nil {
                if titleLabel == nil {
                    createTitleLabel()
                }
            } else {
                titleLabel?.text = nil
            }
        }
    }
    
    public var footer: String?{
        didSet {
            if footer != nil {
                if footerLabel == nil {
                    createFooterLabel()
                }
            } else {
                footerLabel?.text = nil
            }
        }
    }
    
    
    public init(_ items:[FlashFormItem], _ key: String? = nil) {
        self.items = items
    }
    
    public func dic() -> [String: FlashFormValue] {
        var dic: [String: FlashFormValue] = [:]
        items.forEach { (item) in
            if let item = item as? FlashShadowProtocol{
                item.valueDic.forEach{dic.updateValue($1, forKey: $0)}
            }
        }
        return dic
    }
    
    //
    func createTitleLabel() {
        let label = UILabel()
        label.text = title
        label.translatesAutoresizingMaskIntoConstraints = false
        if headerView == nil { createHeaderView() }
        headerView?.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: headerView!.leftAnchor, constant: 10),
            label.centerYAnchor.constraint(equalTo: headerView!.centerYAnchor),
            label.topAnchor.constraint(equalTo: headerView!.topAnchor, constant: 5),
            label.rightAnchor.constraint(lessThanOrEqualTo: headerView!.rightAnchor, constant: -10)
        ])
        titleLabel = label
    }
    
    func createHeaderView() {
        headerView = UIView()
        headerView?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func createFooterLabel() {
        let label = UILabel()
        label.text = footer
        label.translatesAutoresizingMaskIntoConstraints = false
        if footerView == nil { createFooterView() }
        footerView?.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: footerView!.leftAnchor, constant: 10),
            label.centerYAnchor.constraint(equalTo: footerView!.centerYAnchor),
            label.topAnchor.constraint(equalTo: footerView!.topAnchor, constant: 3),
            label.rightAnchor.constraint(lessThanOrEqualTo: footerView!.rightAnchor, constant: -10)
            ])
        footerLabel = label
    }
    
    func createFooterView() {
        footerView = UIView()
        footerView?.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension FlashFormItemGroup: Hashable {
    
    public var hashValue: Int {
        return "\(key ?? "") \(items.hashValue)".hashValue
    }
    
    public static func == (lhs: FlashFormItemGroup, rhs: FlashFormItemGroup) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    
}
