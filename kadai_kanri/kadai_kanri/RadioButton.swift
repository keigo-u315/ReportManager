//
//  RadioButton.swift
//  kadai_kanri
//
//  Created by K.U on 2022/05/20.
//

import SwiftUI

struct RadioButtonModel: Identifiable, Hashable {
    let id = UUID()
    let index: Int
    let text: String
    
    init(index: Int, text: String) {
        self.index = index
        self.text = text
    }
}

struct RadioButton: View {
    
    enum Axis {
        case horizontal
        case vertical
    }
    
    @Binding var selectedIndex: Int
    private let axis: Axis
    private var models: [RadioButtonModel] = []
    
    init(selectedIndex: Binding<Int>, axis: Axis, texts: [String]) {
        self._selectedIndex = selectedIndex
        self.axis = axis
        
        var index = 0
        texts.forEach { text in
            let model = RadioButtonModel(index: index, text: text)
            models.append(model)
            index += 1
        }
    }
    
    var body: some View {
        if axis == .vertical {
            return configureVertical()
        } else {
            return configureHorizontal()
        }
    }
    
    private func configureHorizontal() -> AnyView {
        return AnyView(
            HStack {
                configure()
            }
        )
    }
    
    private func configureVertical() -> AnyView {
        return AnyView(
            VStack(alignment: .leading) {
                configure()
            }
        )
    }
    
    private func configure() -> AnyView {
        return AnyView(
            ForEach(models) { model in
                HStack {
                    if model.index == self.selectedIndex {
                        ZStack {
                            Image(systemName: "checkmark.square.fill")
                        }
                    } else {
                        Image(systemName: "square")
                    }
                    Text(model.text)
                }
                .onTapGesture {
                    self._selectedIndex.wrappedValue = model.index
                }
            }
        )
    }
}
