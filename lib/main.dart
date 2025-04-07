// main.dart

import 'package:flutter/material.dart';

void main() {
  runApp(const RestaurantMenuApp());
}

class RestaurantMenuApp extends StatelessWidget {
  const RestaurantMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu du Restaurant',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MenuScreen(),
    );
  }
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // Structure de données pour représenter les plats par catégorie
  final Map<String, List<Dish>> _menu = {
    'Entrées': [
      Dish(name: 'Salade César', description: 'Laitue, poulet, croûtons, parmesan', price: 8.50),
      Dish(name: 'Soupe à l\'oignon', description: 'Gratinée au fromage', price: 7.00),
      Dish(name: 'Assiette de charcuterie', description: 'Saucisson, jambon cru, pâté', price: 12.00),
    ],
    'Plats': [
      Dish(name: 'Pâtes au Pesto', description: 'Mélange italien de basilic et de pignon de pain', price: 14.00),
      Dish(name: 'Boeuf Bourguignon', description: 'Viande de boeuf mijotée au vin rouge', price: 15.50),
      Dish(name: 'Filet de saumon grillé', description: 'Sauce à l\'aneth', price: 16.00),
      Dish(name: 'Risotto aux champignons', description: 'Crémé et parfumé', price: 14.00),
      Dish(name: 'Magret de canard', description: 'Sauce au miel et figues', price: 18.00),
    ],
    'Desserts': [
      Dish(name: 'Crème brûlée', description: 'Caramélisée à la cassonade', price: 6.00),
      Dish(name: 'Tarte aux pommes', description: 'Faite maison', price: 5.50),
      Dish(name: 'Mousse au chocolat', description: 'Noir intense', price: 6.50),
      Dish(name: 'Île flottante', description: 'Crème anglaise et caramel', price: 7.00),
    ],
  };

  // Liste des catégories pour l'affichage horizontal
  final List<String> _categories = ['Entrées', 'Plats', 'Desserts'];

  // Index de la catégorie sélectionnée, par défaut la première
  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu du Restaurant'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Zone de catégories défilable horizontalement
          SizedBox(
            height: 60.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ChoiceChip(
                    label: Text(_categories[index]),
                    selected: _selectedCategoryIndex == index,
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedCategoryIndex = selected ? index : _selectedCategoryIndex;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          // Zone principale contenant la liste des plats de la catégorie sélectionnée
          Expanded(
            child: ListView.builder(
              itemCount: _menu[_categories[_selectedCategoryIndex]]!.length,
              itemBuilder: (BuildContext context, int index) {
                final dish = _menu[_categories[_selectedCategoryIndex]]![index];
                // Utilisation d'un widget Card pour afficher chaque plat
                return DishCard(dish: dish);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Modèle de données pour représenter un plat
class Dish {
  final String name;
  final String description;
  final double price;

  Dish({required this.name, required this.description, required this.price});
}

// Widget réutilisable pour afficher les informations d'un plat dans une carte
class DishCard extends StatelessWidget {
  final Dish dish;

  const DishCard({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Nom du plat en gras
            Text(
              dish.name,
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            // Description du plat
            Text(
              dish.description,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 12.0),
            // Prix du plat
            Text(
              '${dish.price.toStringAsFixed(2)} €',
              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}