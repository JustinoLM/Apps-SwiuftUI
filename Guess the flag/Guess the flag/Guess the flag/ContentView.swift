//
//  ContentView.swift
//  Guess the flag
//
//  Created by Justin Williams on 04/15/23.
//

import SwiftUI

struct titulosAzules: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title.bold())
            .foregroundColor(.blue)
    }
}
extension View {
    func titulosAzul() -> some View {
        modifier(titulosAzules())
    }
}

// .tituloAzul()

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var scoreTitle = ""
    @State private var paiscorrecto = ""
    @State private var showingScore = false
    @State private var endGame = false
    @State private var score = 0
    @State private var cantPreguntas = 0
    @State private var porcAciertos = 0.0
    
    struct Banderas: View {
        var image: String
        var body: some View {
            Image(image)
                .renderingMode(.original)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(Color.black))
                .shadow(color: .black, radius: 2)
        }
    }
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack (spacing: 15){
                    VStack {
                        Text ("Toca la bandera de ")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Banderas(image: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
                
                Text("Preguntas: \(cantPreguntas)")
                    .foregroundColor(.white)
                    .font(.title.bold())
            }.padding()
        }.alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert(scoreTitle, isPresented: $endGame){
            Button("Reset", action: askQuestion)
        } message: {
            Text("Tu porcentaje de aciertos fue de \(porcAciertos, specifier: "%.0f")%")
        }
    }
    
    func flagTapped(_ number: Int) {
        cantPreguntas += 1
        if number == correctAnswer {
            scoreTitle = "Correct you got 1 point"
            score += 1
        } else {
            scoreTitle = "Wrong That's flag of \(countries[number])"
        }

        showingScore = true
    }
    
    func askQuestion() {
        if cantPreguntas == 8 {
            porcAciertos = (Double(score)/8)*100
            scoreTitle = "Tu puntuacion fue de \(score)/8"
            score = 0
            cantPreguntas = 0
            endGame = true
            
        }else{
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
