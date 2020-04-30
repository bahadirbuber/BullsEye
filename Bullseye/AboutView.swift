//
//  AboutView.swift
//  Bullseye
//
//  Created by Bahadır Büber on 1.05.2020.
//  Copyright © 2020 Bahadır Büber. All rights reserved.
//

import SwiftUI

struct AboutView: View {

    let beige = Color(red: 255.0/255.0, green: 214.0/255.0, blue: 179.0/255.0)
    
    struct AboutHeadingStyle: ViewModifier {
       func body(content: Content) -> some View {
         return content
           .foregroundColor(Color.black)
           .font(Font.custom("Arial Rounded MT Bold", size: 30))
            .padding(.top,20)
            .padding(.top,20)
       }
     }
    struct AboutBodyStyle: ViewModifier {
      func body(content: Content) -> some View {
        return content
            .foregroundColor(Color.black)
          .font(Font.custom("Arial Rounded MT Bold", size: 16))
           .padding(.leading,60)
           .padding(.trailing,60)
            .padding(.bottom,20)
      }
    }
    
    
    var body: some View {
    Group{
        VStack{
            Text("🎯Hedef Tahtası🎯").modifier(AboutHeadingStyle())
            Text("Bu Hedef Tahtası, kaydırıcıyı kullanarak puan kazanabiliceginiz bir oyundur.").modifier(AboutBodyStyle())
        Text("Amacınız, kaydırıcıyı hedef degere olabildigince yakın yerlestirmektir.").modifier(AboutBodyStyle())
        Text("Ne kadar yakın o kadar iyi...").modifier(AboutBodyStyle())
        Text("Iyi Eglenceler...").modifier(AboutBodyStyle())
        }
    .navigationBarTitle("Hakkında")
    .background(beige)
    }
    .background(Image("Background"))
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
}
