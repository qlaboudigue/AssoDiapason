import 'package:diapason/notifier/activity_notifier.dart';
import 'package:diapason/notifier/claim_notifier.dart';
import 'package:diapason/notifier/event_notifier.dart';
import 'package:diapason/notifier/item_notifier.dart';
import 'package:diapason/notifier/story_notifier.dart';
import 'package:diapason/notifier/user_notifier.dart';
import 'package:diapason/notifier/member_notifier.dart';
import 'package:diapason/notifier/visitor_notifier.dart';
import 'package:diapason/views/pages/about_page.dart';
import 'package:diapason/views/pages/black_list_page.dart';
import 'package:diapason/views/pages/convention_page.dart';
import 'package:diapason/views/pages/data_policy_page.dart';
import 'package:diapason/controllers/upload_claim_controller.dart';
import 'package:diapason/views/pages/items_page.dart';
import 'package:diapason/views/pages/profile_page.dart';
import 'package:diapason/views/pages/stories_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/my_material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:diapason/util/push_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'controllers/login_controller.dart';
import 'controllers/main_app_controller.dart';
import 'views/pages/contact_page.dart';
import 'views/pages/directory_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  // After update, have to call Firebase.initializeApp(); before using any Firebase Product
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Run MyApp as usual
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserNotifier()),
        ChangeNotifierProvider(create: (context) => MemberNotifier(),),
        ChangeNotifierProvider(create: (context) => VisitorNotifier(),),
        ChangeNotifierProvider(create: (context) => EventNotifier(),),
        ChangeNotifierProvider(create: (context) => StoryNotifier(),),
        ChangeNotifierProvider(create: (context) => ItemNotifier(),),
        ChangeNotifierProvider(create: (context) => ActivityNotifier()),
        ChangeNotifierProvider(create: (context) => ClaimNotifier()),
      ],
      child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {

  // static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  Widget build(BuildContext context) {

    // PushNotifications setUp
    // final pushNotificationService = PushNotificationService(_firebaseMessaging);
    // pushNotificationService.initialise();

    // Rest of the build method
    return MaterialApp(
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('fr'), // French, no country code
        // ... other locales the app supports
      ],
      // Remove debug banner during development
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
      ),
      initialRoute: LoginController.route,
      routes: {
        // Root screen
        // LoginController.route: (context) => LoginController(),
        LoginController.route: (context) => Consumer<UserNotifier>(
            builder: (context, userNotifier, child) {
              return (userNotifier.currentUser != null) ? MainAppController() : LoginController();
            }
        ),
    // Level 0 screen
        MainAppController.route: (context) => MainAppController(),
        // Level 1 screens
        ProfilePage.route: (context) => ProfilePage(),
        StoriesPage.route: (context) => StoriesPage(),
        // Level 2 screens
        DirectoryPage.route: (context) => DirectoryPage(),
        AboutPage.route: (context) => AboutPage(),
        ItemsPage.route: (context) => ItemsPage(),
        ContactPage.route: (context) => ContactPage(),
        ConventionPage.route: (context) => ConventionPage(),
        PrivacyPolicyPage.route: (context) => PrivacyPolicyPage(),
        UploadClaimController.route: (context) => UploadClaimController(),
        // Level 3 screens
        BlackListPage.route: (context) => BlackListPage(),
      },
    );
  }
}
