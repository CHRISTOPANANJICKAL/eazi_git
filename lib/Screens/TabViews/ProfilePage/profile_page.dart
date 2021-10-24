import 'package:eazigit/DataModels/profile_data_model.dart';
import 'package:eazigit/Screens/Provider/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';
import 'package:velocity_x/velocity_x.dart';
late Profile profile;
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    profile = context.read<SearchProvider>().getProfile();
    context.read<SearchProvider>().loadImage(profile.avatarUrl!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: context.percentHeight * 3,
          ),
          SizedBox(
            height: context.percentWidth*55,
            width: context.percentWidth*55,
            child: ClipRRect(
      borderRadius: BorderRadius.circular(200.0),
               child:(context.watch<SearchProvider>().imageLoading)?CircularProgressIndicator():(context.watch<SearchProvider>().imageLoaded)?Image.memory(context.read<SearchProvider>().getImage()):CircleAvatar(
                 child: Icon(FontAwesomeIcons.user,size: context.percentWidth*30,),
               )
             ),
          ),
          SizedBox(
            height: context.percentHeight * 1.2,
          ),
          Divider(),
          Text(profile.login!,style: GoogleFonts.imFellEnglishSc(
              color: Colors.blue, fontSize: 18
          )),
          SizedBox(
            height: context.percentHeight * 3,
          ),
          Table(
            border: TableBorder.all(color: Colors.blueGrey),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
              children: [
                Text("Bio",style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),textAlign: TextAlign.center,),
                Align(
                    alignment: Alignment.center,
                    child:Text(profile.bio!,textAlign: TextAlign.center,)),
              ]),
              TableRow(children: [
                Text("Blog",style: TextStyle(
                    fontWeight: FontWeight.bold
                ),textAlign: TextAlign.center,),
                Text(profile.blog!,textAlign: TextAlign.center,),
              ]),
              TableRow(children: [
                Text("Company",style: TextStyle(
                    fontWeight: FontWeight.bold
                ),textAlign: TextAlign.center,),
                Text(profile.company!,textAlign: TextAlign.center,),
              ]),
              TableRow(children: [
                Text("Location",style: TextStyle(
                    fontWeight: FontWeight.bold
                ),textAlign: TextAlign.center,),
                Text(profile.location!,textAlign: TextAlign.center,),
              ]),
              TableRow(children: [
                Text("No.of repositories",style: TextStyle(
                    fontWeight: FontWeight.bold
                ),textAlign: TextAlign.center,),
                Text(profile.publicRepos!.toString(),textAlign: TextAlign.center,),
              ]),
              TableRow(children: [
                Text("Followers",style: TextStyle(
                    fontWeight: FontWeight.bold
                ),textAlign: TextAlign.center,),
                Text(profile.followers!.toString(),textAlign: TextAlign.center,),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}


