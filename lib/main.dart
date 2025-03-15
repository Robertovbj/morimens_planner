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
    print("Starting application in debug mode");
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
      home: const MainAppScaffold(initialPage: 0),
    );
  }
}

class MainAppScaffold extends StatefulWidget {
  final int initialPage;
  
  const MainAppScaffold({super.key, required this.initialPage});

  @override
  State<MainAppScaffold> createState() => _MainAppScaffoldState();
}

class _MainAppScaffoldState extends State<MainAppScaffold> {
  late int _currentPageIndex;
  
  // List of main pages
  final List<Widget> _pages = [
    const MaterialRequirementsPage(),
    const PlannerPage(),
    const SettingsPage(),
  ];

  // Page titles
  final List<String> _pageTitles = [
    'Materials',
    'Awakers',
    'Settings',
  ];

  @override
  void initState() {
    super.initState();
    _currentPageIndex = widget.initialPage;
  }

  void _navigateToPage(int index) {
    // Close the drawer
    Navigator.pop(context);
    
    // Update current page
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeManager().isDarkMode;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_currentPageIndex]),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: GestureDetector(
                onTap: () {
                  // Secret code to activate debug mode
                  int tapCount = DebugConfig().secretTapCount + 1;
                  DebugConfig().secretTapCount = tapCount;
                  
                  if (tapCount >= 10) {
                    setState(() {
                      DebugConfig().isDebugMode = true;
                      DebugConfig().secretTapCount = 0;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Debug mode activated!')),
                    );
                  }
                },
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
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Materials'),
              selected: _currentPageIndex == 0,
              onTap: () => _navigateToPage(0),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Awakers'),
              selected: _currentPageIndex == 1,
              onTap: () => _navigateToPage(1),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              selected: _currentPageIndex == 2,
              onTap: () => _navigateToPage(2),
            ),
            if (DebugConfig().isDebugMode) ...DebugViews.debugMenuItems(context),
          ],
        ),
      ),
      body: _pages[_currentPageIndex],
    );
  }
}
