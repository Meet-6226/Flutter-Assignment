import 'package:flutter/material.dart';
import 'models/product.dart';
import 'widgets/product_card.dart';
import 'widgets/product_detail_sheet.dart';

void main() {
  runApp(const DynamicProductApp());
}

class DynamicProductApp extends StatelessWidget {
  const DynamicProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Catalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          scrolledUnderElevation: 2,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: const ProductListScreen(),
    );
  }
}

enum SortOption {
  featured('Featured'),
  priceLowToHigh('Price: Low to High'),
  priceHighToLow('Price: High to Low'),
  highestRated('Top Rated');

  final String label;
  const SortOption(this.label);
}

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  // Master data source
  final List<Product> _allProducts = List.unmodifiable(sampleProducts);

  // Active filtered list displayed by ListView.builder
  List<Product> _filteredProducts = [];

  // State controls for Search and Filtering
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  ProductCategory _selectedCategory = ProductCategory.all;
  SortOption _selectedSort = SortOption.featured;
  bool _inStockOnly = false;

  // Cart state
  final List<Product> _cartItems = [];

  @override
  void initState() {
    super.initState();
    _applyFilters();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Core filter & search logic updating UI state using setState
  void _applyFilters() {
    setState(() {
      _filteredProducts = _allProducts.where((product) {
        // 1. Search Query filter (matches name, description, or category)
        final matchesSearch = _searchQuery.isEmpty ||
            product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            product.description
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            product.category.label
                .toLowerCase()
                .contains(_searchQuery.toLowerCase());

        // 2. Category filter
        final matchesCategory = _selectedCategory == ProductCategory.all ||
            product.category == _selectedCategory;

        // 3. In-stock availability filter
        final matchesStock = !_inStockOnly || product.isAvailable;

        return matchesSearch && matchesCategory && matchesStock;
      }).toList();

      // 4. Sorting
      switch (_selectedSort) {
        case SortOption.priceLowToHigh:
          _filteredProducts.sort((a, b) => a.price.compareTo(b.price));
          break;
        case SortOption.priceHighToLow:
          _filteredProducts.sort((a, b) => b.price.compareTo(a.price));
          break;
        case SortOption.highestRated:
          _filteredProducts.sort((a, b) => b.rating.compareTo(a.rating));
          break;
        case SortOption.featured:
          // Keep original order
          break;
      }
    });
  }

  void _onSearchChanged(String value) {
    _searchQuery = value.trim();
    _applyFilters();
  }

  void _onCategorySelected(ProductCategory category) {
    setState(() {
      _selectedCategory = category;
    });
    _applyFilters();
  }

  void _onSortChanged(SortOption option) {
    setState(() {
      _selectedSort = option;
    });
    _applyFilters();
  }

  void _toggleStockFilter(bool value) {
    setState(() {
      _inStockOnly = value;
    });
    _applyFilters();
  }

  void _resetFilters() {
    setState(() {
      _searchController.clear();
      _searchQuery = '';
      _selectedCategory = ProductCategory.all;
      _selectedSort = SortOption.featured;
      _inStockOnly = false;
    });
    _applyFilters();
  }

  void _addToCart(Product product) {
    setState(() {
      _cartItems.add(product);
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added "${product.name}" to cart!'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _cartItems.remove(product);
            });
          },
        ),
      ),
    );
  }

  void _openProductDetail(Product product) {
    ProductDetailSheet.show(
      context,
      product: product,
      onAddToCart: () => _addToCart(product),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasActiveFilters = _searchQuery.isNotEmpty ||
        _selectedCategory != ProductCategory.all ||
        _selectedSort != SortOption.featured ||
        _inStockOnly;

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Discover Products',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              '${_allProducts.length} items available',
              style: TextStyle(
                fontSize: 12,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          // Sort Menu
          PopupMenuButton<SortOption>(
            icon: const Icon(Icons.sort_rounded),
            tooltip: 'Sort Products',
            initialValue: _selectedSort,
            onSelected: _onSortChanged,
            itemBuilder: (context) => SortOption.values.map((sortOption) {
              return PopupMenuItem<SortOption>(
                value: sortOption,
                child: Row(
                  children: [
                    Icon(
                      _selectedSort == sortOption
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      size: 18,
                      color: _selectedSort == sortOption
                          ? theme.colorScheme.primary
                          : Colors.grey,
                    ),
                    const SizedBox(width: 10),
                    Text(sortOption.label),
                  ],
                ),
              );
            }).toList(),
          ),

          // In-Stock Only Toggle
          IconButton(
            icon: Icon(
              _inStockOnly ? Icons.check_circle : Icons.check_circle_outline,
              color: _inStockOnly ? theme.colorScheme.primary : null,
            ),
            tooltip: _inStockOnly ? 'Showing In Stock Only' : 'Filter In Stock',
            onPressed: () => _toggleStockFilter(!_inStockOnly),
          ),

          // Cart Button with Badge
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined),
                tooltip: 'Cart',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Cart contains ${_cartItems.length} item(s)',
                      ),
                    ),
                  );
                },
              ),
              if (_cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.error,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${_cartItems.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Search Input Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: SearchBar(
              controller: _searchController,
              hintText: 'Search products by name or tag...',
              leading: const Icon(Icons.search_rounded),
              trailing: [
                if (_searchQuery.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear_rounded),
                    tooltip: 'Clear Search',
                    onPressed: () {
                      _searchController.clear();
                      _onSearchChanged('');
                    },
                  ),
              ],
              onChanged: _onSearchChanged,
              elevation: const WidgetStatePropertyAll(1),
              backgroundColor: WidgetStatePropertyAll(
                theme.colorScheme.surface,
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: BorderSide(
                    color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
          ),

          // Horizontal Category Filter Chips
          SizedBox(
            height: 48,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: ProductCategory.values.length,
              itemBuilder: (context, index) {
                final category = ProductCategory.values[index];
                final isSelected = _selectedCategory == category;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FilterChip(
                    avatar: Icon(
                      category.icon,
                      size: 16,
                      color: isSelected
                          ? theme.colorScheme.onPrimaryContainer
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                    label: Text(category.label),
                    selected: isSelected,
                    onSelected: (_) => _onCategorySelected(category),
                    showCheckmark: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                );
              },
            ),
          ),

          // Active filter result summary row
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 6),
            child: Row(
              children: [
                Text(
                  '${_filteredProducts.length} ${_filteredProducts.length == 1 ? "product" : "products"} found',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                if (_inStockOnly) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'In Stock Only',
                      style: TextStyle(
                        fontSize: 11,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ],
                const Spacer(),
                if (hasActiveFilters)
                  TextButton.icon(
                    onPressed: _resetFilters,
                    icon: const Icon(Icons.refresh_rounded, size: 16),
                    label: const Text('Reset'),
                    style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
              ],
            ),
          ),

          const Divider(height: 1, thickness: 1),

          // Dynamic Product Listing using ListView.builder
          Expanded(
            child: _filteredProducts.isEmpty
                ? _buildEmptyState(theme)
                : RefreshIndicator(
                    onRefresh: () async {
                      _applyFilters();
                    },
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      padding: const EdgeInsets.only(top: 8, bottom: 24),
                      itemCount: _filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = _filteredProducts[index];
                        return ProductCard(
                          key: ValueKey(product.id),
                          product: product,
                          onTap: () => _openProductDetail(product),
                          onAddToCart: () => _addToCart(product),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.errorContainer.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_off_rounded,
                size: 64,
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'No Products Found',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _searchQuery.isNotEmpty
                  ? 'No products matched "$_searchQuery". Try searching with different keywords or clearing active filters.'
                  : 'No products match the selected filters.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.tonalIcon(
              onPressed: _resetFilters,
              icon: const Icon(Icons.filter_alt_off_rounded),
              label: const Text('Clear All Filters'),
            ),
          ],
        ),
      ),
    );
  }
}
