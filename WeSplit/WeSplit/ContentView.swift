//
//  ContentView.swift
//  WeSplit
//
//  Created by Justin Williams on 04/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var montoTotal = 0.0
    @State private var numeroPersonas = 2
    @FocusState private var selecionaMonto: Bool
    @State private var porcentajeProp = 20
    let listaPorcentaje = [0,10,15,20,25]
    let formatoPlata = FloatingPointFormatStyle<Double>.Currency.currency(code:Locale.current.currency?.identifier ?? "USD")
    // este let nos permite eliminar la tediosa funcion par la currency
    
    var totalPorPersona: Double {
        let cantPers = Double(numeroPersonas + 2) // Se usa Double() para poder convertir los valores a float para poder ejecutar las operaciones con el monto total
        let propinaDada = Double(porcentajeProp)

        let valorProp = montoTotal / 100 * propinaDada // valor calculado
        let totalFinal = montoTotal + valorProp
        let plataPorpersona = totalFinal / cantPers

        return plataPorpersona
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Dinero a pagar", value: $montoTotal, format: formatoPlata)
                        .keyboardType(.decimalPad)
                        .focused($selecionaMonto)
                        .foregroundColor(porcentajeProp == 0 ? .red : .black)
                    
                    Picker("Cantidad de personas", selection: $numeroPersonas){
                        ForEach(2..<100){
                            Text("\($0) personas")
                        }
                    }.pickerStyle(.navigationLink)
                }header: {
                    Text("Monto a pagar")
                }
                
                Section{
                    Picker("Propina", selection: $porcentajeProp){
                        ForEach (listaPorcentaje, id: \.self){
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }header: {
                    Text("Cuanta propina daremos")
                }
                
                Section {
                    Text(totalPorPersona, format: formatoPlata)
                        .keyboardType(.decimalPad)
                }header: {
                    Text("Dinero a pagar por persona")
                }
            }.navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer() // Esto nos acomoda el boton de "Done" hacia la derecha siguiendo los estandares de Apple
                    Button("Done") {
                        selecionaMonto = false
                    }
                }
            }
        }
    }
}

// Esta parte del codigo es el que me permite ver la simulacion a la derecha del codigo y este no forma parte del codigo final a la hora de subirlo a la play store

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
