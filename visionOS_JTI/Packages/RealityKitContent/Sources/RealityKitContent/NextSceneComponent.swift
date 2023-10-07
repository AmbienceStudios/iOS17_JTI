import RealityKit
import SwiftUI

public enum Hotspot: String, Codable {
    case PhaseOne
    case PhaseTwo
    case PhaseThree
    case PhaseFour
    case PhaseFive
    case Restart
}

public enum USDZModels: String, Codable {
    case Phase0
    case Phase1
    case Phase2
    case Phase3
    case Phase4
    case Phase5
    case Phase5Static
    case Phase6
}





public struct NextSceneComponent: Component, Codable {
    public static var componentName: String { "RealityKitContent.NextSceneComponent" }

    public var NextScene: Hotspot = .PhaseOne
    public var AnimUSDZModel: USDZModels = .Phase0

    
    public init() {
    }
}



