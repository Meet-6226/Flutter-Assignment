import 'package:flutter/material.dart';
import 'data/food_data.dart';
import 'models/order.dart';
import 'models/user_profile.dart';
import 'pages/dashboard_page.dart';
import 'pages/offers_page.dart';
import 'pages/orders_page.dart';
import 'pages/account_page.dart';
import 'widgets/sidebar.dart';

void main() {
  runApp(const MyApp());
}

// ======================================================
// MAIN APP ROOT WIDGET WITH CENTRALIZED THEME
// ======================================================
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleDarkMode(bool isDark) {
    setState(() => _isDarkMode = isDark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FooddySpot',
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF8F5FF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: Colors.deepPurple,
          secondary: const Color(0xFFEDE9FE),
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFF0F0C1B),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1B2E),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: DashboardScreen(
        isDarkMode: _isDarkMode,
        onDarkModeChanged: _toggleDarkMode,
      ),
    );
  }
}

// ======================================================
// RESPONSIVE SCREEN SCAFFOLD
// ======================================================
class DashboardScreen extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onDarkModeChanged;

  const DashboardScreen({
    super.key,
    this.isDarkMode = false,
    required this.onDarkModeChanged,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  late UserProfile _userProfile;
  final List<OrderModel> _dynamicOrders = [];

  @override
  void initState() {
    super.initState();
    _userProfile = FoodData.defaultProfile;
  }

  void _onPageSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  void _handleNewOrder(String foodName, int qty, double total) {
    setState(() {
      _dynamicOrders.insert(
        0,
        OrderModel(
          id: '#ORD-${1000 + _dynamicOrders.length + FoodData.orders.length + 1}',
          customerName: _userProfile.name,
          items: [
            OrderItem(foodName: foodName, quantity: qty, price: total / qty),
          ],
          totalPrice: total,
          dateTime: 'Just Now',
          status: OrderStatus.preparing,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final bool isMobile = screenWidth < 600;
    final bool isTablet = screenWidth >= 600 && screenWidth < 1024;
    final bool isDesktop = screenWidth >= 1024;

    final pages = [
      DashboardPage(
        profile: _userProfile,
        onProfileTap: () => _onPageSelected(3),
        onOrderPlaced: _handleNewOrder,
        isMobile: isMobile,
        isTablet: isTablet,
        isDesktop: isDesktop,
      ),
      OffersPage(
        profile: _userProfile,
        onProfileTap: () => _onPageSelected(3),
      ),
      OrdersPage(dynamicOrders: _dynamicOrders),
      AccountPage(
        profile: _userProfile,
        onProfileUpdated: (updated) => setState(() => _userProfile = updated),
        isDarkMode: widget.isDarkMode,
        onDarkModeChanged: widget.onDarkModeChanged,
      ),
    ];

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      drawer: isMobile
          ? Drawer(
              child: SideMenu(
                selectedIndex: _selectedIndex,
                onPageSelected: (index) {
                  Navigator.pop(context);
                  _onPageSelected(index);
                },
              ),
            )
          : null,
      appBar: isMobile
          ? AppBar(
              title: Row(
                children: [
                  const Icon(Icons.local_pizza_rounded, color: Colors.deepPurple),
                  const SizedBox(width: 8),
                  Text(
                    'FooddySpot',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: CircleAvatar(
                    radius: 14,
                    backgroundImage: NetworkImage(_userProfile.avatarUrl),
                  ),
                  onPressed: () => _onPageSelected(3),
                ),
                const SizedBox(width: 8),
              ],
            )
          : null,
      body: Row(
        children: [
          if (!isMobile)
            SizedBox(
              width: isDesktop ? 240 : 80,
              child: SideMenu(
                selectedIndex: _selectedIndex,
                onPageSelected: _onPageSelected,
                isTablet: isTablet,
              ),
            ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: KeyedSubtree(
                key: ValueKey<int>(_selectedIndex),
                child: pages[_selectedIndex],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: isMobile
          ? NavigationBar(
              selectedIndex: _selectedIndex > 3 ? 3 : _selectedIndex,
              onDestinationSelected: _onPageSelected,
              indicatorColor: Colors.deepPurple.withValues(alpha: 0.2),
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home_rounded, color: Colors.deepPurple),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.local_offer_outlined),
                  selectedIcon: Icon(Icons.local_offer_rounded, color: Colors.deepPurple),
                  label: 'Offers',
                ),
                NavigationDestination(
                  icon: Icon(Icons.receipt_long_outlined),
                  selectedIcon: Icon(Icons.receipt_long_rounded, color: Colors.deepPurple),
                  label: 'Orders',
                ),
                NavigationDestination(
                  icon: Icon(Icons.account_circle_outlined),
                  selectedIcon: Icon(Icons.account_circle_rounded, color: Colors.deepPurple),
                  label: 'Account',
                ),
              ],
            )
          : null,
    );
  }
}