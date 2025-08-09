import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('_stateManagement lab'),
        backgroundColor: Colors.blueGrey.shade800,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Check any of my apps or projects below',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  _listCard(
                    context: context,
                    title: 'To-Do App',
                    description: 'A simple to-do app to organize your tasks effectively.',
                    subtitle: 'Manage a list of items with setState()',
                    assetPath: 'icons/todo_app.png',
                    onTap: () {
                      Navigator.pushNamed(context, '/todo_app');
                    },
                  ),
                  _listCard(
                    context: context,
                    title: 'Calculator App',
                    description: 'Perform calculations with a clean and simple UI.',
                    subtitle: 'Includes basic arithmetic operations',
                    assetPath: 'icons/calculator_app.png',
                    onTap: () {
                      Navigator.pushNamed(context, '/calculator_app');
                    },
                  ),
                  _listCard(
                    context: context,
                    title: 'Counter App',
                    description: 'Count increments and decrements easily.',
                    subtitle: 'Uses setState() for state management',
                    assetPath: 'icons/counter_app.png',
                    onTap: () {
                      Navigator.pushNamed(context, '/counter_app');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _listCard({
    required BuildContext context,
    required String title,
    required String description,
    required String subtitle,
    required String assetPath,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
        shadowColor: Colors.blueGrey.withOpacity(0.4),
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  //color: Colors.blueGrey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  assetPath,
                  width: 45,
                  height: 55,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
