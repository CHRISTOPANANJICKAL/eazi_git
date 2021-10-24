import 'dart:ui';

import 'package:eazigit/Screens/Provider/search_provider.dart';
import 'package:eazigit/Screens/TabViews/tab_views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';
import 'package:velocity_x/velocity_x.dart';

TextEditingController nameController = TextEditingController();
ScrollController sc = ScrollController();
class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: nameController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Enter Username",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none),
              fillColor: Color(0xffe6e6ec),
              filled: true,
            ),
          ),
        ),
        SizedBox(
          height: context.percentHeight * 2,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              ),
          child: MaterialButton(
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              Future<bool> dataObtained = context.read<SearchProvider>().setName(nameController.text);
             dataObtained.then((d){
               if(d){
                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                     TabViews()));
               }
             });
            },
            color: Colors.blue,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Colors.blue, width: 1, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(50)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Go",
                  style: GoogleFonts.alfaSlabOne(
                      color: Colors.white, fontSize: 35),
                ),
                Icon(
                  FontAwesomeIcons.binoculars,
                  color: Colors.white,
                  size: 28,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: context.percentHeight * 2,
        ),
        (context.watch<SearchProvider>().isDataLoading)?CircularProgressIndicator():
        (context.watch<SearchProvider>().dataLoaded)? Text(""): Text(
          context.watch<SearchProvider>().errorText,
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}


class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    // etc.
  };
}