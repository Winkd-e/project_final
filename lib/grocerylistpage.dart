import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firstapp/dashboard.dart';
import 'package:firstapp/inventorypage.dart';
import 'package:firstapp/mealplannerpage.dart';

class GroceryListPage extends StatefulWidget {
  const GroceryListPage({super.key});

  @override
  _GroceryListPageState createState() => _GroceryListPageState();
}

class _GroceryListPageState extends State<GroceryListPage> {
  List<Map<String, String>> groceryLists = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text(
          'Grocery Checklist',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF0B553E),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color(0xFF0B553E),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF0B553E)),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: groceryLists.isEmpty
                  ? const Center(
                      child: Text(
                        'No list to show',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF0B553E),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: groceryLists.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0B553E),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    groceryLists[index]['name']!,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    groceryLists[index]['date']!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 100,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Container(
                                    height: 30,
                                    color: Colors.black,
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            '          Item',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 60),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            'Quantity',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            'Unit',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 38,
                                                height: 38,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFF0B553E),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            GroceryListDetailPage(
                                                          listName:
                                                              groceryLists[
                                                                      index]
                                                                  ['name']!,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              const Text(
                                                'Add Ingredients',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xFF0B553E),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.edit,
                                                  size: 20,
                                                ),
                                                onPressed: () {},
                                              ),
                                              const SizedBox(width: 1),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.delete,
                                                  size: 20,
                                                ),
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Confirm Deletion'),
                                                        content: const Text(
                                                            'Are you sure you want to delete this item?'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                'Cancel'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                groceryLists
                                                                    .removeAt(
                                                                        index);
                                                              });
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                'Delete'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showAddListDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0B553E),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('Add a New List'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DashboardPage()),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/home.png', height: 24),
                  const Text('Home', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const InventoryPage()),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/inventory.png', height: 24),
                  const Text('Inventory', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GroceryListPage()),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/grocery_list.png', height: 24),
                  const Text('Grocery List', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MealPlannerPage()),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/meal_planner.png', height: 24),
                  const Text('Meal Plan', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddListDialog(BuildContext context) {
    final TextEditingController listNameController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            width: 450,
            height: 400,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Add New List',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  'List Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: listNameController,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Date',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Select Date',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.arrow_drop_down),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            selectedDate = pickedDate;
                            dateController.text =
                                DateFormat('MMM d, yyyy').format(selectedDate);
                          });
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (listNameController.text.isNotEmpty) {
                      setState(() {
                        groceryLists.add({
                          'name': listNameController.text,
                          'date': dateController.text,
                        });
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B553E),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 12),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: const Text('Add list'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Grocery List Detail Page

class GroceryListDetailPage extends StatelessWidget {
  final String listName;

  const GroceryListDetailPage({super.key, required this.listName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$listName Grocery Checklist',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF0B553E),
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color(0xFF0B553E),
        ),
      ),
      body: const Center(
        child: Text(
          'No items to show',
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF008D23),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddItemPage()),
          );
        },
        backgroundColor: const Color(0xFF0B553E),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DashboardPage()),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/home.png', height: 24),
                  const Text('Home', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const InventoryPage()),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/inventory.png', height: 24),
                  const Text('Inventory', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const GroceryListPage()),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/grocery_list.png', height: 24),
                  const Text('Grocery List', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MealPlannerPage()),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/meal_planner.png', height: 24),
                  const Text('Meal Planner', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// New class for the Add Item Page

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

String? _selectedUnit;
String? _selectedCategory;

class _AddItemPageState extends State<AddItemPage> {
  String _selectedOption = 'search';
  List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6'
  ];
  String _searchQuery = '';
  final TextEditingController _expDateController = TextEditingController();
  final Map<String, int> _savedItems = {};
  int _quantity = 1;

  @override
  void dispose() {
    _expDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: 260,
          alignment: Alignment.center,
          child: const Text(
            'Add Items',
            style: TextStyle(
              color: Color(0xFF0B553E),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _oblongButton('Text Search', 150, 30, () {
                    setState(() {
                      _selectedOption = 'search';
                    });
                  }, _selectedOption == 'search'),
                  const SizedBox(width: 10),
                  _oblongButton('Manual', 150, 30, () {
                    setState(() {
                      _selectedOption = 'manual';
                    });
                  }, _selectedOption == 'manual'),
                ],
              ),
              const SizedBox(height: 10),
              _selectedOption == 'search'
                  ? _buildSearchContent()
                  : _buildManualContent(),
              const SizedBox(height: 5),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _oblongButton(String label, double width, double height,
      VoidCallback onPressed, bool isSelected) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(height / 2),
          ),
          padding: EdgeInsets.zero,
          backgroundColor: isSelected ? const Color(0xFF0B553E) : Colors.white,
        ),
        onPressed: onPressed,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? Colors.white : const Color(0xFF0B553E),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 390,
          height: 45,
          child: TextField(
            onChanged: (query) {
              setState(() {
                _searchQuery = query;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              hintText: 'Search for an item',
              prefixIcon: const Icon(Icons.search),
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            style: const TextStyle(color: Colors.black),
          ),
        ),
        const SizedBox(height: 20),
        _buildRectangleBoxes(),
      ],
    );
  }

  Widget _buildManualContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextFieldLabel('Item Name'),
        const SizedBox(height: 10),
        _buildTextField('Enter item name'),
        const SizedBox(height: 10),
        const SizedBox(height: 1),
        _buildTextFieldLabel(
            'Quantity                              Weight/Volume Unit'),
        const SizedBox(height: 10),
        _buildQuantityControl(),
        const SizedBox(height: 20),
        _buildTextFieldLabel1('Category'),
        const SizedBox(height: 10),
      ],
    );
  }

  String? _selectedCategory;
  Widget _buildTextFieldLabel1(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(height: 15),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
          ),
          hint: const Text('Select category'),
          value: _selectedCategory,
          items: <String>['vegetable', 'fruits', 'meat'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedCategory = newValue;
            });
          },
        ),
      ],
    );
  }

  Widget _buildTextField1(String hint) {
    return SizedBox(
      height: 70.0,
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hint,
        ),
      ),
    );
  }

  Widget _buildTextFieldLabel(String label) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Text(
        label,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildTextField(String hint) {
    return SizedBox(
      height: 70.0,
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hint,
        ),
      ),
    );
  }

  Widget _buildQuantityControl() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Minus button
        Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF008D23),
          ),
          child: IconButton(
            icon: const Icon(Icons.remove, color: Colors.white),
            padding: EdgeInsets.zero,
            onPressed: () {
              setState(() {
                if (_quantity > 1) {
                  _quantity--;
                }
              });
            },
          ),
        ),
        // Quantity display
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: Text(
            '$_quantity',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        // Add button
        Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF008D23),
          ),
          child: IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            padding: EdgeInsets.zero,
            onPressed: () {
              setState(() {
                _quantity++;
              });
            },
          ),
        ),
        // Weight/Volume Unit Dropdown
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: 200,
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
                hint: const Text('Select unit'),
                value: _selectedUnit,
                items: <String>['pieces', 'kg', 'grams'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedUnit = newValue;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRectangleBoxes() {
    List<String> filteredItems = _searchQuery.isEmpty
        ? items
        : items
            .where((item) =>
                item.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();

    if (filteredItems.isEmpty) {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        alignment: Alignment.center,
        child: const Text(
          'No items found',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return Column(
      children: filteredItems.map((item) => _buildRectangleBox(item)).toList(),
    );
  }

  Widget _buildRectangleBox(String text) {
    bool isSaved = _savedItems.containsKey(text);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSaved) {
            _savedItems.remove(text);
          } else {
            _showEditQuantityDialog(text);
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: 80,
        decoration: BoxDecoration(
          color: isSaved ? Colors.green[100] : Colors.white,
          border: Border.all(color: const Color(0xFF0B553E)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildItemDetail(text),
            _buildItemDetail('Storage'),
            _buildItemDetail('Quantity: ${_savedItems[text] ?? 1}'),
            _buildItemDetail('Expiry Date'),
          ],
        ),
      ),
    );
  }

  Widget _buildItemDetail(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, color: Color(0xFF0B553E)),
    );
  }

  Widget _buildSaveButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                content: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Are you sure you want to add these ingredients to the grocery checklist?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                actionsPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xFF0B553E)),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'No',
                            style: TextStyle(color: Color(0xFF0B553E)),
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0B553E),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextButton(
                          onPressed: () {
                            print("Saved items: $_savedItems");
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Yes',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0B553E),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 130),
        ),
        child: const Text(
          'Save item',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _expDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  void _showEditQuantityDialog(String itemName) {
    int newQuantity = _quantity;
    String newUnit = '';
    TextEditingController dateAddedController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Edit Quantity')),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Number:',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 60,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                newQuantity = int.tryParse(value) ?? 1;
                              },
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: newQuantity.toString(),
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Weight/Volume unit:',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 60,
                            child: TextField(
                              onChanged: (value) {
                                newUnit = value;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'e.g., kg, L',
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Date Added:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 60.0,
                      child: TextField(
                        controller: dateAddedController,
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            setState(() {
                              dateAddedController.text = formattedDate;
                            });
                          }
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Select date',
                          suffixIcon: Icon(Icons.calendar_today),
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 150,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        setState(() {
                          _quantity = newQuantity;

                          _savedItems[itemName] = newQuantity;
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
