import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'debug_config.dart';
import 'theme_manager.dart';
import 'views/debug/debug_views.dart';
import 'views/planner_page.dart';
import 'views/material_requirements_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper().database;
  await ThemeManager().initialize();
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
            // Botão de toggle do tema
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
