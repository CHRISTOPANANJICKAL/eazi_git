import 'package:eazigit/Screens/Provider/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';
import 'ProfilePage/profile_page.dart';
import 'RepositoryPage/repository_page.dart';



class TabViews extends StatelessWidget {
  const TabViews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: <Widget>[
              SizedBox(
                height: 150,
                child: AppBar(
                  title: Text(context.read<SearchProvider>().profile.name.toString()),
                  bottom: TabBar(
                    tabs: const [
                      Tab(
                        icon: Icon(FontAwesomeIcons.user),
                      ),
                      Tab(
                        icon: Icon(
                          FontAwesomeIcons.github,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: const [
                    ProfilePage(),
                    RepositoryPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}
