// By: Dai Dinh
// 8/4/2023

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'character_data_bloc.dart';

class CharacterSearchField extends StatefulWidget {
  @override
  _CharacterSearchFieldState createState() => _CharacterSearchFieldState();
}

class _CharacterSearchFieldState extends State<CharacterSearchField> {
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Material(
        elevation: 0, // Remove the default Material elevation to avoid double shadows
        borderRadius: BorderRadius.circular(8.0),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.search),
            ),
            Expanded(
              child: TextField(
                onChanged: (value)
                {
                  _searchText = value;
                  final bloc = context.read<DataBloc>();
                  bloc.add(SearchFieldEvent(searchText: _searchText));

                },
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
