//
//  ContectView.swift
//  Bullseye
//
//  Created by Bahadır Büber on 1.05.2020.
//  Copyright © 2020 Bahadır Büber. All rights reserved.
//

import SwiftUI

struct ContentView: View {

  @State var alertIsVisible = false
  @State var sliderValue = 50.0
  @State var target = Int.random(in: 1...100)
  @State var score = 0
  @State var round = 1
    let midnightBlue = Color(red: 17.0/255.0, green: 68.0/255.0, blue: 128.0/255.0)
  struct LabelStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.white)
        .modifier(Shadow())
        .font(Font.custom("Arial Rounded MT Bold", size: 18))
    }
  }
    struct ValueStyle: ViewModifier {
      func body(content: Content) -> some View {
        return content
        .foregroundColor(Color.yellow)
        .modifier(Shadow())
        .font(Font.custom("Arial Rounded MT Bold", size: 24))
      }
    }
    struct Shadow: ViewModifier {
      func body(content: Content) -> some View {
        return content
          .shadow(color: Color.black, radius: 5, x: 2, y: 2)
      }
    }
    struct ButtonLargeTextStyle: ViewModifier {
      func body(content: Content) -> some View {
        return content
          .foregroundColor(Color.black)
          .font(Font.custom("Arial Rounded MT Bold", size: 18))
      }
    }
    struct ButtonSmallTextStyle: ViewModifier {
      func body(content: Content) -> some View {
        return content
          .foregroundColor(Color.black)
          .font(Font.custom("Arial Rounded MT Bold", size: 10))
      }
    }
  var body: some View {
    VStack {
      Spacer()
      
      // Target row
      HStack {
        Text("Hedef tahtasını olabildiğince yakına koyun : ").modifier(LabelStyle())
        Text("\(target)").modifier(ValueStyle())
      }
      Spacer()
      
      // Slider row
      HStack {
        Text("1").modifier(LabelStyle())
        Slider(value: $sliderValue, in: 1...100).accentColor(Color.green)
        Text("100").modifier(LabelStyle())
      }
      Spacer()
      
      // Button row
      Button(action: {
        self.alertIsVisible = true
        
      }) {
        Text("Dene!").modifier(ButtonLargeTextStyle())
      }
      .alert(isPresented: $alertIsVisible) { () -> Alert in
        //let roundedValue = Int(sliderValue.rounded())
        return Alert(title: Text(alertTitle()), message: Text(
          "Kaydırıcının değeri \(sliderValueRounded()).\n" +
          "Bu turda \(pointsForCurrentRound()) puan elde ettiniz."
        ), dismissButton: .default(Text("Mükemmel!")) {
          self.score = self.score + self.pointsForCurrentRound()
          self.target = Int.random(in: 1...100)
          self.round = self.round + 1
        })
      }
      .background(Image("Button")).modifier(Shadow())
      Spacer()
      
      // Score row
      HStack {
        Button(action: {
          self.startNewGame()
        }) {
            HStack{
                Image("StartOverIcon")
                Text("Baştan Başla").modifier(ButtonSmallTextStyle())
            }}
        .background(Image("Button")).modifier(Shadow())
        Spacer()
        Text("Score:").modifier(LabelStyle())
        Text("\(score)").modifier(ValueStyle())
        Spacer()
        Text("Round:").modifier(LabelStyle())
        Text("\(round)").modifier(ValueStyle())
        Spacer()
        NavigationLink(destination: AboutView()){
            HStack{
                Image("InfoIcon")
                Text("Hakkında").modifier(ButtonSmallTextStyle())
            }
        }
        .background(Image("Button")).modifier(Shadow())
      }
      .padding(.bottom, 20)
    }
    .background(Image("Background"), alignment: .center)
    .accentColor(midnightBlue)
  .navigationBarTitle("Hedef Tahtası")
  }
  
  func sliderValueRounded() -> Int {
    Int(sliderValue.rounded())
  }
  
  func amountOff() -> Int {
    abs(target - sliderValueRounded())
  }
  
  func pointsForCurrentRound() -> Int {
    let maximumScore = 100
    let difference = amountOff()
    let bonus: Int
    if difference == 0 {
      bonus = 100
    } else if difference == 1 {
      bonus = 50
    } else {
      bonus = 0
    }
    return maximumScore - difference + bonus
  }
  
  func alertTitle() -> String {
    let difference = amountOff()
    let title: String
    if difference == 0 {
      title = "Mükemmel!"
    } else if difference < 5 {
      title = "Neredeyse oluyordu!"
    } else if difference <= 10 {
      title = "Mehh."
    } else {
      title = "Knk naptın ya?"
    }
    return title
  }
  
  func startNewGame() {
    score = 0
    round = 1
    sliderValue = 50.0
    target = Int.random(in: 1...100)
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().previewLayout(.fixed(width: 896, height: 414))
  }
}