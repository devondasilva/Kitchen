import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'meal.dart';
import 'login.dart';
import 'meal.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchText = '';
  List<Meal> meals = [];
  List<Meal> filteredMeals = [];
  bool isLoading = true;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchMeals();
  }

  Future<void> _fetchMeals() async {
    setState(() {
      isLoading = true;
    });
    try {
      final url = Uri.parse(
          'https://www.themealdb.com/api/json/v1/1/search.php?s=${Uri.encodeComponent(searchText)}');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final mealsData = jsonData['meals'] as List?;

        setState(() {
          meals = mealsData?.map((meal) => Meal.fromJson(meal)).toList() ?? [];
          filteredMeals = meals;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load meals');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching meals: $e');
    }
  }

  List<Meal> _filterMeals(String searchText) {
    return meals.where((meal) =>
        meal.strMeal.toLowerCase().contains(searchText.toLowerCase())).toList();
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.dehaze),
            const SizedBox(width: 20),
            Image.asset(
              'images/Logo.png',
              height: 40,
              errorBuilder: (context, object, stackTrace) =>
              const Icon(Icons.error),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        actions: [
          const Icon(Icons.search, color: Colors.black),
          const SizedBox(width: 20),
          const Icon(Icons.email_outlined, color: Colors.black),
          const SizedBox(width: 20),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            icon: const Icon(Icons.login),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFF7ED),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                          filteredMeals = _filterMeals(searchText);
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Rechercher un repas...',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF000000)),
                        ),
                        prefixIcon: Icon(Icons.search),
                      ),
                      style: const TextStyle(color: Colors.black),
                      cursorColor: Colors.black,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 200,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          'images/food${index + 1}.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (context, object, stackTrace) =>
                          const Icon(Icons.error),
                        );
                      },
                      onPageChanged: (int index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      final meal = filteredMeals[index];
                      return MealCard(meal: meal);
                    },
                    childCount: filteredMeals.length,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoris',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_list),
            label: 'Filtre',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class MealCard extends StatelessWidget {
  final Meal meal;

  const MealCard({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MealDetailsPage(meal: meal),
          ),
        );
      },
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
              child: Image.network(
                meal.strMealThumb,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, object, stackTrace) =>
                const Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "images/Logo.png",
                        height: 30,
                        errorBuilder: (context, object, stackTrace) =>
                        const Icon(Icons.error),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          meal.strMeal,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.category,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text('Catégorie : ${meal.strCategory}',
                          style: const TextStyle(color: Colors.grey)),
                      const SizedBox(width: 16),
                      const Icon(Icons.location_on,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text('Région : ${meal.strArea}',
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}