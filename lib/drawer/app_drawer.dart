// Drawer Widget
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Center(
              child: Text(
                'Navigation Drawer',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              context.beamToNamed('/home');
              Navigator.of(context).pop(); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.work),
            title: const Text('Services'),
            onTap: () {
              context.beamToNamed('/services');
              Navigator.of(context).pop(); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.task),
            title: const Text('Tasks'),
            onTap: () {
              context.beamToNamed('/task');
              Navigator.of(context).pop(); // Close the drawer
            },
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.of(context).pop(); // Close the drawer
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged Out!')),
              );
            },
          ),
        ],
      ),
    );
  }
}
