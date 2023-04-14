//
//  ContentView.swift
//  Hashable
//
//  Created by Kautilya Save on 4/13/23.
//

import SwiftUI

struct ModelWithHashing: Hashable {
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
 }

struct ModelWithoutHashing {
    let title: String
}

struct ModelWithIdentifiable : Identifiable {
    let id = UUID().uuidString
    let title: String
}


struct ContentView: View {
    
    @State var hashedData: [ModelWithHashing] = []
    @State var nonHashedData: [ModelWithoutHashing] = []
    @State var identifiableData: [ModelWithIdentifiable] = []
    
    
    var stringData: [String] = ["Ten, Eleven, Twelve, Thirteen, Fourteen, Fifteen"]
    
    var body: some View {
        VStack(spacing: 50) {
            
            // Hashed
            ForEach(hashedData, id: \.self) { datum in
                Text(datum.title)
                    .font(.headline)
            }
            
            /*// Non Hashed won't work
            ForEach(nonHashedData, id: \.self) { datum in
                Text(datum.title)
                    .font(.headline)
            }
            */
            
            // Strings work - since implicit hashing
            ForEach(stringData, id: \.self) { num in
                Text(num)
                    .font(.title3)
            }
            
            ForEach(identifiableData) { idData in
                Text(idData.title)
                    .font(.subheadline)
                
            }
            
        }
        .onAppear {
            hashedData = getHashedData()
            nonHashedData = getNonHashedData()
            identifiableData = getIdentifyData()
        }
    }
    
    
    func getHashedData() -> [ModelWithHashing] {
        [
            ModelWithHashing(title: "One"),
            ModelWithHashing(title: "Two"),
            ModelWithHashing(title: "Three"),
            ModelWithHashing(title: "Four"),
            ModelWithHashing(title: "Five"),
        ]
    }
    
    
    func getNonHashedData() -> [ModelWithoutHashing] {
        [
            ModelWithoutHashing(title: "One"),
            ModelWithoutHashing(title: "Two"),
            ModelWithoutHashing(title: "Three"),
            ModelWithoutHashing(title: "Four"),
            ModelWithoutHashing(title: "Five"),
        ]
    }
    
    func getIdentifyData() -> [ModelWithIdentifiable] {
        [
            ModelWithIdentifiable(title: "1"),
            ModelWithIdentifiable(title: "2"),
            ModelWithIdentifiable(title: "3"),
            ModelWithIdentifiable(title: "4"),
            ModelWithIdentifiable(title: "5"),
        ]
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
