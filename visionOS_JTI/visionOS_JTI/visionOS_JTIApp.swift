//
//  visionOS_JTIApp.swift
//  visionOS_JTI
//
//  Created by Freequency on 10/6/23.
//

import SwiftUI
import RealityKitContent
import ARKit
import RealityKit


@main
struct visionOS_JTIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    private let immersiveSpaceIdentifier = "Immersive"
    
    @State private var viewModel = ViewModel()

    init() {
        RealityKitContent.PointOfInterestComponent.registerComponent()
        PointOfInterestRuntimeComponent.registerComponent()
        RealityKitContent.BillboardComponent.registerComponent()
        ControlledOpacityComponent.registerComponent()
        RealityKitContent.RegionSpecificComponent.registerComponent()
        
        RealityKitContent.BillboardSystem.registerSystem()

    }
    
    var body: some SwiftUI.Scene {

        WindowGroup {
            ContentView(spaceId: immersiveSpaceIdentifier,
                        viewModel: viewModel)
        }
        .windowStyle(.plain)

        ImmersiveSpace(id: immersiveSpaceIdentifier) {
            JTiView(viewModel: viewModel)
        }

    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: UIApplication) -> Bool {
        return true
    }
}
