import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Users/loxxych/XcodeProjects/Sber final project/Sber final project/Sber final project/ContentView.swift", line: 1)
//
//  ContentView.swift
//  Sber final project
//
//  Created by Aleksandra Bednova on 13.06.2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: __designTimeString("#7210_0", fallback: "globe"))
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(__designTimeString("#7210_1", fallback: "Hello, world!"))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
