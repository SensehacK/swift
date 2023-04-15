//
//  EmptyListView.swift
//  SwiftUIBetterTodo
//
//  Created by Kautilya Save on 4/15/23.
//

import SwiftUI

struct EmptyListView: View {
    
    @State var animate: Bool = false
    let secondaryAccentColor: Color = Color("SecondaryAccentColor")
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 10) {
                
                Text("Please add TODO item!")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("You should be putting down those task in the list")
                    .font(.headline)
                    .fontWeight(.medium)
                    .padding(.horizontal)
                
                
                NavigationLink {
                    AddView()
                } label: {
                    Text("Add Something 🤓")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.horizontal)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(animate ? secondaryAccentColor : Color.accentColor)
                        .cornerRadius(15)
                }
                .padding(animate ? 30 : 50)
                .scaleEffect(animate ? 1.1 : 1.0)
                .shadow(color: animate ? secondaryAccentColor.opacity(0.8) :
                            Color.accentColor.opacity(0.7),
                        radius: animate ? 30 : 10,
                        x: 0,
                        y: animate ? 50: 30)

            }
            .frame(maxWidth: 400)
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear(perform: addAnimation)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
       
    }
        
        
    
    func addAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            
            guard !animate else { return }
            
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
        
    }
}

struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EmptyListView()
                .navigationTitle("Hello")
        }
    }
}
