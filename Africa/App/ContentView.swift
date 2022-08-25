//
//  ContentView.swift
//  Africa
//
//  Created by Harry Lopez on 7/04/22.
//

import SwiftUI

struct ContentView: View {
    //MARK: PROPERTIES
    let animals: [Animal] = Bundle.main.decode("animals.json")
    let haptics = UIImpactFeedbackGenerator(style: .medium)
    
    @State private var isGridViewActive = false
    
    
    @State private var gridLayout :[GridItem] = [GridItem(.flexible())]
    @State private var gridColumn : Int = 1
    @State private var toolBarIcon = "square.grid.2x2"
    
    
    //: MARK: -  FUNCTIONS
    func gridSwitch()
    {
        gridLayout = Array(repeating: .init(.flexible()), count: gridLayout.count % 3 + 1)
        gridColumn = gridLayout.count
        
        switch gridColumn {
        case 1:
            toolBarIcon = "square.grid.2x2"
        case 2:
            toolBarIcon = "square.grid.3x2"
        case 3:
            toolBarIcon = "rectangle.grid.1x2"
        default:
            toolBarIcon = "square.grid.2x2"
            
        }
    }
    
    
    var body: some View {
        //MARK: BODY
        NavigationView {
            
            Group{
                if !isGridViewActive {
                    List{
                        CoverImageView()
                            .frame(height: 300)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                        ForEach(animals){ animal in
                            NavigationLink(destination: AnimalDetailView(animal: animal))
                            {
                                AnimalListItemView(animal: animal)
                            }//NAVIGATION
                        }// LOOP
                    CreditsView()
                            .modifier(CenterModifier())
                    }
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                            ForEach(animals) { animal in
                                NavigationLink(destination: AnimalDetailView(animal: animal))
                                {
                                    AnimalGridItemView(animal: animal)
                                }// LINK
                            }// LOOP
                        }// GRID
                        .padding(10)
                        .animation(.easeIn)
                    }// SCROLL
                }//: LIST
            }//GROUP
            .navigationBarTitle("Africa", displayMode: .large)
//            .frame(maxWidth: .infinity)
//            .listStyle(GroupedListStyle())
            .toolbar{
                ToolbarItem(placement:.navigationBarTrailing){
                    HStack(spacing:16){
                        //LIST
                        Button(action: {
                            print("List View Activate")
                            isGridViewActive = false
                            haptics.impactOccurred()
                        }){
                            Image(systemName: "square.fill.text.grid.1x2")
                                .font(.title2)
                                .foregroundColor(isGridViewActive ? .primary:.accentColor)
                        }
                        
                        //GRID
                        
                        Button(action: {
                            print("Grid View Activate")
                            isGridViewActive = true
                            haptics.impactOccurred()
                            gridSwitch()
                        }){
                            Image(systemName: toolBarIcon)
                                .font(.title2)
                                .foregroundColor(!isGridViewActive ? .primary:.accentColor)
                        }
                        
                    }//HSTACK
                }// BUTTONS
            }// TOOLBAR
        }// NAVIGATIONVIEW
        
    }
}
//MARK: PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
