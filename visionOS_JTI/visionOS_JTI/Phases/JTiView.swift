/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that holds the app's immersive content.
*/

import SwiftUI
import RealityKit
import RealityKitContent

struct JTiView: View {
    @Environment(\.dismiss) private var dismiss

    var viewModel: ViewModel

    static let markersQuery = EntityQuery(where: .has(PointOfInterestComponent.self))
    static let runtimeQuery = EntityQuery(where: .has(PointOfInterestRuntimeComponent.self))
    
    @State private var subscriptions = [EventSubscription]()
    @State private var attachmentsProvider = AttachmentsProvider()

    var body: some View {
        @Bindable var viewModel = viewModel
        
        RealityView { content, _ in
            do {
                let entity = try await Entity(named: "PhaseOne", in: RealityKitContent.RealityKitContentBundle)
                viewModel.rootEntity = entity
//                myDataModel.add(entity)
                content.add(entity)
                entity.position = SIMD3<Float>(0, 0.3, -0.5)
                playAnimation(rootEntity: entity)

            } catch {
                print("Error in RealityView's make: \(error)")
            }
            
        } update: { content, attachments in
            viewModel.rootEntity?.scene?.performQuery(Self.runtimeQuery).forEach { entity in

         
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
            let controller = ARModel.playAnimation(animationResource.repeat(count: 1))
            controller.pause()

        }
    }
}

#Preview {
    JTiView(viewModel: ViewModel())
        .previewLayout(.sizeThatFits)
}
