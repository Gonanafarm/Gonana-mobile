import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/models/product_model.dart';
import '../../../marketplace/presentation/providers/products_provider.dart';
import '../../../marketplace/presentation/widgets/product_card.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedCategory;
  double _minPrice = 0;
  double _maxPrice = 1000000;
  String _sortBy = 'recent';

  final List<String> _categories = [
    'All',
    'Grains',
    'Vegetables',
    'Fruits',
    'Livestock',
    'Poultry',
    'Fish',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Product> _filterProducts(List<Product> products) {
    var filtered = products;

    // Search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((p) {
        return p.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            (p.description
                    ?.toLowerCase()
                    .contains(_searchQuery.toLowerCase()) ??
                false);
      }).toList();
    }

    // Category filter
    if (_selectedCategory != null && _selectedCategory != 'All') {
      filtered = filtered
          .where((p) =>
              p.category?.toLowerCase() == _selectedCategory?.toLowerCase())
          .toList();
    }

    // Price filter
    filtered = filtered.where((p) {
      return p.price >= _minPrice && p.price <= _maxPrice;
    }).toList();

    // Sort
    switch (_sortBy) {
      case 'price_low':
        filtered.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price_high':
        filtered.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'recent':
      default:
        filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(productsProvider);
    final filteredProducts = _filterProducts(productsState.products);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search products...',
            border: InputBorder.none,
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        _searchQuery = '';
                      });
                    },
                  )
                : null,
          ),
          onChanged: (value) {
            setState(() => _searchQuery = value);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: _showFiltersBottomSheet,
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter chips
          if (_selectedCategory != null ||
              _minPrice > 0 ||
              _maxPrice < 1000000 ||
              _sortBy != 'recent')
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  if (_selectedCategory != null && _selectedCategory != 'All')
                    Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.xs),
                      child: Chip(
                        label: Text(_selectedCategory!),
                        onDeleted: () {
                          setState(() => _selectedCategory = null);
                        },
                      ),
                    ),
                  if (_minPrice > 0 || _maxPrice < 1000000)
                    Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.xs),
                      child: Chip(
                        label: Text(
                            '₦${_minPrice.toInt()} - ₦${_maxPrice.toInt()}'),
                        onDeleted: () {
                          setState(() {
                            _minPrice = 0;
                            _maxPrice = 1000000;
                          });
                        },
                      ),
                    ),
                  if (_sortBy != 'recent')
                    Chip(
                      label: Text(_getSortLabel(_sortBy)),
                      onDeleted: () {
                        setState(() => _sortBy = 'recent');
                      },
                    ),
                ],
              ),
            ),

          // Results count
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Text(
                  '${filteredProducts.length} products found',
                  style: context.textTheme.titleSmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          // Products grid
          Expanded(
            child: filteredProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'No products found',
                          style: context.textTheme.titleMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ).animate().fadeIn(duration: 300.ms),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: AppSpacing.md,
                      mainAxisSpacing: AppSpacing.md,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: filteredProducts[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  String _getSortLabel(String sortBy) {
    switch (sortBy) {
      case 'price_low':
        return 'Price: Low to High';
      case 'price_high':
        return 'Price: High to Low';
      case 'recent':
      default:
        return 'Most Recent';
    }
  }

  void _showFiltersBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filters',
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setModalState(() {
                          _selectedCategory = null;
                          _minPrice = 0;
                          _maxPrice = 1000000;
                          _sortBy = 'recent';
                        });
                        setState(() {});
                      },
                      child: const Text('Reset'),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.md),

                // Category
                Text(
                  'Category',
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  children: _categories.map((category) {
                    final isSelected = _selectedCategory == category ||
                        (category == 'All' && _selectedCategory == null);
                    return ChoiceChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        setModalState(() {
                          _selectedCategory =
                              category == 'All' ? null : category;
                        });
                      },
                    );
                  }).toList(),
                ),

                const SizedBox(height: AppSpacing.lg),

                // Price Range
                Text(
                  'Price Range',
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                RangeSlider(
                  values: RangeValues(_minPrice, _maxPrice),
                  min: 0,
                  max: 1000000,
                  divisions: 100,
                  labels: RangeLabels(
                    '₦${_minPrice.toInt()}',
                    '₦${_maxPrice.toInt()}',
                  ),
                  onChanged: (values) {
                    setModalState(() {
                      _minPrice = values.start;
                      _maxPrice = values.end;
                    });
                  },
                ),

                const SizedBox(height: AppSpacing.lg),

                // Sort
                Text(
                  'Sort By',
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                ...['recent', 'price_low', 'price_high'].map((sort) {
                  return RadioListTile<String>(
                    title: Text(_getSortLabel(sort)),
                    value: sort,
                    groupValue: _sortBy,
                    onChanged: (value) {
                      setModalState(() => _sortBy = value!);
                    },
                    contentPadding: EdgeInsets.zero,
                  );
                }),

                const SizedBox(height: AppSpacing.lg),

                // Apply button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {});
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    child: const Text('Apply Filters'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
