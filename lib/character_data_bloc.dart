// By: Dai Dinh
// 8/3/2023

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simpsonsviewer/character_data_class.dart';

enum FetchState { idle,loading,parsing,done,error}
class DataState
{
  String jsonData = '';
  FetchState fetchState = FetchState.idle;
  List<SimpsonCharacter> filteredList = [];
  List<SimpsonCharacter> fullList = [];
  int selectedNameIndex = 0;

  DataState({required this.jsonData,required this.fetchState,required this.filteredList,
  required this.fullList,required this.selectedNameIndex});

  factory DataState.initial() => DataState(jsonData: '',fetchState: FetchState.idle,
  filteredList:[],fullList:[],selectedNameIndex:0);
}

abstract class DataEvent {}
class FetchingFromWeb extends DataEvent {
  String dataSource;
  FetchingFromWeb({required this.dataSource});
}

class SearchFieldEvent extends DataEvent
{
  String searchText;
  SearchFieldEvent({required this.searchText});
}

class SelectNameEvent extends DataEvent
{
  int selectedFilteredIndex;
  SelectNameEvent({required this.selectedFilteredIndex});
}

class DataBloc extends Bloc<DataEvent,DataState> {
  DataBloc() :super(DataState.initial())
  {
    on<FetchingFromWeb>((event, emit)
    async {
      String jsonData =  await fetchData(event.dataSource);
      if (jsonData.startsWith('Error'))
      {
        emit(DataState(jsonData: jsonData,fetchState: FetchState.error,
        filteredList: [],fullList: [],selectedNameIndex: 0));
      }
      else
      {
        Map<String, dynamic> data = json.decode(jsonData);
        emit(DataState(jsonData: jsonData,fetchState: FetchState.parsing,filteredList: [],
        fullList: [],selectedNameIndex: 0));
        parseData(data);
        emit(DataState(jsonData: jsonData,fetchState: FetchState.done,filteredList: characterList,fullList: characterList,
        selectedNameIndex: 0));
      }
    });

    on<SearchFieldEvent>((event, emit)
    {
        List<SimpsonCharacter> newFilteredList = [];
        String searchString = event.searchText.toLowerCase();
        for (int i = 0; i < characterList.length; i++)
          {
            String str1 = characterList[i].charName.toLowerCase();
            String str2 = characterList[i].text.toLowerCase();
            if (str1.contains(searchString) || (str2.contains(searchString)))
                {
                  newFilteredList.add(characterList[i]);
                }
          }
        if (searchString.isEmpty)
          {
            newFilteredList = characterList;
          }
        emit(DataState(jsonData: '',fetchState: FetchState.done,filteredList: newFilteredList,fullList: characterList,selectedNameIndex: 0));
    });

    on<SelectNameEvent>((event, emit)
    {
      emit(DataState(jsonData: '',fetchState: FetchState.done,filteredList: state.filteredList,fullList: characterList,selectedNameIndex: event.selectedFilteredIndex));
    });
  }
}

Future<String> fetchData(String dataSource) async {
  String jsonData = '';
  try {
  //  final response = await http.get(Uri.parse('http://api.duckduckgo.com/?q=simpsons+characters&format=json'));
    final response = await http.get(Uri.parse(dataSource));
    if (response.statusCode == 200) {
        jsonData = response.body;

    } else {

        jsonData = 'Error fetching data';
    }
  } catch (e)
  {
      jsonData = 'Error: $e';
  }
  return jsonData;
}
