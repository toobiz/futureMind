//
//  DebugHelper.swift
//  Swinject
//
//  Created by Jakub Vaňo on 26/09/16.
//  Copyright © 2016 Swinject Contributors. All rights reserved.
//

internal protocol DebugHelper {
    func resolutionFailed<Service>(serviceType
        serviceType: Service.Type,
        key: ServiceKey,
        availableRegistrations: [ServiceKey: ServiceEntryType]
    )
}

internal final class LoggingDebugHelper: DebugHelper {

    func resolutionFailed<Service>(serviceType
        serviceType: Service.Type,
        key: ServiceKey,
        availableRegistrations: [ServiceKey: ServiceEntryType]
    ) {
        var output = [
            "Swinject: Resolution failed. Expected registration:",
            "\t{ \(description(serviceType: serviceType, serviceKey: key)) }",
            "Available registrations:",
        ]
        output += availableRegistrations
            .filter { $0.1 is ServiceEntry<Service> }
            .map { "\t{ " + $0.1.describeWithKey($0.0) + " }" }

        Container.log(output.joinWithSeparator("\n"))
    }
}

internal func description<Service>(serviceType
    serviceType: Service.Type,
    serviceKey: ServiceKey,
    objectScope: ObjectScope? = nil,
    initCompleted: FunctionType? = nil
) -> String {
    // The protocol order in "protocol<>" is non-deterministic.
    let nameDescription = serviceKey.name.map { ", Name: \"\($0)\"" } ?? ""
    let initCompletedDescription = initCompleted.map { _ in ", InitCompleted: Specified" } ?? ""
    let objectScopeDescription = objectScope.map { ", ObjectScope: \($0)" } ?? ""
    return "Service: \(serviceType)"
        + nameDescription
        + ", Factory: \(serviceKey.factoryType)"
        + objectScopeDescription
        + initCompletedDescription
}
