import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct TaPagoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            WelcomeScreen() // Tela inicial
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure() // Configura o Firebase

        // Configurações adicionais do Firebase Auth
        Auth.auth().useAppLanguage()
        Auth.auth().settings?.isAppVerificationDisabledForTesting = false

        // Configura o grupo de acesso do usuário (se necessário)
        do {
            try Auth.auth().useUserAccessGroup(nil)
        } catch {
            print("Erro ao configurar o grupo de acesso do usuário: \(error.localizedDescription)")
        }

        // Verifica se o usuário já está logado
        if Auth.auth().currentUser != nil && UserDefaults.standard.bool(forKey: "manterConectado") {
            print("Usuário já está logado.")
        }

        return true
    }
}
