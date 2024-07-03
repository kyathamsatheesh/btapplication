import 'package:flutter/material.dart';
import 'database_helper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> _items = [];

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  void _fetchItems() async {
    final data = await dbHelper.getItems();
    setState(() {
      _items = data;
    });
  }

  void _addItem() async {
    await dbHelper.insertItem({'name': 'New Item', 'angle': 'Item description'});
    _fetchItems();
  }

  void _updateItem(int id) async {
    await dbHelper.updateItem({'id': id, 'name': 'Updated Item', 'angle': 'Updated description'});
    _fetchItems();
  }

  void _deleteItem(int id) async {
   // await dbHelper.deleteItem(id);
    _fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite CRUD'),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_items[index]['name']),
            subtitle: Text(_items[index]['angle']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _updateItem(_items[index]['id']),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteItem(_items[index]['id']),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: Icon(Icons.add),
      ),
    );
  }
}