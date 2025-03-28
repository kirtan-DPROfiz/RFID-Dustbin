/*
// dustbin_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DustbinPage extends StatelessWidget {
  final List<Map<String, String>> dustbins = [
    {'id': 'D001', 'location': '1st floor '},
    {'id': 'D002', 'location': '2nd floor'},
    {'id': 'D003', 'location': '3rd floor'},
    {'id': 'D004', 'location': '4th floor'},
    {'id': 'D005', 'location': '5th floor'},
    {'id': 'D001', 'location': '1st floor '},
    {'id': 'D002', 'location': '2nd floor'},
    {'id': 'D003', 'location': '3rd floor'},
    {'id': 'D004', 'location': '4th floor'},
    {'id': 'D005', 'location': '5th floor'},
    {'id': 'D001', 'location': '1st floor '},
    {'id': 'D002', 'location': '2nd floor'},
    {'id': 'D003', 'location': '3rd floor'},
    {'id': 'D004', 'location': '4th floor'},
    {'id': 'D005', 'location': '5th floor'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: 20.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIconColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.search_sharp,
                          ),
                          hintText: 'Search Dustbin...',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          filled: true,
                          fillColor: Colors.grey,
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        Get.to(() => AddDustbinPage());
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize
                            .min, // To keep the row size as small as possible
                        children: [
                          Icon(Icons.add, color: Colors.white),
                          SizedBox(
                              width:
                                  8), // Add some space between the icon and text
                          Text("Add New",
                              style: TextStyle(
                                  color: Colors.white)), // Add your text here
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              color: Colors.grey[200],
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Dustbin ID',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Location',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Action',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final dustbin = dustbins[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  child: ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(dustbin['id']!),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(dustbin['location']!),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  // Navigate to Edit Dustbin Page

                                  Get.to(
                                    () => EditDustbinPage(dustbin: dustbin),
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  // Show delete confirmation dialog
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Delete Dustbin'),
                                      content: Text(
                                          'Are you sure you want to delete ${dustbin['id']}?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // Delete dustbin logic
                                            print('Deleted: ${dustbin['id']}');
                                            Navigator.pop(context);
                                          },
                                          child: Text('Delete'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: dustbins.length,
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder pages for Add and Edit Dustbin
class AddDustbinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Dustbin')),
      body: Center(child: Text('Add Dustbin Form')),
    );
  }
}

class EditDustbinPage extends StatelessWidget {
  final Map<String, String> dustbin;

  EditDustbinPage({required this.dustbin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Dustbin')),
      body: Center(child: Text('Edit Dustbin Form for ${dustbin['id']}')),
    );
  }
}
*/

/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DustbinPage extends StatefulWidget {
  @override
  _DustbinPageState createState() => _DustbinPageState();
}

class _DustbinPageState extends State<DustbinPage> {
  List<Map<String, String>> dustbins = [
    {'id': 'D001', 'location': '1st floor'},
    {'id': 'D002', 'location': '2nd floor'},
    {'id': 'D003', 'location': '3rd floor'},
    {'id': 'D004', 'location': '4th floor'},
    {'id': 'D005', 'location': '5th floor'},
  ];

  String searchQuery = '';

  void _addNewDustbin() {
    String newId = '';
    String newLocation = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Dustbin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Dustbin ID'),
              onChanged: (value) => newId = value.trim(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Location'),
              onChanged: (value) => newLocation = value.trim(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (newId.isNotEmpty && newLocation.isNotEmpty) {
                setState(() {
                  dustbins.add({'id': newId, 'location': newLocation});
                });
                Navigator.pop(context);
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredDustbins = dustbins;

    if (searchQuery.isNotEmpty) {
      filteredDustbins = List.from(dustbins);
      filteredDustbins.sort((a, b) {
        if (a['id']!.toLowerCase().contains(searchQuery.toLowerCase())) {
          return -1;
        } else if (b['id']!.toLowerCase().contains(searchQuery.toLowerCase())) {
          return 1;
        }
        return 0;
      });
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            floating: true,
            expandedHeight: 20.0,
            flexibleSpace: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.black),
                        hintText: 'Search Dustbin by ID...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        filled: true,
                        fillColor: Colors.grey[300],
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value.trim();
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: _addNewDustbin,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add, color: Colors.white),
                          SizedBox(width: 8),
                          Text("Add New",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _HeaderDelegate(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final dustbin = filteredDustbins[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(dustbin['id']!,
                              style: TextStyle(fontSize: 16)),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(dustbin['location']!,
                              style: TextStyle(fontSize: 16)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  Get.to(
                                      () => EditDustbinPage(dustbin: dustbin));
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Delete Dustbin'),
                                      content: Text(
                                          'Are you sure you want to delete ${dustbin['id']}?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                          
                                              Get.back(),
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              dustbins.removeWhere((item) =>
                                                  item['id'] == dustbin['id']);
                                            });
                      
                                            Get.back();
                                          },
                                          child: Text('Delete'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: filteredDustbins.length,
            ),
          ),
        ],
      ),
    );
  }
}

// SliverPersistentHeader Delegate for Fixed Header
class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text('Dustbin ID',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 3,
            child:
                Text('Location', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 1,
            child:
                Text('Action', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 36.0;

  @override
  double get minExtent => 36.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

// Placeholder pages for Add and Edit Dustbin
class AddDustbinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Dustbin')),
      body: Center(child: Text('Add Dustbin Form')),
    );
  }
}

class EditDustbinPage extends StatelessWidget {
  final Map<String, String> dustbin;

  EditDustbinPage({required this.dustbin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Dustbin')),
      body: Center(child: Text('Edit Dustbin Form for ${dustbin['id']}')),
    );
  }
}
*/

/*
import 'package:Deprofiz/controllers/dustbin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DustbinPage extends StatefulWidget {
  @override
  _DustbinPageState createState() => _DustbinPageState();
}

class _DustbinPageState extends State<DustbinPage> {
  final DustbinController dustbinController = Get.put(DustbinController());

  List<Map<String, String>> dustbins = [
    {'id': 'D001', 'location': '1st floor'},
    {'id': 'D002', 'location': '2nd floor'},
    {'id': 'D003', 'location': '3rd floor'},
    {'id': 'D004', 'location': '4th floor'},
    {'id': 'D005', 'location': '5th floor'},
  ];

  String searchQuery = '';

  void _addNewDustbin() {
    String newId = '';
    String newLocation = '';

    // Inside _addNewDustbin() function:
    if (newId.isNotEmpty && newLocation.isNotEmpty) {
      setState(() {
        dustbinController.dustbins.add({'id': newId, 'location': newLocation});
   

        // dustbinController.updateDustbinCount(dustbins.length);
      });
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Dustbin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Dustbin ID'),
              onChanged: (value) => newId = value.trim(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Location'),
              onChanged: (value) => newLocation = value.trim(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (newId.isNotEmpty && newLocation.isNotEmpty) {
                setState(() {
                //
                });
                Navigator.pop(context);
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  void _editDustbin(Map<String, String> dustbin) {
    TextEditingController idController =
        TextEditingController(text: dustbin['id']);
    TextEditingController locationController =
        TextEditingController(text: dustbin['location']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Dustbin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: idController,
              decoration: InputDecoration(labelText: 'Dustbin ID'),
            ),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                dustbin['id'] = idController.text.trim();
                dustbin['location'] = locationController.text.trim();
              });
              Get.back();
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredDustbins = dustbins;

    if (searchQuery.isNotEmpty) {
      filteredDustbins = List.from(dustbins);
      filteredDustbins.sort((a, b) {
        if (a['id']!.toLowerCase().contains(searchQuery.toLowerCase())) {
          return -1;
        } else if (b['id']!.toLowerCase().contains(searchQuery.toLowerCase())) {
          return 1;
        }
        return 0;
      });
    }

    return Scaffold(
      key: GlobalKey<ScaffoldState>(), // Ensure each Scaffold has a unique key
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            floating: true,
            expandedHeight: 20.0,
            flexibleSpace: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.black),
                        hintText: 'Search Dustbin by ID...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        filled: true,
                        fillColor: Colors.grey[300],
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value.trim();
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: _addNewDustbin,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add, color: Colors.white),
                          SizedBox(width: 8),
                          Text("Add New",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _HeaderDelegate(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final dustbin = filteredDustbins[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(dustbin['id']!,
                              style: TextStyle(fontSize: 16)),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(dustbin['location']!,
                              style: TextStyle(fontSize: 16)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  _editDustbin(dustbin);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Delete Dustbin'),
                                      content: Text(
                                          'Are you sure you want to delete ${dustbin['id']}?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              dustbins.removeWhere((item) =>
                                                  item['id'] == dustbin['id']);
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Text('Delete'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: filteredDustbins.length,
            ),
          ),
        ],
      ),
    );
  }
}

// SliverPersistentHeader Delegate for Fixed Header
class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text('Dustbin ID',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
              flex: 3,
              child: Text('Location',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
              flex: 1,
              child: Text('Action',
                  style: TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 36.0;

  @override
  double get minExtent => 36.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
*/

//2
/*

import 'package:Deprofiz/controllers/dustbin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DustbinPage extends StatefulWidget {
  @override
  _DustbinPageState createState() => _DustbinPageState();
}

class _DustbinPageState extends State<DustbinPage> {
  final DustbinController dustbinController = Get.put(DustbinController());

  String searchQuery = '';

  void addNewDustbin() {
    String newDustbinID = '';
    String newLocation = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Dustbin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Dustbin ID'),
              onChanged: (value) => newDustbinID = value.trim(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Location'),
              onChanged: (value) => newLocation = value.trim(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (newDustbinID.isNotEmpty && newLocation.isNotEmpty) {
                dustbinController.addDustbin(newDustbinID, newLocation);
                Navigator.pop(context);
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  void editDustbin(Map<String, String> dustbin) {
    TextEditingController idController =
        TextEditingController(text: dustbin['id']);
    TextEditingController locationController =
        TextEditingController(text: dustbin['location']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Dustbin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: idController,
              decoration: InputDecoration(labelText: 'Dustbin ID'),
            ),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                dustbin['id'] = idController.text.trim();
                dustbin['location'] = locationController.text.trim();
              });
              Get.back();
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalKey<ScaffoldState>(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            floating: true,
            expandedHeight: 20.0,
            flexibleSpace: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.black),
                        hintText: 'Search Dustbin by ID or Location...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        filled: true,
                        fillColor: Colors.grey[300],
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value.trim();
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: addNewDustbin,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add, color: Colors.white),
                          SizedBox(width: 8),
                          Text("Add New",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Obx(() => Text(
                    'Total Dustbins: ${dustbinController.dustbins.length}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _HeaderDelegate(),
          ),
          Obx(() {
            List<Map<String, String>> filteredDustbins = dustbinController
                .dustbins
                .where((dustbin) =>
                    dustbin['id']!
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()) ||
                    dustbin['location']!
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()))
                .cast<Map<String, String>>()
                .toList();
            print(filteredDustbins);
            Text('Dustbins: ${dustbinController.dustbins.toString()}');

            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  print(filteredDustbins);

                  final dustbin = filteredDustbins[index];
                  return Card(
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(dustbin['id']!,
                                style: TextStyle(fontSize: 16)),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(dustbin['location']!,
                                style: TextStyle(fontSize: 16)),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {
                                    // Implement edit functionality
                                    editDustbin(dustbin);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Delete Dustbin'),
                                        content: Text(
                                            'Are you sure you want to delete ${dustbin['id']}?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              dustbinController.removeDustbin(
                                                  dustbin['id']!);
                                              Navigator.pop(context);
                                            },
                                            child: Text('Delete'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: filteredDustbins.length,
              ),
            );
          }),
        ],
      ),
    );
  }
}

// SliverPersistentHeader Delegate for Fixed Header
class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text('Dustbin ID',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
              flex: 2,
              child: Text('Location',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
              flex: 1,
              child: Text('Action',
                  style: TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 36.0;

  @override
  double get minExtent => 36.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
*/

/*
// that previous one
import 'dart:developer';
import 'package:Deprofiz/models/api_models/dustbin_list_in_array.dart';
import 'package:Deprofiz/network%20manager/rest_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/dustbin_controller.dart';
import '../../models/my_files.dart';

class DustbinPage extends StatefulWidget {
  @override
  _DustbinPageState createState() => _DustbinPageState();
}

class _DustbinPageState extends State<DustbinPage> {
  // Initialize DustbinController using Get.put for dependency injection
  final DustbinController dustbinController = Get.put(DustbinController());
  bool isLoading = true;
  String errorMessage = "";
  List<DustBinListInArray> dustbinListInArray = [];
  var dustbins = <Map<String, String>>[].obs;



  // Variable to hold search query input
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    print("➡️ [DustbinPage] initState called.");
    dustbinList();
  }
  void dustbinList() async {

    print("➡️ [DustbinPage] Starting userList...");

    try {
      final value = await RestClient.getDustbinListInArray();
      log("✅ [DustbinPage] API Response: $value");

      if (value.isEmpty) {
        log("⚠️ [DustbinPage] Warning: API returned an empty list.");
        setState(() {
          errorMessage = "No data found.";
          isLoading = false;
        });
      } else {
        log("📊 [DustbinPage] API returned data: ${value.length} items");
        setState(() {
          dustbinListInArray = value ?? [];
          isLoading = false;
        });
      }

    } catch (error) {
      log("❌ [DustbinPage] Error fetching API data: $error");
      setState(() {
        errorMessage = "Failed to load data. Please check your network or try again.";
        isLoading = false;
      });
    } finally {
      print("➡️ [DustbinPage] userList execution completed.");
    }
  }

// Method to add a new dustbin using API
  void addNewDustbin() {
    print("addNewDustbin() called"); // Log for method invocation
    String newDustbinID = '';
    String newLocation = '';

    // Show dialog to input dustbin details
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Dustbin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TextField for entering Dustbin ID
            TextField(
              decoration: InputDecoration(labelText: 'Dustbin ID'),
              onChanged: (value) {
                newDustbinID = value.trim();
                print("✏️ Dustbin ID entered: $newDustbinID"); // Log user input
              },
            ),
            // TextField for entering Location
            TextField(
              decoration: InputDecoration(labelText: 'Location'),
              onChanged: (value) {
                newLocation = value.trim();
                print("📍 Location entered: $newLocation"); // Log user input
              },
            ),
          ],
        ),
        actions: [
          // Cancel button to close the dialog
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          // Add button to submit dustbin details
          TextButton(
            onPressed: () async {
                if (newDustbinID.isNotEmpty && newLocation.isNotEmpty) {
                  print("🚀 [DustbinPage] Attempting to add new dustbin: ID=$newDustbinID, Location=$newLocation");

                  try {
                    await RestClient.addNewDustbin({
                      "dustbin_id": newDustbinID,
                      "location": newLocation,
                    });
                    Get.snackbar("Success", "Dustbin added successfully!");
                    dustbinList(); // Refresh the list
                    Get.back();
                  } catch (e) {
                    Get.snackbar("Error", "Failed to add dustbin: $e");
                  }
                } else {
                  print("⚠️ [DustbinPage] Both fields are required!");
                  Get.snackbar("Warning", "Please fill all fields");
                }
            },

/* async {
              if (newDustbinID.isNotEmpty && newLocation.isNotEmpty) {
                print(
                    "🚀 Sending new dustbin details to API: ID=$newDustbinID, Location=$newLocation");

                // Prepare the request body
                Map<String, dynamic> requestBody = {
                  "dustbin_id": newDustbinID,
                  "location": newLocation,
                };

                // Call the API to add the dustbin
                final restclien = RestClient();
                var response = await RestClient.AddNewDustbin(requestBody);

                print("🔄 API Response Received: $response");

                // Check if API call was successful
                if (response != null && response['status'] == "success") {
                  print("✅ Dustbin added successfully!");
                  Get.snackbar("Success", "Dustbin added successfully!",
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.black,
                      colorText: Colors.greenAccent);
                  Get.back(); // Close the dialog
                } else {
                  print("❌ Failed to add dustbin. Response: $response");
                  Get.snackbar("Error", "Failed to add dustbin. Try again!",
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.black,
                      colorText: Colors.redAccent);
                }
              } else {
                print("⚠️ Both fields are required!");
                Get.snackbar("Warning", "Please fill all fields",
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.black,
                    colorText: Colors.redAccent);
              }
            },*/

            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  // Method to edit an existing dustbin
  void editDustbin(Map<String, String> dustbin) {
    print("editDustbin() called with dustbin: $dustbin"); // Log method call
    TextEditingController idController =
        TextEditingController(text: dustbin['id']);
    TextEditingController locationController =
        TextEditingController(text: dustbin['location']);

    // Show dialog for editing dustbin details
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Dustbin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TextField for editing Dustbin ID
            TextField(
              controller: idController,
              decoration: InputDecoration(labelText: 'Dustbin ID'),
            ),
            // TextField for editing Location
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
          ],
        ),
        actions: [
          // Cancel button to close the dialog
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          // Update button to save changes
          TextButton(
            onPressed: ()  async {
                print("✏️ [DustbinPage] Attempting to update dustbin: ID=${idController.text}, Location=${locationController.text}");

                try {
                  await RestClient.updateDustbin({
                    "dustbin_id": idController.text.trim(),
                    "location": locationController.text.trim(),
                  });
                  Get.snackbar("Success", "Dustbin updated successfully!");
                  dustbinList(); // Refresh the list
                  Get.back();
                } catch (e) {
                  Get.snackbar("Error", "Failed to update dustbin: $e");
                }
              setState(() {
                dustbin['id'] = idController.text.trim();
                dustbin['location'] = locationController.text.trim();
                print("Updated dustbin: $dustbin"); // Log updated data
              });
              Get.back(); // Close the dialog
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  // Method to delete a dustbin
  void manageAccessDustbin(String dustbinId) {
    print(
        "manageAccessDustbin() called for dustbin ID: $dustbinId"); // Log method call
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Access remove Dustbin'),
        content: Text('Are you sure you want to remove the access for  $dustbinId?'),
        actions: [
          // Cancel button to close the dialog
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          // Delete button to confirm deletion
          TextButton(
            onPressed: () async {
              print("🗑️ [DustbinPage] Attempting to delete dustbin: ID=$dustbinId");

              try {
                await RestClient.manageAccessDustbin(dustbinId);
                Get.snackbar("Success", "Dustbin Access remove successfully!");
                dustbinList(); // Refresh the list
                Get.back();
              } catch (e) {
                Get.snackbar("Error", "Failed to delete dustbin: $e");
              }


              //dustbinController.removeDustbin(dustbinId);
              //Navigator.pop(context);
              print("Access remove for dustbin: $dustbinId"); // Log deletion
            },
            child: Text('Access remove '),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalKey<ScaffoldState>(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            floating: true,
            expandedHeight: 20.0,
            flexibleSpace: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                children: [
                  // Search bar for filtering dustbins
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 36.0, // Set a fixed height for the search bar
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Colors.black),
                          hintText: 'Search Dustbin by ID or Location...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey[300],
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value.trim();
                            print("Search query updated: $searchQuery");
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  // Button to add a new dustbin
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 36.0, // Set the same fixed height for the button
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                        ),
                        onPressed: addNewDustbin,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add, color: Colors.white),
                            SizedBox(width: 8),
                            Text("Add New", style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Display the total number of dustbins
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Obx(() {
                print("Total dustbins:${dustbinListInArray.length}");
                return Text(
                  'Total Dustbins: ${dustbinListInArray.length}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                );
              }),
            ),
          ),
          // Fixed header for dustbin table
          SliverPersistentHeader(
            pinned: true,
            delegate:_HeaderDelegate(dustbins: dustbinListInArray),
          ),

          // List of dustbins filtered by search query
          Obx(() {

            List<Map<String, String>> filteredDustbins = dustbinController
                .dustbins
                .where((dustbin) =>
                    dustbin['id']!
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()) ||
                    dustbin['location']!
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()))
                .cast<Map<String, String>>()
                .toList();
            print("Filtered dustbins: $filteredDustbins");

            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final dustbin = filteredDustbins[index];
                  print("Rendering dustbin: $dustbin");

                  return Card(
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          // Display Dustbin ID
                          Expanded(
                            flex: 2,
                            child: Text(dustbin['id']!,
                                style: TextStyle(fontSize: 16)),
                          ),
                          // Display Location
                          Expanded(
                            flex: 2,
                            child: Text(dustbin['location']!,
                                style: TextStyle(fontSize: 16)),
                          ),
                          // Three-dot menu for actions
                          Expanded(
                            flex: 1,
                            child: PopupMenuButton<String>(
                              icon: Icon(Icons.more_vert, color: Colors.black),
                              onSelected: (value) {
                                if (value == 'edit') {
                                  print(
                                      "Edit option selected for dustbin: ${dustbin['id']}");
                                  editDustbin(dustbin);
                                } else if (value == 'remove Access') {
                                  print(" Access have been removed for selected  dustbin: ${dustbin['id']}");

                                }
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 'edit',
                                  child: Text('Edit Details'),
                                ),
                                PopupMenuItem(
                                  value: 'Remove Access',
                                  child: Text('Remove Access'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: filteredDustbins.length,
              ),
            );
          }),
        ],
      ),
    );
  }
}

// SliverPersistentHeader Delegate for Fixed Header
class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final List<DustBinListInArray> dustbins;

  _HeaderDelegate({required this.dustbins});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          // Header Row
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text('Dustbin ID',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(
                  flex: 2,
                  child: Text('Location',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(
                  flex: 1,
                  child: Text('Action',
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
          // List of Dustbins
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: dustbins.length,
              itemBuilder: (context, index) {
                final dustbin = dustbins[index];
                return Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(dustbin.dustbinId.toString(),
                          style: TextStyle(fontSize: 14)),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(dustbin.location.toString(),
                          style: TextStyle(fontSize: 14)),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(Icons.more_vert, color: Colors.black),
                        onPressed: () {
                          // Handle actions (edit, delete, etc.)
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 200.0; // Adjust height as needed

  @override
  double get minExtent => 36.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;



}
*/

// new one

import 'dart:developer';
import 'package:Deprofiz/models/api_models/All_Access_Block_List_In_Obj.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/api_models/dustbin_list_in_array.dart';

import '../../network manager/rest_client.dart';

class DustbinPage extends StatefulWidget {
  @override
  _DustbinPageState createState() => _DustbinPageState();
}

class _DustbinPageState extends State<DustbinPage> {
  bool isLoading = true;
  String errorMessage = "";
  List<DustBinListInArray> dustbinListInObj = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    print("➡️ [DustbinPage] initState called.");
    fetchDustbins();
  }

  // Fetch dustbin data from the API
  void fetchDustbins() async {
    print("➡️ [DustbinPage] Starting fetchDustbins...");

    try {
      final value = await RestClient.getDustbinListInArray();
      log("✅ [DustbinPage] API Response: $value");

      if (value.isEmpty) {
        log("⚠️ [DustbinPage] Warning: API returned an empty list.");
        setState(() {
          errorMessage = "No data found.";
          isLoading = false;
        });
      } else {
        log("📊 [DustbinPage] API returned data: ${value.length} items");
        setState(() {
          dustbinListInObj = value ?? [];
          //dustbinListInObj = value.cast<DustBinListInObj>();
          isLoading = false;
        });
      }
    } catch (error) {
      log("❌ [DustbinPage] Error fetching API data: $error");
      setState(() {
        errorMessage =
            "Failed to load data. Please check your network or try again.";
        isLoading = false;
      });
    } finally {
      print("➡️ [DustbinPage] fetchDustbins execution completed.");
    }
  }

  // Method to add a new dustbin using API
  void addNewDustbin() {
    print("addNewDustbin() called"); // Log for method invocation
    String newDustbinID = '';
    String newLocation = '';

    // Show dialog to input dustbin details
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Dustbin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TextField for entering Dustbin ID
            TextField(
              decoration: InputDecoration(labelText: 'Dustbin ID'),
              onChanged: (value) {
                newDustbinID = value.trim();
                print("✏️ Dustbin ID entered: $newDustbinID"); // Log user input
              },
            ),
            // TextField for entering Location
            TextField(
              decoration: InputDecoration(labelText: 'Location'),
              onChanged: (value) {
                newLocation = value.trim();
                print("📍 Location entered: $newLocation"); // Log user input
              },
            ),
          ],
        ),
        actions: [
          // Cancel button to close the dialog
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          // Add button to submit dustbin details
          TextButton(
            onPressed: () async {
              if (newDustbinID.isNotEmpty && newLocation.isNotEmpty) {
                print(
                    "🚀 [DustbinPage] Attempting to add new dustbin: ID=$newDustbinID, Location=$newLocation");

                try {
                  await RestClient.addNewDustbin({
                    "dustbin_id": newDustbinID,
                    "location": newLocation,
                  });
                  Get.snackbar("Success", "Dustbin added successfully!",
                      backgroundColor: Colors.black,
                      colorText: Colors.greenAccent,
                      snackPosition: SnackPosition.TOP);
                  fetchDustbins(); // Refresh the list
                  Get.back();
                } catch (e) {
                  Get.snackbar("Error", "Failed to add dustbin: $e",
                      backgroundColor: Colors.black,
                      colorText: Colors.redAccent,
                      snackPosition: SnackPosition.TOP);
                }
              } else {
                print("⚠️ [DustbinPage] Both fields are required!");
                Get.snackbar("Warning", "Please fill all fields",
                    backgroundColor: Colors.black,
                    colorText: Colors.redAccent,
                    snackPosition: SnackPosition.TOP);
              }
            },

/* async {
              if (newDustbinID.isNotEmpty && newLocation.isNotEmpty) {
                print(
                    "🚀 Sending new dustbin details to API: ID=$newDustbinID, Location=$newLocation");

                // Prepare the request body
                Map<String, dynamic> requestBody = {
                  "dustbin_id": newDustbinID,
                  "location": newLocation,
                };

                // Call the API to add the dustbin
                final restclien = RestClient();
                var response = await RestClient.AddNewDustbin(requestBody);

                print("🔄 API Response Received: $response");

                // Check if API call was successful
                if (response != null && response['status'] == "success") {
                  print("✅ Dustbin added successfully!");
                  Get.snackbar("Success", "Dustbin added successfully!",
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.black,
                      colorText: Colors.greenAccent);
                  Get.back(); // Close the dialog
                } else {
                  print("❌ Failed to add dustbin. Response: $response");
                  Get.snackbar("Error", "Failed to add dustbin. Try again!",
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.black,
                      colorText: Colors.redAccent);
                }
              } else {
                print("⚠️ Both fields are required!");
                Get.snackbar("Warning", "Please fill all fields",
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.black,
                    colorText: Colors.redAccent);
              }
            },*/

            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  // Method to edit an existing dustbin
  void editDustbin(Map<String, String> dustbin) {
    print("editDustbin() called with dustbin: $dustbin"); // Log method call
    TextEditingController idController =
        TextEditingController(text: dustbin['id']);
    TextEditingController locationController =
        TextEditingController(text: dustbin['location']);

    // Show dialog for editing dustbin details
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Dustbin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TextField for editing Dustbin ID
            TextField(
              controller: idController,
              decoration: InputDecoration(labelText: 'Dustbin ID'),
            ),
            // TextField for editing Location
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
          ],
        ),
        actions: [
          // Cancel button to close the dialog
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          // Update button to save changes
          TextButton(
            onPressed: () async {
              print(
                  "✏️ [DustbinPage] Attempting to update dustbin: ID=${idController.text}, Location=${locationController.text}");

              try {
                await RestClient.updateDustbin({
                  "dustbin_id": idController.text.trim(),
                  "location": locationController.text.trim(),
                });
                Get.snackbar("Success", "Dustbin updated successfully!",
                    backgroundColor: Colors.black,
                    colorText: Colors.greenAccent,
                    snackPosition: SnackPosition.TOP);
                fetchDustbins(); // Refresh the list
                Get.back();
              } catch (e) {
                Get.snackbar("Error", "Failed to update dustbin: $e",
                    backgroundColor: Colors.black,
                    colorText: Colors.redAccent,
                    snackPosition: SnackPosition.TOP);
              }
              setState(() {
                dustbin['id'] = idController.text.trim();
                dustbin['location'] = locationController.text.trim();
                print("Updated dustbin: $dustbin"); // Log updated data
              });
              Get.back(); // Close the dialog
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  // Method to Grant a dustbin
  void grantAccessDustbin(String dustbinId) {
    print(
        "grantAccessDustbin() called for dustbin ID: $dustbinId"); // Log method call

    TextEditingController cardIdController = TextEditingController();
    TextEditingController dustbinIdController =
        TextEditingController(text: dustbinId);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Grant Access  Dustbin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Enter Card ID and Dustbin ID to Grant access'),
            TextFormField(
              controller: cardIdController,
              decoration: InputDecoration(labelText: 'Card ID'),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: dustbinIdController,
              decoration: InputDecoration(labelText: 'Dustbin ID'),
              enabled: false, // Dustbin ID should not be editable
            ),
          ],
        ),
        actions: [
          // Cancel button to close the dialog
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          // Remove Access button to confirm removal
          TextButton(
            onPressed: () async {
              String cardId = cardIdController.text.trim();
              String dustbinId = dustbinIdController.text.trim();

              if (cardId.isEmpty) {
                print("Card ID cannot be empty");
                Get.snackbar("Error", "Card ID cannot be empty");
                return;
              }

              print(
                  "🗑️ [DustbinPage] Attempting to granting Access of dustbin: ID=$dustbinId for Card ID=$cardId");

              try {
                await RestClient.grantAccessDB(
                    {"card_id": cardId, "dustbin_id": dustbinId});
                print("Dustbin Access Grant successfully!");
                // Get.snackbar("Success", "Dustbin Access grant successfully!");
                // fetchDustbins(); // Refresh the list
                Get.back();
              } catch (e) {
                print("Failed to grant access: $e");
                Get.snackbar("Error", "Failed to grant access: $e");
              }

              print(
                  "Access removed for dustbin: $dustbinId with Card ID: $cardId"); // Log removal
            },
            child: Text('Grant Access'),
          ),
        ],
      ),
    );
  }

  // Method to remove a dustbin
  //-------------------------previous in which we have to add card ID manually for removing Access--------//
/*  void removeAccessDustbin(String dustbinId) {
    print("removeAccessDustbin() called for dustbin ID: $dustbinId"); // Log method call

    TextEditingController cardIdController = TextEditingController();
    TextEditingController dustbinIdController =
        TextEditingController(text: dustbinId);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Access Remove Dustbin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Enter Card ID and Dustbin ID to remove access'),
            TextFormField(
              controller: cardIdController,
              decoration: InputDecoration(labelText: 'Card ID'),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: dustbinIdController,
              decoration: InputDecoration(labelText: 'Dustbin ID'),
              enabled: false, // Dustbin ID should not be editable
            ),
          ],
        ),
        actions: [
          // Cancel button to close the dialog
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          // Remove Access button to confirm removal
          TextButton(
            onPressed: () async {
              String cardId = cardIdController.text.trim();
              String dustbinId = dustbinIdController.text.trim();

              if (cardId.isEmpty) {
                print("Card ID cannot be empty");
                //Get.snackbar("Error", "Card ID cannot be empty");
                return;
              }

              print(
                  "🗑️ [DustbinPage] Attempting to Remove Access of dustbin: ID=$dustbinId for Card ID=$cardId");

              try {
                 await RestClient.removeAccessDB(
                    {"card_id": cardId, "dustbin_id": dustbinId});
                print("Dustbin Access removed successfully! For CardId:$cardId");
                //Get.snackbar("Success", "Dustbin Access removed successfully!",snackPosition: SnackPosition.TOP);
                Get.back();
              } catch (e) {
                print("Failed to remove access: $e");
                Get.snackbar("Error", "Failed to remove access: $e");
              }

              print("Access removed for dustbin: $dustbinId with Card ID: $cardId");
              Get.back();// Log removal
            },
            child: Text('Remove Access'),
          ),
        ],
      ),
    );
  }*/
  //-------------------------- new remove Access which show card list------------//
  void removeAccessDustbin(String dustbinId) async {
    List<AllAccessBlockListInObj> employeeList = [];
    TextEditingController dustbinIdController =
        TextEditingController(text: dustbinId);
    Map<String, bool> selectedEmployees = {};

    try {
      employeeList =
          await RestClient.getFetchDustbinListInObj({"dustbin_id": dustbinId});
      print("Fetched Employees: ${employeeList.length}");
    } catch (e) {
      print("Error fetching employees: $e");
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text('Manage Access for Dustbin ID: $dustbinId'),
            content: Container(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (employeeList.isEmpty) Text('No Employees Found'),
                  if (employeeList.isNotEmpty)
                    Container(
                      color: Colors.grey[300],
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text("Card_ID",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 3,
                              child: Text("Employee_Name",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          /*Expanded(flex: 3, child: Text("Department", style: TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(flex: 3, child: Text("Designation", style: TextStyle(fontWeight: FontWeight.bold))),*/
                          Expanded(
                              flex: 3,
                              child: Text("Dustbin_Id",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 2,
                              child: Text("Location",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 1,
                              child: Text("Select",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: employeeList.length,
                      itemBuilder: (context, index) {
                        final emp =
                            employeeList[index].dustbinAssignments ?? [];
                        return Column(
                          children: emp.map((log) {
                            selectedEmployees[log.cardId ?? "UNKNOWN"] =
                                selectedEmployees[log.cardId ?? "UNKNOWN"] ??
                                    false;
                            return Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: CheckboxListTile(
                                checkColor: Colors.black,
                                title: Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Text(log.cardId ?? "UNKNOWN")),
                                    Expanded(
                                        flex: 3,
                                        child: Text(log.empName ?? "UNKNOWN")),
                                    /*        Expanded(flex: 3, child: Text(log.department ?? "UNKNOWN")),
                                    Expanded(flex: 3, child: Text(log.designation ?? "UNKNOWN")),*/
                                    Expanded(
                                        flex: 3,
                                        child:
                                            Text(log.dustbinId ?? "UNKNOWN")),
                                    Expanded(
                                        flex: 2,
                                        child: Text(log.location ?? "UNKNOWN")),
                                  ],
                                ),
                                value:
                                    selectedEmployees[log.cardId ?? "UNKNOWN"],
                                onChanged: (bool? value) {
                                  setState(() {
                                    selectedEmployees[log.cardId ?? "UNKNOWN"] =
                                        value ?? false;
                                  });
                                },
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              // All buttons:

              //Close button:
              SizedBox(
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white70),
                  onPressed: () => Get.back(),
                  child: Text(
                    'Close',
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  ),
                ),
              ),
              // block All Access Button:
              SizedBox(
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white70),
                  onPressed: () async {
                    List<String> selectedCardIds = selectedEmployees.entries
                        .where((entry) => entry.value)
                        .map((entry) => entry.key)
                        .toList();

                    if (selectedCardIds.isNotEmpty) {
                      for (var cardId in selectedCardIds) {
                        try {
                          Map<String, dynamic> response =
                              await RestClient.removeAccessDB({
                            "card_id": cardId,
                            "dustbin_id": dustbinId,
                          });
                          print("Response for Card ID $cardId: ${response}");
                          Get.snackbar("Access Management", response["msg"],
                              snackPosition: SnackPosition.TOP);
                        } catch (e) {
                          print(
                              "Error removing access for Card ID $cardId: $e");
                        }
                      }
                    } else {
                      Get.snackbar("Access Management", "No Employee Selected",
                          snackPosition: SnackPosition.TOP);
                    }
                    Get.back();
                    //refresh the list Data
                    employeeList;
                  },
                  child: Text(
                    'Remove Access',
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //Method to Manage Access a dustbin:
  /* void manageAccessDustbin(String dustbinId) async {
    List<ExportDustbinListInObj> employeeList = [];
    TextEditingController dustbinIdController = TextEditingController(text: dustbinId);

    // Fetch employees related to the selected dustbinId
    try {
      employeeList = await RestClient.getDustbinWiseListInObj({"dustbin_id": dustbinId});
      print("Fetched Employees: ${employeeList.length}");
    } catch (e) {
      print("Error fetching employees: $e");
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Manage Access for Dustbin ID: $dustbinId'),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (employeeList.isEmpty)
                Text('No Employees Found'),
              if (employeeList.isNotEmpty)
              // Fixed Headers:
                Container(
                  color: Colors.grey[300],
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Row(
                    children: [

                      Expanded(
                        flex: 2,
                        child: Text(
                          "Card ID",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Employee Name",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Department",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Scan Time",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              //List of Data:
              Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: employeeList.length,
                    itemBuilder: (context, index) {
                      final emp = employeeList[index].scanLogs ?? [];
                      return Column(
                        children: emp.map((log) {
                          return Card(
                            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: ListTile(
                              title: Row(
                                children: [
                                  Expanded(flex: 2, child: Text(log.cardId ?? "UNKNOWN")),
                                  Expanded(flex: 3, child: Text(log.empName ?? "UNKNOWN")),
                                  Expanded(flex: 3, child: Text(log.department ?? "UNKNOWN")),
                                  Expanded(flex: 2, child: Text(log.scanTime ?? "UNKNOWN")),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                      },
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Close'),
          ),
          TextButton(
            onPressed: () {




              print("Block All Access Triggered");
              // Call your Block All API here
              Get.back();
            },
            child: Text('Block All Access'),
          ),
          TextButton(
            onPressed: () {
              print("Allow All Access Triggered");
              // Call your Allow All API here
              Get.back();
            },
            child: Text('Allow All Access'),
          ),
        ],
      ),
    );
  }*/

//-------------------------------------------//
  /*void manageAccessDustbin(String dustbinId) async {
    List<ExportDustbinListInObj> employeeList = [];
    TextEditingController dustbinIdController = TextEditingController(text: dustbinId);
    Map<String, bool> selectedEmployees = {};

    try {
      employeeList = await RestClient.getDustbinWiseListInObj({"dustbin_id": dustbinId});
      print("Fetched Employees: ${employeeList.length}");
    } catch (e) {
      print("Error fetching employees: $e");
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Manage Access for Dustbin ID: $dustbinId'),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (employeeList.isEmpty)
                Text('No Employees Found'),
              if (employeeList.isNotEmpty)
                Container(
                  color: Colors.grey[300],
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Row(
                    children: [

                      Expanded(flex: 2, child: Text("Card ID", style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 3, child: Text("Employee Name", style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 3, child: Text("Department", style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 2, child: Text("Scan Time", style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 1, child: Text("Select", style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: employeeList.length,
                  itemBuilder: (context, index) {
                    final emp = employeeList[index].scanLogs ?? [];
                    return Column(
                      children: emp.map((log) {
                        selectedEmployees[log.cardId ?? "UNKNOWN"] = false;
                        return Card(
                          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: CheckboxListTile(
                            title: Row(
                              children: [
                                Expanded(flex: 2, child: Text(log.cardId ?? "UNKNOWN")),
                                Expanded(flex: 3, child: Text(log.empName ?? "UNKNOWN")),
                                Expanded(flex: 3, child: Text(log.department ?? "UNKNOWN")),
                                Expanded(flex: 2, child: Text(log.scanTime ?? "UNKNOWN")),
                              ],
                            ),
                            value: selectedEmployees[log.cardId ?? "UNKNOWN"],
                            onChanged: (bool? value) {
                              selectedEmployees[log.cardId ?? "UNKNOWN"] = value ?? false;
                            },
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Close'),
          ),
          TextButton(
            onPressed: () async {
              List<String> selectedCardIds = selectedEmployees.entries
                  .where((entry) => entry.value)
                  .map((entry) => entry.key)
                  .toList();

              if (selectedCardIds.isNotEmpty) {
                for (var cardId in selectedCardIds) {
                  try {
                    Map<String, dynamic> response = await RestClient.getManageAccessListInObj({
                      "card_id":cardId,
                      "action": "block",
                    });
                    print("Response for Card ID $cardId: ${response["msg"]}");
                    Get.snackbar("Access Management", response["msg"], snackPosition: SnackPosition.BOTTOM);
                  } catch (e) {
                    print("Error blocking access for Card ID $cardId: $e");
                  }
                }
              } else {
                Get.snackbar("Access Management", "No Employee Selected", snackPosition: SnackPosition.BOTTOM);
              }
              Get.back();
            },
            child: Text('Block All Access'),
          ),
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Allow All Access'),
          ),
        ],
      ),
    );
  }*/
  //--------------------------------------------//
  void manageAccessDustbin(String dustbinId) async {
    List<AllAccessBlockListInObj> employeeList = [];
    TextEditingController dustbinIdController =
        TextEditingController(text: dustbinId);
    Map<String, bool> selectedEmployees = {};

    try {
      employeeList =
          await RestClient.getFetchDustbinListInObj({"dustbin_id": dustbinId});
      print("Fetched Employees: ${employeeList.length}");
    } catch (e) {
      print("Error fetching employees: $e");
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text('Manage Access for Dustbin ID: $dustbinId'),
            content: Container(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (employeeList.isEmpty) Text('No Employees Found'),
                  if (employeeList.isNotEmpty)
                    Container(
                      color: Colors.grey[300],
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text("Card_ID",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 3,
                              child: Text("Employee_Name",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 3,
                              child: Text("Department",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 3,
                              child: Text("Designation",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 3,
                              child: Text("Dustbin_Id",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 2,
                              child: Text("Location",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 1,
                              child: Text("Select",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: employeeList.length,
                      itemBuilder: (context, index) {
                        final emp =
                            employeeList[index].dustbinAssignments ?? [];
                        return Column(
                          children: emp.map((log) {
                            selectedEmployees[log.cardId ?? "UNKNOWN"] =
                                selectedEmployees[log.cardId ?? "UNKNOWN"] ??
                                    false;
                            return Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: CheckboxListTile(
                                checkColor: Colors.black,
                                title: Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Text(log.cardId ?? "UNKNOWN")),
                                    Expanded(
                                        flex: 3,
                                        child: Text(log.empName ?? "UNKNOWN")),
                                    Expanded(
                                        flex: 3,
                                        child:
                                            Text(log.department ?? "UNKNOWN")),
                                    Expanded(
                                        flex: 3,
                                        child:
                                            Text(log.designation ?? "UNKNOWN")),
                                    Expanded(
                                        flex: 3,
                                        child:
                                            Text(log.dustbinId ?? "UNKNOWN")),
                                    Expanded(
                                        flex: 2,
                                        child: Text(log.location ?? "UNKNOWN")),
                                  ],
                                ),
                                value:
                                    selectedEmployees[log.cardId ?? "UNKNOWN"],
                                onChanged: (bool? value) {
                                  setState(() {
                                    selectedEmployees[log.cardId ?? "UNKNOWN"] =
                                        value ?? false;
                                  });
                                },
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              // All buttons:

              //Close button:
              SizedBox(
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white70),
                  onPressed: () => Get.back(),
                  child: Text(
                    'Close',
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  ),
                ),
              ),
              // block All Access Button:
              SizedBox(
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white70),
                  onPressed: () async {
                    List<String> selectedCardIds = selectedEmployees.entries
                        .where((entry) => entry.value)
                        .map((entry) => entry.key)
                        .toList();

                    if (selectedCardIds.isNotEmpty) {
                      for (var cardId in selectedCardIds) {
                        try {
                          Map<String, dynamic> response =
                              await RestClient.getManageAccessListInObj({
                            "card_id": cardId,
                            "action": "block",
                          });
                          print(
                              "Response for Card ID $cardId: ${response["msg"]}");
                          Get.snackbar("Access Management", response["msg"],
                              snackPosition: SnackPosition.TOP);
                        } catch (e) {
                          print(
                              "Error blocking access for Card ID $cardId: $e");
                        }
                      }
                    } else {
                      Get.snackbar("Access Management", "No Employee Selected",
                          snackPosition: SnackPosition.TOP);
                    }
                    Get.back();
                    //refresh the list Data
                    employeeList;
                  },
                  child: Text(
                    'Block All Access',
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  ),
                ),
              ),
              // Allow All Access Button:
              SizedBox(
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white70),
                  onPressed: () async {
                    List<String> selectedCardIds = selectedEmployees.entries
                        .where((entry) => entry.value)
                        .map((entry) => entry.key)
                        .toList();

                    if (selectedCardIds.isNotEmpty) {
                      for (var cardId in selectedCardIds) {
                        try {
                          Map<String, dynamic> response =
                              await RestClient.getManageAccessListInObj({
                            "card_id": cardId,
                            "action": "allow",
                          });
                          print(
                              "Response for Card ID $cardId: ${response["msg"]}");
                          Get.snackbar("Access Management", response["msg"],
                              snackPosition: SnackPosition.TOP);
                        } catch (e) {
                          print(
                              "Error allowing all  access for Card ID $cardId: $e");
                        }
                      }
                    } else {
                      Get.snackbar("Access Management", "No Employee Selected",
                          snackPosition: SnackPosition.TOP);
                    }
                    Get.back();
                    //refresh the list Data
                    employeeList;
                  },
                  child: Text(
                    'Allow All Access',
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Filter dustbins based on search query
  List<DustBinListInArray> getFilteredDustbins() {
    if (searchQuery.isEmpty) {
      return dustbinListInObj;
    } else {
      return dustbinListInObj
          .where((dustbin) =>
              dustbin.dustbinId!
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) ||
              dustbin.location!
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dustbins"),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          // App Bar with Search and Add Button
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            floating: true,
            expandedHeight: 20.0,
            flexibleSpace: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                children: [
                  // Search Bar
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 36.0,
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Colors.black),
                          hintText: 'Search Dustbin by ID or Location...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey[300],
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value.trim();
                            print("Search query updated: $searchQuery");
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  // Add New Dustbin Button
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 36.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                        ),
                        onPressed: () {
                          // Add new dustbin functionality
                          addNewDustbin();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add, color: Colors.white),
                            SizedBox(width: 8),
                            Text("Add New",
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Display Total Dustbins
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Total Dustbins: ${dustbinListInObj.length}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // Fixed header for dustbin table
          SliverPersistentHeader(
            pinned: true,
            delegate: _HeaderDelegate(dustbins: dustbinListInObj),
          ),

          // List of Dustbins
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final filteredDustbins = getFilteredDustbins();
                final  dustbin = filteredDustbins[index];
                print("Rendering dustbin: ${dustbin.dustbinId}");

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        // Display Dustbin ID
                        Expanded(
                          flex: 2,
                          child: Text(
                            dustbin.dustbinId.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        // Display Location
                        Expanded(
                          flex: 2,
                          child: Text(
                            dustbin.location.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        // Three-dot Menu for Actions
                        Expanded(
                          flex: 1,
                          child: PopupMenuButton<String>(
                            icon: Icon(Icons.more_vert, color: Colors.black),
                            onSelected: (value) {
                              if (value == 'edit') {
                                print(
                                    "Edit option selected for dustbin: ${dustbin.dustbinId}");
                                // Call the editDustbin() function with the selected dustbin details
                                editDustbin({
                                  "id": dustbin.dustbinId.toString(),
                                  "location": dustbin.location.toString(),
                                });
                              } else if (value == 'manage Access') {
                                print(
                                    "Access Manage Access for dustbin: ${dustbin.dustbinId}");
                                manageAccessDustbin(
                                    dustbin.dustbinId.toString());
                                // Handle remove access action
                              } else if (value == 'remove Access') {
                                print(
                                    "Access removed for dustbin: ${dustbin.dustbinId}");
                                // Handle remove access action
                                removeAccessDustbin(
                                    dustbin.dustbinId.toString());
                              } else if (value == 'grant Access') {
                                print(
                                    "Grant Access for dustbin: ${dustbin.dustbinId}");
                                // Handle remove access action

                                grantAccessDustbin(
                                    dustbin.dustbinId.toString());
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'manage Access',
                                child: Text('Manage Access'),
                              ),
                              PopupMenuItem(
                                value: 'edit',
                                child: Text('Edit Details'),
                              ),
                              PopupMenuItem(
                                value: 'grant Access',
                                child: Text('Grant Access'),
                              ),
                              PopupMenuItem(
                                value: 'remove Access',
                                child: Text('Remove Access'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: getFilteredDustbins().length,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              color: Colors.white60,
              padding: EdgeInsets.all(4.0),
              child: Center(
                child: Text(
                  '© 2023 DPROFIZ.PVT.LTD. All rights reserved.',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// SliverPersistentHeader Delegate for Fixed Header

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final List<DustBinListInArray> dustbins;

  _HeaderDelegate({required this.dustbins});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      child: Column(
        children: [
          // Header Row
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text('Dustbin ID',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(
                  flex: 2,
                  child: Text('Location',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(
                  flex: 1,
                  child: Text('Action',
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
          // List of Dustbins
          /* Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: dustbins.length,
              itemBuilder: (context, index) {
                final dustbin = dustbins[index];
                return Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(dustbin.dustbinId.toString(),
                          style: TextStyle(fontSize: 14)),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(dustbin.location.toString(),
                          style: TextStyle(fontSize: 14)),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(Icons.more_vert, color: Colors.black),
                        onPressed: () {
                          // Handle actions (edit, delete, etc.)
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),*/
        ],
      ),
    );
  }

  @override
  double get maxExtent => 36.0; // Adjust height as needed

  @override
  double get minExtent => 36.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

/*
//complete run code
import 'dart:developer';
import 'package:Deprofiz/models/api_models/dustbin_list_in_array.dart';
import 'package:Deprofiz/network%20manager/rest_client.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../models/api_models/user_list_in_Array_emp.dart';
import '../../models/api_models/user_list_in_obj_emp.dart';

class DustbinPage extends StatefulWidget {
  const DustbinPage({super.key});

  @override
  State<DustbinPage> createState() => _DustbinPageState();
}

class _DustbinPageState extends State<DustbinPage> {
  bool isLoading = true;
  List<DustBinListInArray> dustbinListInObj = [];
  String errorMessage = "";

   userList() {
    print("➡️ [START] userList: Fetching employee data...");

    RestClient.getDustbinListInArray().then((value) {
      log("✅ API Response: $value");
      print("✅ API Response: $value");

      // Step 1: Check if the response is null or empty
      if (value == null) {
        log("⚠️ Warning: API returned null or an empty list.");
        print("⚠️ Warning: API returned null or an empty list.");

        setState(() {
          errorMessage = "No data found.";
          isLoading = false;
        });
      } else {
        // Step 2: Log the number of items returned
        log("📊 API returned data: ${value.length} items");

        // Step 3: Update the state with the fetched data
        setState(() {
          dustbinListInObj = value ?? []; // Assign the list of employees
          isLoading = false;
        });
      }
    }).catchError((error) {
      // Step 4: Log any errors encountered
      log("❌ Error fetching API data: $error");
      setState(() {
        errorMessage = "Failed to load data. Please check your network or try again.";
        isLoading = false;
      });
    }).whenComplete(() {
      // Step 5: Log the completion of the process
      print("➡️ [END] userList: Execution completed.");
    });
  }




  void initState() {
    super.initState();
    userList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
          child: CircularProgressIndicator()) // Show loading indicator
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage)) // Show error message
          : Column(
        children: [
          // Fixed Headers
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.grey[300],
            child: Row(
              children: const [
                Expanded(
                    flex: 2,
                    child: Text('Dustbin ID',
                        style:
                        TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    flex: 3,
                    child: Text('Location',
                        style:
                        TextStyle(fontWeight: FontWeight.bold))),

                Expanded(
                    flex: 2,
                    child: Text('Action',
                        style:
                        TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ),

          // Data in List
          Expanded(
            child: ListView.builder(
              itemCount: dustbinListInObj.length ?? 0,
              itemBuilder: (context, index) {
                var data =  dustbinListInObj[index];
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child: Text(data.dustbinId ?? "unknown")),
                      Expanded(flex: 3, child: Text(data.location ?? "Unknown")),
                      Expanded(
                        flex: 2,
                        child: PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert, color: Colors.black),
                          onSelected: (value) {
                            if (value == 'edit') {
                              log("Edit option selected for: ${data.location}");
                            } else if (value == 'delete') {
                              log("Delete option selected for: ${data.dustbinId}");
                            }
                          },
                          itemBuilder: (context) => const [
                            PopupMenuItem(value: 'edit', child: Text('Edit Details')),
                            PopupMenuItem(value: 'manage', child: Text('Manage Access')),
                            PopupMenuItem(value: 'delete', child: Text('Delete')),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )

        ],
      ),
    );
  }
}
*/
