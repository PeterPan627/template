//
//  OpaqueView.swift
//  TemplateKit
//
//  Created by Matias Cudich on 9/8/16.
//  Copyright © 2016 Matias Cudich. All rights reserved.
//

import Foundation

class ViewNode: Node {
  weak var owner: Component?
  weak var parent: Node?

  var properties = [String: Any]()
  var children: [Node]? {
    didSet {
      updateParent()
    }
  }
  var element: Element?
  var cssNode: CSSNode?
  var builtView: View?

  init(view: UIView, properties: [String: Any], owner: Component? = nil) {
    self.builtView = view
    self.properties = properties
  }

  init(properties: [String: Any], children: [Node]? = nil, owner: Component? = nil) {
    self.properties = properties
    self.children = children
    self.owner = owner

    updateParent()
  }

  func build<V: View>() -> V {
    if let updateableView = builtView as? Updateable, builtView != nil {
      updateableView.update()
    }
    return builtView as! V
  }
}
