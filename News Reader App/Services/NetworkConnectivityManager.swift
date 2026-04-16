//
//  NetworkConnectivityManager.swift
//  NetworkConnectivity
//
//  Created by Aryaman Sharda on 2/18/22.
//

import Foundation
import Network

extension Notification.Name {
    static let connectivityStatus = Notification.Name(rawValue: "connectivityStatusChanged")
}

extension NWInterface.InterfaceType: @retroactive CaseIterable {
    public static var allCases: [NWInterface.InterfaceType] = [
        .other,
        .wifi,
        .cellular,
        .loopback,
        .wiredEthernet
    ]
}

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue(label: "NetworkConnectivityMonitor")
    private let monitor: NWPathMonitor
    
    private(set) var isConnected = false
    private(set) var isExpensive = false
    private(set) var currentConnectionType: NWInterface.InterfaceType?
    
    private init() {
        monitor = NWPathMonitor()
    }
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.isConnected = (path.status == .satisfied)
                self.isExpensive = path.isExpensive
                
                self.currentConnectionType = NWInterface.InterfaceType.allCases.first {
                    path.usesInterfaceType($0)
                }
                
                NotificationCenter.default.post(name: .connectivityStatus, object: nil)
            }
        }
        
        monitor.start(queue: queue)
        let initialPath = monitor.currentPath
        isConnected = initialPath.status == .satisfied
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}

