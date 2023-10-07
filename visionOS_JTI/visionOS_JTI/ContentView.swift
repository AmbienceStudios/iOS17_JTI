/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The app's main SwiftUI view.
*/

import SwiftUI
import RealityKit

struct ContentView: View {
    let spaceId: String
    var viewModel: ViewModel

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    var areControlsShowing: Bool {
        viewModel.rootEntity != nil && viewModel.showImmersiveContent
    }
    
    var body: some View {
        @Bindable var viewModel = viewModel

        VStack {
            Spacer()
            Grid(alignment: .leading, verticalSpacing: 30) {
                Button(action: {
                             viewModel.showImmersiveContent.toggle()
                               
                              }) {
                                  Image(systemName: "arrow.right")
                                      .font(.system(size: 52)) // Increase the font size if needed
                                      .padding(20)
                                      .frame(width: 300)
                                      .background(Color.black)
                                      .foregroundColor(.white)
                                      .cornerRadius(10)
                              }
                              
                .onChange(of: viewModel.showImmersiveContent) {
                    Task {
                        if viewModel.showImmersiveContent {

                            await openImmersiveSpace(id: spaceId)
                        } else {
                            await dismissImmersiveSpace()
                        }
                    }
                }
            }
            .animation(.default, value: areControlsShowing)
//            .frame(width: 500)
//            .padding(30)
//            .glassBackgroundEffect()
        }
    }

    private func update() {

    }
}

#Preview("Hidden") {
    ContentView(
        spaceId: "Immersive",
        viewModel: ViewModel(rootEntity: Entity(), showImmersiveContent: false)
    )
}

#Preview("Showing") {
    ContentView(
        spaceId: "Immersive",
        viewModel: ViewModel(rootEntity: Entity(), showImmersiveContent: true)
    )
}
