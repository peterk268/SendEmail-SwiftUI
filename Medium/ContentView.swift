//
//  ContentView.swift
//  Medium
//
//  Created by Peter Khouly on 25/10/2020.
//

import SwiftUI
import MessageUI


struct ContentView: View {
    @State var showSheet = false
    @State var showAlert = false
    var body: some View {
        VStack {
            Button(action: {
                if MFMailComposeViewController.canSendMail(){
                    self.showSheet = true
                }
                else {
                    self.showAlert = true
                }
            }) {
                Label("your@email.com", systemImage: "envelope")
            }
            .alert(isPresented: $showAlert){ () ->
                Alert in
                return Alert(title: Text("Device Can't Send Mail"))
            }
            
            .sheet(isPresented: $showSheet) {
                sendEmail()
            }
        }
    }
}

struct sendEmail: UIViewControllerRepresentable {
    let emailDelegate = EmailDelegate()
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
       
        let mail = MFMailComposeViewController()
        mail.delegate = emailDelegate
        mail.mailComposeDelegate = emailDelegate
        mail.setToRecipients(["your@email.com"])
        mail.setSubject("Mail Subject")
        
        return mail
        
    }
    
    func updateUIViewController(_ uiView: MFMailComposeViewController, context: Context) {
    }
}
class EmailDelegate: NSObject, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate{

    internal func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            if let _ = error{
                //Show alert error
                controller.dismiss(animated: true)
                return
            }
            controller.dismiss(animated: true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
