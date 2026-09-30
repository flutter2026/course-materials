import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bank Balance Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DatabasePage(),
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'bank_balances.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE people (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            balance REAL NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> insertPerson(String name, double balance) async {
    final db = await database;
    await db.insert(
      'people',
      {'name': name, 'balance': balance},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getAllPeople() async {
    final db = await database;
    return db.query('people');
  }
}

class DatabasePage extends StatefulWidget {
  const DatabasePage({super.key});

  @override
  State<DatabasePage> createState() => _DatabasePageState();
}

class _DatabasePageState extends State<DatabasePage> {
  BuildContext? _scaffoldContext;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();
  List<Map<String, dynamic>> peopleData = [];
  bool isLoading = false;

  void _addPerson() async {
    String name = nameController.text.trim();
    String balanceStr = balanceController.text.trim();

    if (name.isEmpty || balanceStr.isEmpty) {
      ScaffoldMessenger.of(_scaffoldContext!).showSnackBar(
        const SnackBar(content: Text('Please enter both name and balance')),
      );
      return;
    }

    try {
      double balance = double.parse(balanceStr);
      await DatabaseHelper().insertPerson(name, balance);
      setState(() {
        peopleData.add({'id': 0, 'name': name, 'balance': balance});
      });
      nameController.clear();
      balanceController.clear();
    } catch (e) {
      ScaffoldMessenger.of(_scaffoldContext!).showSnackBar(
        SnackBar(content: Text('Invalid balance: $e')),
      );
    }
  }

  Future<void> _loadAllPeople() async {
    setState(() => isLoading = true);
    try {
      final data = await DatabaseHelper().getAllPeople();
      setState(() => peopleData = data);
    } catch (e) {
      ScaffoldMessenger.of(_scaffoldContext!).showSnackBar(
        SnackBar(content: Text('Error loading data: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadAllPeople();
  }

  @override
  void dispose() {
    nameController.dispose();
    balanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scaffoldContext = context;
    return Scaffold(
      key: const Key('scaffold'),
      appBar: AppBar(
        title: const Text('Bank Balance Tracker'),
      ),
      body: Column(
        children: [
          // Input section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: balanceController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                  decoration: InputDecoration(
                    labelText: 'Bank Balance (\$)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _addPerson,
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          // List section
          if (isLoading) const Center(child: CircularProgressIndicator()),
          Expanded(
            child: ListView.builder(
              itemCount: peopleData.length,
              itemBuilder: (context, index) {
                final person = peopleData[index];
                return ListTile(
                  title: Text(person['name'] as String),
                  subtitle: Text('\$${person['balance'] as double}'),
                  trailing: Icon(Icons.person_outline),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _loadAllPeople,
        icon: const Icon(Icons.refresh),
        label: const Text('Show All'),
      ),
    );
  }
}
