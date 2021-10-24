import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:eazigit/DataModels/profile_data_model.dart';
import 'package:eazigit/DataModels/repository_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;


class SearchProvider extends ChangeNotifier{
  String _name = "";
  String errorText = "";
  late Profile profile;
  bool dataLoaded = false;
  bool isDataLoading = false;
  Uint8List? image;
  bool imageLoaded = false;
  bool imageLoading = true;
  List<RepositoryModel> repository = [];
  List <RepositoryModel> repositoryDisplayList = [];
  String get name => _name;
  bool repositoryLoaded =false;
  bool repositoryLoading =false;


  Future<bool> setName(String value) async {
    _name = value;
    if(_name.isEmpty){
      errorText = "Enter a valid name.";
      notifyListeners();
    }else{
      errorText = "";
      dataLoaded =false;
      isDataLoading = true;
      notifyListeners();
      await searchGitHub(_name);
      isDataLoading = false;
      notifyListeners();
    }
    return dataLoaded;
  }

  void setProfile(Profile profileInput){
    profile = profileInput;
  }

  Profile getProfile(){
    return profile;
  }

  searchGitHub(String name) async {
    imageLoaded = false;
    imageLoading = true;
    repositoryLoaded = false;
    http.Response response;
    String baseUrl = "http://api.github.com/users/";
    Uri uri = Uri.parse(baseUrl+name);
    try{
      response = await http.get(uri);
      if (response.statusCode == 200) {
        repository =[];
        profile = profileFromJson(response.body);
        if(profile.name == null){
          dataLoaded = false;
          errorText = "No User Found.";
        }else{
          dataLoaded = true;
        }
      }else if(response.statusCode == 404){
        dataLoaded = false;
        errorText = "No User Found.";
      }else{
        dataLoaded = true;
      }
    }on SocketException catch (_) {
      errorText = "No internet.";
    }catch(e){
      errorText = e.toString();
    }
  }


  loadImage(String uri) async {
    if(!imageLoaded){
      try{
        final ByteData imageData = await NetworkAssetBundle(Uri.parse(uri)).load("");
        image = imageData.buffer.asUint8List();
        imageLoaded = true;
        imageLoading = false;
        notifyListeners();
      }catch(e){
        imageLoading = false;
        imageLoaded =false;
        notifyListeners();
      }
    }
  }

  getImage(){
    return image;
  }



  getRepositories() async {
    if(!repositoryLoaded){
      repositoryLoading = true;
      repositoryLoaded = false;
      http.Response response;
      String baseUrl = "http://api.github.com/users/";
      Uri uri = Uri.parse(baseUrl+name+"/repos");
      try{
        response = await http.get(uri);
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          for(int i = 0;i<data.length;i++){
            repository.add(RepositoryModel(name: data[i]["name"], htmlUrl: data[i]["html_url"]));
          }
          repositoryDisplayList = repository;
          repositoryLoaded =true;
          repositoryLoading = false;
          notifyListeners();
        }}catch(e){
        repositoryLoaded =false;
        repositoryLoading = false;
        notifyListeners();
      }
    }
  }

 getRepositoryDisplayList(){
    return repositoryDisplayList;
 }

  filterWithText(String text){
    if(text.isEmpty){
      repositoryDisplayList = repository;
      notifyListeners();
    }else{
      repositoryDisplayList = [];
      for(int y = 0;y<repository.length;y++){
        if(repository[y].name.toLowerCase().contains(text.toLowerCase())){
          repositoryDisplayList.add(repository[y]);
        }
      }
      notifyListeners();
    }
  }
}





