// By: Dai Dinh
// 8/4/2023

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simpsonsviewer/show_character_dialog_box.dart';
import 'character_data_bloc.dart';
import 'character_data_class.dart';

class ButtonListWidget extends StatelessWidget {
  final List<SimpsonCharacter> charList;
  final bool isTablet;
  ButtonListWidget({required this.charList, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //shrinkWrap: true,
      //padding: EdgeInsets.zero,
      itemCount: charList.length,
      itemBuilder: (context, index) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0), // Set the radius to 0.0 for straight edges
            ),
          ),
          onPressed: ()
          {
            if (!isTablet)
            {
              showCharacterDialogBox(context, charList[index]);
            }
            else
              {
               // print('is Tablet, handle differently');
                final bloc = context.read<DataBloc>();
                bloc.add(SelectNameEvent(selectedFilteredIndex: index));
              }
          },
          child: Text(charList[index].charName),
        );
      },
    );
  }

}