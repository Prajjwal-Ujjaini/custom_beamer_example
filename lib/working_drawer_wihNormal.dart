import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drawer & Bottom Nav Sync',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedBottomNavIndex = 1; // Default is Home
  String _currentDrawerSelection = 'Home';

  // Pages for each section
  final Map<String, Widget> _pages = {
    'Home': Center(child: Text('Home Page', style: TextStyle(fontSize: 24))),
    'Services':
        Center(child: Text('Services Page', style: TextStyle(fontSize: 24))),
    'Task': Center(child: Text('Task Page', style: TextStyle(fontSize: 24))),
    'Profile':
        Center(child: Text('Profile Page', style: TextStyle(fontSize: 24))),
    'Settings':
        Center(child: Text('Settings Page', style: TextStyle(fontSize: 24))),
  };

  void _updateContent(String newSelection) {
    setState(() {
      _currentDrawerSelection = newSelection;

      // Sync the BottomNav selection
      switch (newSelection) {
        case 'Home':
          _selectedBottomNavIndex = 1;
          break;
        case 'Profile':
          _selectedBottomNavIndex = 0;
          break;
        case 'Settings':
          _selectedBottomNavIndex = 2;
          break;
        default:
          break;
      }
    });
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedBottomNavIndex = index;

      // Sync the Drawer selection
      switch (index) {
        case 0:
          _currentDrawerSelection = 'Profile';
          break;
        case 1:
          _currentDrawerSelection = 'Home';
          break;
        case 2:
          _currentDrawerSelection = 'Settings';
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drawer & BottomNav Sync'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                child: Text(
                  'App Drawer',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              selected: _currentDrawerSelection == 'Home',
              onTap: () {
                Navigator.pop(context); // Close the drawer
                _updateContent('Home');
              },
            ),
            ListTile(
              title: Text('Services'),
              leading: Icon(Icons.design_services),
              selected: _currentDrawerSelection == 'Services',
              onTap: () {
                Navigator.pop(context); // Close the drawer
                _updateContent('Services');
              },
            ),
            ListTile(
              title: Text('Task'),
              leading: Icon(Icons.task),
              selected: _currentDrawerSelection == 'Task',
              onTap: () {
                Navigator.pop(context); // Close the drawer
                _updateContent('Task');
              },
            ),
            Spacer(),
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.logout),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logged Out!')),
                );
              },
            ),
          ],
        ),
      ),
      body: _pages[_currentDrawerSelection] ??
          Center(child: Text('Page Not Found')),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedBottomNavIndex,
        onTap: _onBottomNavTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
