import 'package:flutter/material.dart';
import 'core/data/database/db_helper.dart';
import 'core/utils/debug_config.dart';
import 'core/services/theme_manager.dart';
import 'presentation/views/debug/debug_views.dart';
import 'presentation/views/awakers/planner_page.dart';
import 'presentation/views/planner/material_requirements_page.dart';
import 'presentation/views/settings/settings_page.dart';
import 'package:flutter/foundation.dart';

void main() async {
  // Ensuring binding is initialized before using plugins
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initializing the database
  await DBHelper().database;
  
  // Initializing the theme
  await ThemeManager().initialize();
  
  // Checking if we're in debug/development mode
  if (kDebugMode) {
    print("Iniciando aplicativo em modo de depuração");
  }
  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    ThemeManager().addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Morimens Planner',
      theme: ThemeManager().currentTheme,
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _secretTapCount = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeManager().isDarkMode;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                _secretTapCount++;
                if (_secretTapCount >= 10) {
                  setState(() {
                    DebugConfig().isDebugMode = true;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Debug mode activated!')),
                  );
                }
              },
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            // Theme toggle button
            ListTile(
              leading: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              title: Text(isDark ? 'Light Mode' : 'Dark Mode'),
              onTap: () async {
                await ThemeManager().toggleTheme();
                setState(() {});
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Awakers'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PlannerPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Materials'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MaterialRequirementsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
            if (DebugConfig().isDebugMode) ...DebugViews.debugMenuItems(context),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Welcome to the Planner App!',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
