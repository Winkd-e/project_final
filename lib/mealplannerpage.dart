import 'package:flutter/material.dart';
import 'dashboard.dart'; // Import the DashboardPage
import 'inventorypage.dart'; // Import the InventoryPage
import 'grocerylistpage.dart'; // Import the GroceryListPage
import 'package:intl/intl.dart'; // Import the intl package for date formatting

class MealPlannerPage extends StatefulWidget {
  const MealPlannerPage({super.key});

  @override
  _MealPlannerPageState createState() => _MealPlannerPageState();
}

class _MealPlannerPageState extends State<MealPlannerPage> {
  DateTime startDate = DateTime.now(); // Set initial start date to today
  String? selectedMeal;
  String? selectedDay;

  // List to store the saved dishes
  List<Map<String, dynamic>> dishes = [];

  // Track if a date and meal type have been selected
  bool isDateSelected = false;

  void updateDateRange(int days) {
    setState(() {
      startDate = startDate.add(Duration(days: days));
    });
  }

  List<Map<String, String>> getDatesInRange() {
    List<Map<String, String>> dates = [];
    for (int i = 0; i < 7; i++) {
      DateTime date = startDate.add(Duration(days: i));
      dates.add({
        'day': DateFormat('E').format(date), // Day of the week
        'date': DateFormat('d').format(date), // Day of the month
      });
    }
    return dates;
  }

  void _showAddDishDialog() {
  TextEditingController dishNameController = TextEditingController();
  String? selectedDishType; // Variable to store the selected dish type

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Center(
          child: Text(
  'Add Dish',
  style: TextStyle(
    color: Color(0xFF0B553E),
    fontSize: 20,
    fontWeight: FontWeight.bold, // Set font weight to bold
  ),
),

        ),
        content: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
  'Dish Name',
  style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold, // Set font weight to bold
  ),
),

              TextField(
                controller: dishNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter dish name',
                ),
              ),
              const SizedBox(height: 10), // Add space between text fields
              const Text(
  'Dish Type',
  style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold, // Set font weight to bold
  ),
),

              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Select dish type',
                ),
                value: selectedDishType,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDishType = newValue!;
                  });
                },
                items: const [
                  DropdownMenuItem<String>(
                    value: 'Main Dish',
                    child: Text('Main Dish'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Sub Dish',
                    child: Text('Sub Dish'),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              child: TextButton(
                onPressed: () {
                  if (dishNameController.text.isNotEmpty &&
                      selectedDishType != null &&
                      selectedDay != null &&
                      selectedMeal != null) {
                    setState(() {
                      dishes.add({
                        'name': dishNameController.text,
                        'type': selectedDishType, // Store selected dish type
                        'meal': selectedMeal, // Store meal type
                        'date': selectedDay,
                      });
                    });
                    Navigator.of(context).pop();
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF0B553E),
                  padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    String formattedStartDate = DateFormat('MMM d').format(startDate);
    String formattedEndDate = DateFormat('MMM d').format(startDate.add(const Duration(days: 6))); // Show the range of a week

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meal Planner',
          style: TextStyle(
            color: Color(0xFF0B553E),
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false, // Disable the back button
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF0B553E)),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFFF3F4F6),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left, size: 32, color: Color(0xFF0B553E)),
                        onPressed: () => updateDateRange(-7),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '$formattedStartDate - $formattedEndDate',
                        style: const TextStyle(fontSize: 24, color: Color(0xFF0B553E)),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.chevron_right, size: 32, color: Color(0xFF0B553E)),
                        onPressed: () => updateDateRange(7),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 1),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: getDatesInRange().map((entry) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDay = '${entry['day']}, ${entry['date']}';
                            isDateSelected = true; // Set date selected flag
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: selectedDay == '${entry['day']}, ${entry['date']}' ? Colors.green : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                entry['day']!,
                                style: const TextStyle(color: Color(0xFF0B553E)),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                entry['date']!,
                                style: const TextStyle(color: Color(0xFF0B553E), fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ['Breakfast', 'Lunch', 'Dinner', 'Snack'].map((meal) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedMeal == meal ? Colors.green : Colors.green, // Keep the same border color
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                        color: selectedMeal == meal ? Colors.green : Colors.transparent, // Use solid green without opacity
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            selectedMeal = meal;
                          });
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          meal,
                          style: TextStyle(
                            color: selectedMeal == meal ? Colors.white : const Color(0xFF0B553E), // Change text color to white if selected
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
               Expanded(
  child: Builder(
    builder: (context) {
      var filteredDishes = dishes.where((dish) => dish['meal'] == selectedMeal && dish['date'] == selectedDay).toList();
      if (filteredDishes.isEmpty) {
        return const Center(
          child: Text(
            'No meals to show',
            style: TextStyle(fontSize: 18, color: Color (0xFF0B553E)),
          ),
        );
      }
      return ListView.builder(
        itemCount: filteredDishes.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(8.0), // Add some spacing around the container
            width: 150, // Set the width for the square container
            height: 180, // Adjusted height to fit the add button and delete button row
            decoration: BoxDecoration(
              color: Colors.white, // Background color of the container
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // Changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                // Top green section for name, meal type, and dish type
                Container(
                  color: const Color(0xFF0B553E), // Green color
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        filteredDishes[index]['name'],
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4), // Space between name and meal type
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            filteredDishes[index]['meal'], // Meal type
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Text(
                            filteredDishes[index]['type'], // Dish type
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Middle black section for item, quantity, and unit
                Container(
                  color: Colors.black, // Black color
                  padding: const EdgeInsets.all(8.0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '             Item', // Item label
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Text(
                        'Quantity', // Quantity label
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Text(
                        'Unit                 ', // Unit label
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                // Bottom white section for the add and delete buttons
                Container(
  color: Colors.white, // White background
  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // Add Ingredient Button
      Row(
        children: [
          Container(
            width: 28.0, // Set a smaller width
            height: 28.0, // Set a smaller height
            decoration: const BoxDecoration(
              color: Color(0xFF0B553E), // Green background color
              shape: BoxShape.circle, // Circular shape
            ),
            child: IconButton(
              padding: EdgeInsets.zero, // Remove default padding
              icon: const Icon(Icons.add, color: Colors.white, size: 20.0), // Adjust icon size to fit smaller button
              onPressed: () {
                // Add ingredient functionality here
              },
            ),
          ),
          const SizedBox(width: 4), // Space between icon and text
          const Text(
            'Add Ingredient/s',
            style: TextStyle(color: Colors.black, fontSize: 12),
          ),
        ],
      ),
      // Delete Button
      IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () {
          setState(() {
            dishes.removeAt(index); // Remove the dish from the list
          });
        },
      ),
    ],
  ),
)

              ],
            ),
          );
        },
      );
    },
  ),
)






              ],
            ),
            Positioned(
  left: 0,
  right: 0,
  bottom: 16, // Adjust the distance from the bottom
  child: Center(
    child: ElevatedButton(
      onPressed: isDateSelected && selectedMeal != null ? _showAddDishDialog : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0B553E),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      ),
      child: const Text(
        'Add a New Dish',
        style: TextStyle(
          fontSize: 18,
          color: Colors.white, // Change text color to white
        ),
      ),
    ),
  ),
),

          ],
        ),
      ),
      // Add the BottomNavigationBar
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                // Refresh DashboardPage for Home
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DashboardPage()),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/home.png', height: 24), // Your image path
                  const Text('Home', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to Inventory Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InventoryPage()),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/inventory.png',
                      height: 24), // Placeholder
                  const Text('Inventory', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to Grocery List Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GroceryListPage()),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/grocery_list.png',
                      height: 24), // Placeholder
                  const Text('Grocery List', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to Meal Planner Page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MealPlannerPage()),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/meal_planner.png',
                      height: 24), // Placeholder
                  const Text('Meal Plan', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
