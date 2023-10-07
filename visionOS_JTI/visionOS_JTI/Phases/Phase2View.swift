/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that holds the app's immersive content.
*/

import SwiftUI
import RealityKit
import RealityKitContent

struct Phase2View: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var showPhaseThree = false
    @State private var animationIsComplete = false
    
    var viewModel: ViewModel
    
    static let markersQuery = EntityQuery(where: .has(PointOfInterestComponent.self))
    static let runtimeQuery = EntityQuery(where: .has(PointOfInterestRuntimeComponent.self))
    
    @State private var subscriptions = [EventSubscription]()
    @State private var attachmentsProvider = AttachmentsProvider()
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        RealityView { content, _ in
            do {
                // Use a variable to specify the scene name ("PhaseTwo" or "PhaseThree")
                let sceneName = showPhaseThree ? "PhaseThree" : "PhaseTwo"
                let entity = try await Entity(named: sceneName, in: RealityKitContent.RealityKitContentBundle)
                viewModel.rootEntity = entity
                content.add(entity)
                
                
                // Offset the scene so it doesn't appear underneath the user or conflict with the main window.
                entity.position = SIMD3<Float>(0, 0.3, -0.5)
                playAnimation(rootEntity: entity)
                
                // When the animation is complete, set showPhaseTwo to true to trigger the transition
                if animationIsComplete && !showPhaseThree {
                    showPhaseThree = true
                }
                
                
                
            } catch {
                print("Error in RealityView's make: \(error)")
            }
            // Transition to PhaseTwo once showPhaseTwo is true
            if showPhaseThree {
                Phase3View() // Instantiate Phase2View and use it within the SwiftUI view hierarchy
            }
            
        } update: { content, attachments in
            viewModel.rootEntity?.scene?.performQuery(Self.runtimeQuery).forEach { entity in
                
                guard let component = entity.components[PointOfInterestRuntimeComponent.self] else { return }
                
                // Get the entity from the collection of attachments keyed by tag.
                guard let attachmentEntity = attachments.entity(for: component.attachmentTag) else { return }
                
                attachmentEntity.setPosition([0, 0.2, 0], relativeTo: entity)
                attachmentEntity.components.set(BillboardComponent())
            }
            
            
        } attachments: {
            ForEach(attachmentsProvider.sortedTagViewPairs, id: \.tag) { pair in
                Attachment(id: pair.tag) {
                    pair.view
                }
            }
        }
    }
    
    
    private func playAnimation(rootEntity entity: Entity) {
        guard let ARModel = entity.findEntity(named: "ARModel") else { return }
        for ARModel in ARModel.children {
            guard let animationResource = ARModel.availableAnimations.first else { continue }
            
            // Check if the animation has already been played
            if !animationIsComplete {
                // Play the animation once
                let controller = ARModel.playAnimation(animationResource.repeat(count: 1))
                
                
            }
        }
    }



}

#Preview {
    JTiView(viewModel: ViewModel())
        .previewLayout(.sizeThatFits)
}
