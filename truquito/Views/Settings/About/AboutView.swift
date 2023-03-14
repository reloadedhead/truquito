//
//  AboutView.swift
//  truquito
//
//  Created by Tomás García Gobet on 12.03.23.
//

import SwiftUI

let ProjectUrl = "https://github.com/users/reloadedhead/projects/1"
let BugReportUrl = "https://github.com/reloadedhead/truquito/issues/new?assignees=&labels=&template=bug_report.md&title="
let FeatureUrl = "https://github.com/reloadedhead/truquito/issues/new?assignees=&labels=&template=feature_request.md&title="
let AppStoreUrl = "https://appstore.com/reloadedhead/truquito"

let TwitterUrl = "https://twitter.com/reloadedhead"

struct AboutView: View {
    var body: some View {
            List {
                Section(header: Text("Truquito"), footer: Text("Si te gustó Truquito, ¡dejá una reseña cariñosa en el AppStore!")) {
                    ExternalLinkView(url: ProjectUrl, symbolName: "checklist", label: "Roadmap público", color: .yellow)
                    ExternalLinkView(url: BugReportUrl, symbolName: "ladybug.fill", label: "Reportar un error", color: .red)
                    ExternalLinkView(url: FeatureUrl, symbolName: "wand.and.stars", label: "Solicitar una idea", color: .green)
                    ExternalLinkView(url: FeatureUrl, symbolName: "heart.fill", label: "Dejar una reseña", color: .red)
                }
                
                Section(header: Text("Developer"), footer: Text("¡Con amor, amargo y retruco!")) {
                    ExternalLinkView(url: TwitterUrl, symbolName: "bird.fill", label: "@reloadedhead", color: .blue)
                }
            }
            .navigationTitle("Acerca de")
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
