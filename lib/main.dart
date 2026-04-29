import 'package:flutter/material.dart';
import 'package:temamu/core/theme/app_theme.dart';
// Import your screens here - adjust paths based on your folder structure
import 'features/auth/screens/splash_screen.dart';
import 'features/auth/screens/sign_up_screen.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/home/screens/home_screen.dart';
import 'core/services/otp_screen.dart';
import 'features/pool/screens/create_pool_screen.dart';
import 'features/pool/screens/select_split_method_screen.dart';
import 'features/pool/screens/equal_split_config_screen.dart';
import 'features/pool/screens/itemized_split_config_screen.dart';
import 'features/pool/screens/percentage_split_config_screen.dart';
import 'features/pool/screens/wallet_split_config_screen.dart';
import 'package:temamu/features/pool/screens/pool_lobby_screen.dart';
import 'package:temamu/features/pool/screens/attach_receipt_screen.dart';
import 'package:temamu/features/pool/screens/pool_recap_screen.dart';
import 'package:temamu/features/pool/screens/manual_payment_screen.dart';
import 'package:temamu/features/pool/screens/congratulations_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const TemamuApp());
}

class TemamuApp extends StatelessWidget {
  const TemamuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temamu',
      debugShowCheckedModeBanner: false,
      theme: TemamuTheme.theme,
      // 1. The app starts at the Splash Screen
      initialRoute: '/splash',

      // 2. This is the "Map" the error was looking for
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/sign-up': (context) => const SignUpScreen(),
        '/otp': (context) => const OtpScreen(),
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),

        // Pool creation flow
        '/create-pool': (context) => const CreatePoolScreen(),
        '/select-split-method': (context) => const SelectSplitMethodScreen(),
        '/equal-split-config': (context) => const EqualSplitConfigScreen(),
        '/itemized-split-config': (context) =>
            const ItemizedSplitConfigScreen(),
        '/percentage-split-config': (context) =>
            const PercentageSplitConfigScreen(),
        '/wallet-split-config': (context) => const WalletSplitConfigScreen(),
        '/pool-lobby': (context) => const PoolLobbyScreen(),
        '/attach-receipt': (context) => const AttachReceiptScreen(),
        '/pool-recap': (context) => const PoolRecapScreen(),
        '/manual-payment': (context) => const ManualPaymentScreen(),
        '/congratulations': (context) => const CongratulationsScreen(),
      },
    );
  }
}
