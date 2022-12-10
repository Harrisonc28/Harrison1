//
//  RectangleCard.swift
//  HarrisonApp
//
//  Created by Harrison Carroll on 07/12/2022.
//

import SwiftUI

struct RectangleCard: View {
    
    var color = Color.white
    
    var body: some View {
        
        Rectangle().foregroundColor(color).cornerRadius(10).shadow(radius: 5)
        
    }
}

struct RectangleCard_Previews: PreviewProvider {
    static var previews: some View {
        RectangleCard()
    }
}
