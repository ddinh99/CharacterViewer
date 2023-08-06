// By: Dai Dinh
// 8/5/2023

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simpsonsviewer/character_data_class.dart';
import 'package:simpsonsviewer/split_view_widget.dart';
import 'character_button_list_widget.dart';
import 'character_data_bloc.dart';
import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';

import 'character_icon_widget.dart';
import 'character_search_widget.dart';

class ViewerHomePage extends StatefulWidget {
  const ViewerHomePage({super.key, required this.title});

  final String title;

  @override
  State<ViewerHomePage> createState() => _ViewerHomePageState();
}

class _ViewerHomePageState extends State<ViewerHomePage> {

  bool isTablet = false;
  String appName = '';

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    // Trigger the loading data event here
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(()
    {
      _packageInfo = info;
      final bloc = context.read<DataBloc>();
      String dataSource = 'http://api.duckduckgo.com/?q=simpsons+characters&format=json';
      print(_packageInfo.appName);
      if (_packageInfo.appName == 'The Wire Character Viewer')
      {
        dataSource = 'http://api.duckduckgo.com/?q=the+wire+characters&format=json';
      }
      appName = _packageInfo.appName;
      //  appName = _packageInfo.packageName;
      bloc.add(FetchingFromWeb(dataSource: dataSource));
    });
  }

  @override
  Widget build(BuildContext context)
  {
    // Use Platform to detect if the device is a tablet
    if (Platform.isAndroid || Platform.isIOS) {
      // You can define a custom threshold (in inches) to differentiate between phone and tablet

      double ratio = MediaQuery.of(context).size.width / MediaQuery.of(context).size.height;
      if( (ratio >= 0.74) && (ratio < 1.5) )
      {
        isTablet = true;
      } else{
        isTablet = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(appName),
      ),
      body: OrientationBuilder(
        builder: (context, orientation)
        {

          return (orientation == Orientation.portrait)
              ? _buildPortraitLayout(isTablet,orientation)
              : _buildLandscapeLayout(isTablet,orientation);
          //  return rebuildWithNewLayout();
        },
      ),

    );
  }

  Widget rebuildWithNewLayout(bool isTablet,Orientation orientation)
  {
    final mediaQueryData = MediaQuery.of(context);

    // Get the device's width and height using MediaQueryData
    final screenWidth = mediaQueryData.size.width;
    final screenHeight = mediaQueryData.size.height;

    return Stack(
      children: <Widget>[
        Positioned(
            top:0,
            child: SizedBox(
                width:screenWidth,
                height:50,
                child: CharacterSearchField())),
        Positioned(
          top:60,
          child: SizedBox(
            width:screenWidth,
            height:screenHeight-60,
            child: BlocBuilder<DataBloc,DataState>(builder: (theContext,theState)
            {
              if (theState.fetchState != FetchState.done)
              {
                return Center(child: Text('${theState.fetchState}',
                    style:const TextStyle(
                      fontSize:18,
                      fontWeight:FontWeight.bold,
                    )));
              }
              else
              {
                //  bool noneSelected = true;
                SimpsonCharacter theChar;
                String charName = '';
                String iconURL = '';
                String text = '';
                if (theState.filteredList.isNotEmpty)
                {
                  //  noneSelected = false;
                  theChar = theState.filteredList[theState.selectedNameIndex];
                  charName = theChar.charName;
                  iconURL = theChar.iconURL;
                  text = theChar.text;
                }

                if (!isTablet)
                {
                  return ButtonListWidget(
                    charList: theState.filteredList, isTablet: isTablet,);
                }
                else
                {
                  return SplitView(
                    initialWeight: 0.3,
                    leftChild: Container(
                      color: Colors.blue,
                      child: Center(
                        child: ButtonListWidget(
                          charList: theState.filteredList, isTablet: isTablet,),
                      ),
                    ),
                    rightChild: Container(
                      color: Colors.blueAccent,
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(height:20),
                            SizedBox(
                                width:200,
                                height:200,
                                child: ImageWithPlaceholder(imageUrl: 'https://duckduckgo.com$iconURL')),
                            Text(
                              charName,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            Flexible(
                              child: FractionallySizedBox(
                                heightFactor: (orientation == Orientation.portrait)?0.85:0.75,
                                child: Padding(
                                  padding: const EdgeInsets.only(top:0.0,left:10,right:10),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: Colors.grey,
                                        border: Border.all(width: 1.0, color: Colors.grey),
                                      ),

                                      // child: MyListView()
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(text,style:const TextStyle(
                                          fontSize:18,
                                        )),
                                      )
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }
            }),
          ),
        )
      ],
    );
  }


  Widget _buildPortraitLayout(bool isTablet,Orientation orientation) {
    // Return the UI layout for portrait orientation
    return rebuildWithNewLayout(isTablet,orientation);
  }

  Widget _buildLandscapeLayout(bool isTablet,Orientation orientation) {
    // Return the UI layout for landscape orientation
    return rebuildWithNewLayout(isTablet,orientation);
  }
}

