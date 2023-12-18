import SwiftUI
import AppKit

struct ContentView: View {
    @State private var selectedTime = 15
    @State private var isTimerRunning = false
    @State private var clickCount = 0
    @State private var timeRemaining = 0
    @State private var timer: Timer?
    @State private var bestScore = 0
    @State private var scoredPoints = 0
    @State private var showSecondButton = false
    @State private var countdown = 0

    var body: some View {
        ScrollView{
            VStack {
                Spacer()
                
                Text("À vos trackpads, prêts, cliquez !")
                    .font(.title)
                    .padding(20)
                Text("Tentez de devenir la légende du clic.")
                    .font(.headline)
                                
                Spacer(minLength: 35)
                
                Text("Bienvenue dans ClickSpeed.")
                    .font(.headline)
                
                Text("Sélectionnez le temps de l'épreuve :")
                    .font(.headline)
                    .padding(.horizontal, 15)
                
                Spacer(minLength: 15)
                
                if isTimerRunning{
                    Picker("Épreuve :", selection: $selectedTime) {
                        Text("15 secs").tag(15)
                        Text("30 secs").tag(30)
                        Text("60 secs").tag(60)
                        Text("120 secs").tag(120)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 50)
                    .disabled(true)
                    
                } else {
                    
                    Picker("Épreuve :", selection: $selectedTime) {
                        Text("15 secs").tag(15)
                        Text("30 secs").tag(30)
                        Text("60 secs").tag(60)
                        Text("120 secs").tag(120)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 50)
                    .padding(.horizontal, 50)
                }
                
                Spacer(minLength: 30)
                
                HStack{
                    
                    Spacer()
                    
                    if isTimerRunning {
                        
                        Button(action: {
                            stopTimer()
                        }) {
                            Image(systemName: "stop.circle")
                                .padding()
                            
                            Text("Arrêter")
                                .font(.headline)
                                .padding()
                        }
                        .cornerRadius(50)
                        
                        Spacer()
                        
                    } else {
                        
                        Button(action: {
                            startTimer()
                        }) {
                            Image(systemName: "arrow.right.circle")
                                .padding()
                            
                            Text("Commencer")
                                .font(.headline)
                                .padding()
                        }
                        .cornerRadius(50)
                        
                        Spacer()
                    }
                }
                
                if isTimerRunning {
                    
                    Spacer(minLength: 15)
                    
                    if timeRemaining <= selectedTime {
                        Text("Temps restant : \(timeRemaining) secondes")
                            .font(.caption)
                        
                    } else {
                        Text("L'épreuve commence dans \(countdown).")
                            .font(.caption)
                    }
                    
                    Spacer()
                    
                    if isTimerRunning {
                        Text("\(clickCount) clic(s)")
                            .font(.headline)
                    }
                    
                } else {
                    
                    Spacer(minLength: 15)
                    
                    Text("Score : \(clickCount) clic(s)")
                        .font(.headline)
                    Text("Meilleur score pour cette session : \(bestScore) clic(s) par minute en moyenne.")
                        .font(.caption)
                    
                    Spacer()
                    
                    if isTimerRunning == false {
                        VStack{
                            if scoredPoints == 0 {
                                Text("0 ? S'agirait-il d'un malentendu ?")
                                    .font(.headline)
                                Text("Lancez vite une épreuve pour découvrir quelle est votre vitesse !")
                                    .font(.headline)
                            }
                            
                            if scoredPoints > 0 && scoredPoints <= 100 {
                                Text("Votre vitesse : ")
                                    .font(.caption)
                                + Text("Chenille 🐛")
                                    .italic()
                                    .font(.headline)
                            }
                            
                            if scoredPoints > 100 && scoredPoints <= 150 {
                                Text("Ta vitesse : ")
                                    .font(.caption)
                                + Text("Chaton endormi 🐈")
                                    .italic()
                                    .font(.headline)
                            }
                            
                            if scoredPoints > 150 && scoredPoints <= 200 {
                                Text("Ta vitesse : ")
                                    .font(.caption)
                                + Text("Papillon 🦋")
                                    .italic()
                                    .font(.headline)
                            }
                            
                            if scoredPoints > 200 && scoredPoints <= 250 {
                                Text("Ta vitesse : ")
                                    .font(.caption)
                                + Text("Lapin 🐇")
                                    .italic()
                                    .font(.headline)
                            }
                            
                            if scoredPoints > 250 && scoredPoints <= 350 {
                                Text("Ta vitesse : ")
                                    .font(.caption)
                                + Text("Renard 🦊")
                                    .italic()
                                    .font(.headline)
                            }
                            
                            if scoredPoints > 350 && scoredPoints <= 450 {
                                Text("Ta vitesse : ")
                                    .font(.caption)
                                + Text("Cheval au galop 🐎")
                                    .italic()
                                    .font(.headline)
                            }
                            
                            if scoredPoints > 450 && scoredPoints <= 500 {
                                Text("Ta vitesse : ")
                                    .font(.caption)
                                + Text("Lion 🦁")
                                    .italic()
                                    .font(.headline)
                            }
                            
                            if scoredPoints > 500 && scoredPoints <= 575 {
                                Text("Ta vitesse : ")
                                    .font(.caption)
                                + Text("Guépard 🐆")
                                    .italic()
                                    .font(.headline)
                            }
                            
                            if scoredPoints > 575 && scoredPoints <= 600 {
                                Text("Ta vitesse : ")
                                    .font(.caption)
                                + Text("TGV 🚄, impossible à battre !")
                                    .italic()
                                    .font(.headline)
                            }
                            
                            if scoredPoints > 600 {
                                Text("Impossible de calculer ta vitesse : n'aurais-tu pas utilisé un simulateur de clics ?")
                                    .font(.caption)
                            }
                        }
                        .frame(alignment: .center)
                        .padding(20)
                    }
                    
                    Spacer(minLength: 20)
                }
                
                if isTimerRunning {
                    if countdown > 0 {
                        Button(action: {
                            clickButton()
                        }) {
                            ZStack{
                                Image("BlankPad")
                                    .frame(width: 400, height: 300)
                                Text("\(countdown)")
                                    .font(.title)
                                    .frame(width: 400, height: 300)
                            }
                        }
                        .disabled(true)
                        
                    } else {
                        
                        Button(action: {
                            clickButton()
                        }) {
                            Image("BlankPad")
                                .frame(width: 400, height: 300)
                        }
                    }
                    
                } else {
                    Button(action: {
                        clickButton()
                    }) {
                        ZStack{
                            Image("BlankPad")
                                .frame(width: 400, height: 300)
                            Text("Lancez l'épreuve avec le bouton Commencer.")
                        }
                    }
                    .disabled(true)
                }
                
                Spacer()
            }
        }
        .frame(minWidth: 530, minHeight: 525)
        .padding()
    }
    
    func startTimer() {
        countdown = 3
        clickCount = 0
        timeRemaining = selectedTime + 3
        isTimerRunning = true
                
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
                
                if countdown > 0 {
                    countdown -= 1
                }
                
            } else {
                
                isTimerRunning = false
                timer?.invalidate()
                
                calculateScore()
                
                if scoredPoints > bestScore {
                    bestScore = scoredPoints
                }
            }
        }
    }
    
    func stopTimer() {
        isTimerRunning = false
        timer?.invalidate()
        
        calculateScore()
        
        if scoredPoints > bestScore {
            bestScore = scoredPoints
        }
    }
    
    func calculateScore() {
        if isTimerRunning == false {
            if selectedTime == 15 {
                scoredPoints = clickCount * 4
            }
            
            if selectedTime == 30 {
                scoredPoints = clickCount * 2
            }
            
            if selectedTime == 60 {
                scoredPoints = clickCount
            }
            
            if selectedTime == 120 {
                scoredPoints = clickCount / 2
            }
        }
    }
    
    func clickButton() {
        if isTimerRunning {
            clickCount += 1
        }
    }
}

#Preview {
    ContentView()
}
