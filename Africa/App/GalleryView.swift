//
//  GalleryView.swift
//  Africa
//
//  Created by Harry Lopez on 7/04/22.
//

import SwiftUI

struct GalleryView: View {
    //MARK: PROPERTIES
    
    let animals : [Animal] = Bundle.main.decode("animals.json")
    let haptics = UIImpactFeedbackGenerator(style: .medium)
    @State var selectedAnimal : String  = "lion"
    
    //let gridLayout : [GridItem] = [
    //    GridItem(.flexible()),
    //    GridItem(.flexible()),
    //    GridItem(.flexible())
    //]
    
    // Efficient Grid Definition
    //let gridLayout: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    
    // Dynamic Layout
    
    @State private var gridLayout: [GridItem] = [GridItem(.flexible())]
    @State private var gridColum: Double = 3.0
    
    
    func gridSwitch(){
        gridLayout = Array(repeating: .init(.flexible()), count: Int(gridColum))
    }
    
    //MARK: BODY
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            //MARK: IMAGE
            
            Image(selectedAnimal)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .overlay(Circle().stroke(.white, lineWidth: 8))
            
            // MARK: SLIDER
            Slider(value: $gridColum, in: 2...4, step: 1)
                .padding()
                .onChange(of: gridColum, perform: { value in
                    gridSwitch()
                })

            VStack(alignment:.center, spacing: 30) {
                
                // MARK: GRID
                LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10){
                    ForEach(animals) { item in
                        Image(item.image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
                            .onTapGesture {
                                selectedAnimal = item.image
                                haptics.impactOccurred()
                            }
                        
                    }// LOOM
                }// GRID
                .animation(.easeIn)
                .onAppear(perform: {
                    gridSwitch()
                })
            }// VSTACK
            .padding(.horizontal, 10)
            .padding(.vertical, 50)
        }// SCROLL
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .background(MotionAnimationView())
    }
}
//MARK: PREVIEW
struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
