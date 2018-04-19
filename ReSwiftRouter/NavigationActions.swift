//
//  NavigationAction.swift
//  Meet
//
//  Created by Benjamin Encz on 11/27/15.
//  Copyright © 2015 DigiTales. All rights reserved.
//

import ReSwift

/// Exports the type map needed for using ReSwiftRouter with a Recording Store
public let typeMap: [String: StandardActionConvertible.Type] =
    ["RE_SWIFT_ROUTER_SET_ROUTE": SetRouteAction.self]

public struct SetRouteAction: StandardActionConvertible {

    let route: Route
    let animated: Bool
    public static let type = "RE_SWIFT_ROUTER_SET_ROUTE"

    public init (_ route: Route, animated: Bool = true) {
        self.route = route
        self.animated = animated
    }

    public init(_ action: StandardAction) {
        self.route = action.payload!["route"] as! Route
        self.animated = action.payload!["animated"] as! Bool
    }

    public func toStandardAction() -> StandardAction {
        return StandardAction(
            type: SetRouteAction.type,
            payload: ["route": route as AnyObject, "animated": animated as AnyObject],
            isTypedAction: true
        )
    }
    
}

public struct SetRouteSpecificData: Action {
    let route: Route
    let data: Any

    public init(route: Route, data: Any) {
        self.route = route
        self.data = data
    }
}

public struct ReplaceRouteAction: StandardActionConvertible {

    let route: Route
    let routables: [Routable]
    public static let type = "RE_SWIFT_ROUTER_REPLACE_ROUTE"

    public init (_ route: Route, routables: [Routable]) {
        if route.count + 1 != routables.count {
            fatalError("invalid route/routable")
        }
        self.route = route
        self.routables = routables
    }

    public init(_ action: StandardAction) {
        self.route = action.payload!["route"] as! Route
        self.routables = action.payload!["routable"] as! [Routable]
    }

    public func toStandardAction() -> StandardAction {
        return StandardAction(
            type: ReplaceRouteAction.type,
            payload: ["route": route as AnyObject, "routables": routables as AnyObject],
            isTypedAction: true
        )
    }
}

public struct ClearNextRoutableAction: Action {
}
