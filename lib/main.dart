import 'package:flutter/material.dart';

// Import your screens using the project structure we created
import 'features/auth/screens/splash_screen.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/sign_up_screen.dart';
import 'features/auth/screens/home_screen.dart'; 
import 'features/auth/screens/create_pool_screen.dart';
import 'features/auth/screens/add_participants_screen.dart';
import 'features/auth/screens/itemized_split_config_screen.dart';
import 'features/auth/screens/pool_lobby_screen.dart';
import 'features/auth/screens/percentage_split_config_screen.dart';
import 'features/auth/screens/wallet_split_config_screen.dart';
import 'features/auth/screens/equal_split_config_screen.dart';
import 'features/auth/screens/item_claim_screen.dart';
import 'features/auth/screens/merchant_payment_screen.dart';
import 'features/auth/screens/payment_selection_screen.dart';
void main() {
  // We removed 'async' and 'Firebase' for now to keep things moving!
  runApp(const TemamuApp());
}

class TemamuApp extends StatelessWidget {
  const TemamuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temamu',
      debugShowCheckedModeBanner: false, // Hides the debug banner
      
      // 1. GLOBAL FINTECH THEME
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF2563EB), // Deep Blue
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          secondary: const Color(0xFF06B6D4), // Soft Cyan
          surface: Colors.white,
        ),
        // Setting a clean, modern font style
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
          bodyLarge: TextStyle(color: Color(0xFF334155)),
        ),
      ),

      // 2. NAVIGATION ROUTES
      // This tells the app exactly what screen to show for each name
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
        '/create-pool': (context) => const CreatePoolScreen(),

        // THE SPLIT PATHS
         '/itemized-config': (context) => const ItemizedSplitConfigScreen(),
         '/add-participants': (context) => const AddParticipantsScreen(),
          '/pool-lobby': (context) => const PoolLobbyScreen(),
          '/percentage-config': (context) => const PercentageSplitConfigScreen(),
          '/wallet-config': (context) => const WalletSplitConfigScreen(),
          '/equal-split': (context) => const EqualSplitConfigScreen(),
          '/item-claim': (context) => const ItemClaimScreen(),
          '/payment-selection': (context) => const PaymentSelectionScreen(),
          '/merchant-pay': (context) => const MerchantPaymentScreen(),
      },
    );
  }
}