import RealityKit

// Ensure you register this component in your app’s delegate using:
// PlayAnimComponent.registerComponent()
public struct PlayAnimComponent: Component, Codable {
    // Name used to uniquely identify the component type. It can differ from the struct name.
    public static var componentName: String { "Untitled.PlayAnimComponent" }

    // This is an example of adding a variable to the component.
    var count: Int = 0

    public init() {
    }
}
