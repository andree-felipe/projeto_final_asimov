// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projeto_final_asimov/components/filters/filter_button.dart';
// import 'package:projeto_final_asimov/core/services/products_services/product_service.dart';

// import '../../core/models/product.dart';
// import '../products/product_card.dart';

class FiltersMenu extends StatefulWidget {
  // const FiltersMenu({super.key});

  String filter;
  // Stream<List<Product>>? productsStream;

  FiltersMenu({
    super.key,
    required this.filter,
    // required this.productsStream,
  });

  @override
  State<FiltersMenu> createState() => _FiltersMenuState();
}

class _FiltersMenuState extends State<FiltersMenu> {
  void _changeFilter(String newFilter) {
    setState(() {
      widget.filter = newFilter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FilterButton(
          label: 'Todos',
          isSelected: widget.filter == 'Todos',
          onTap: () => _changeFilter('Todos'),
        ),
        FilterButton(
          label: 'Ferramentas manuais',
          isSelected: widget.filter == 'Ferramentas manuais',
          onTap: () => _changeFilter('Ferramentas manuais'),
        ),
        FilterButton(
          label: 'Ferramentas elétricas',
          isSelected: widget.filter == 'Ferramentas elétricas',
          onTap: () => _changeFilter('Ferramentas elétricas'),
        ),
        FilterButton(
          label: 'Materiais de construção',
          isSelected: widget.filter == 'Materiais de construção',
          onTap: () => _changeFilter('Materiais de construção'),
        ),
        FilterButton(
          label: 'Tintas e acabamentos',
          isSelected: widget.filter == 'Tintas e acabamentos',
          onTap: () => _changeFilter('Tintas e acabamentos'),
        ),
        FilterButton(
          label: 'Tubos e conexões',
          isSelected: widget.filter == 'Tubos e conexões',
          onTap: () => _changeFilter('Tubos e conexões'),
        ),
      ],
    );
  }
}
