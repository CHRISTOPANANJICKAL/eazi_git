import 'package:eazigit/DataModels/repository_data_model.dart';
import 'package:eazigit/Screens/Provider/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:url_launcher/url_launcher.dart';


ScrollController repositoryScrollController = ScrollController();
TextEditingController filterController = TextEditingController();
class RepositoryPage extends StatefulWidget {
  const RepositoryPage({Key? key}) : super(key: key);

  @override
  State<RepositoryPage> createState() => _RepositoryPageState();
}

class _RepositoryPageState extends State<RepositoryPage> {
  @override
  void initState() {
    context.read<SearchProvider>().getRepositories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<SearchProvider>().repositoryLoading) {
      return Center(
        child: SizedBox(
          width: 150,
          height: 150,
          child: CircularProgressIndicator(),
        ),
      );
    } else if (context.watch<SearchProvider>().repositoryLoaded) {
      return RepositoryListView();
    }
    return Text("Error");
  }
}

class RepositoryListView extends StatelessWidget {
  const RepositoryListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<RepositoryModel> repositories =
        context.watch<SearchProvider>().getRepositoryDisplayList();
    return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: filterController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Repository name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none),
                    fillColor: Color(0xffe6e6ec),
                    filled: true,
                  ),
                  onChanged: (String text){
                    context.read<SearchProvider>().filterWithText(text);
                  },
                ),
              ),
              SizedBox(height: 18),
              Expanded(child: ListView.separated(
                  itemCount: repositories.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  controller: repositoryScrollController,
                  itemBuilder: (context, index) {
                    return MaterialButton(onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    reDirectToRepository(repositories[index].htmlUrl,context);
                    },padding: EdgeInsets.zero,height: 65,
                    child: Align(alignment: Alignment.centerLeft,child: Text(repositories[index].name,)));
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      height: 0,
                    );
                  },
                ),
              ),
            ],
          ));
}}


reDirectToRepository(String url,context) async {
  if (await canLaunch(url)) {
    await launch(url);
  }else{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Failed to open browser."),
    ));
  }
}