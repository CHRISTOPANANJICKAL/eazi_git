// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';
Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

// String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    required this.login,
    required this.avatarUrl,
    required this.url,
    required this.reposUrl,
    required this.name,
    required this.company,
    required this.blog,
    required this.location,
    required this.bio,
    required this.publicRepos,
    required this.followers,
    required this.following,
  });

  String? login;
  String? avatarUrl;
  String? url;
  String? reposUrl;
  String? name;
  String? company;
  String? blog;
  String? location;
  String? bio;
  int? publicRepos;
  int? followers;
  int? following;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    login: json["login"] ?? "Nil",
    avatarUrl: json["avatar_url"] ?? "Nil",
    url: json["url"] ?? "Nil",
    reposUrl: json["repos_url"] ?? "Nil",
    name: json["name"] ?? "Nil",
    company: json["company"] ?? "Nil",
    blog: json["blog"].toString().isEmpty?"Nil": json["blog"],
    location: json["location"] ?? "Nil",
    bio: json["bio"] ?? "Nil",
    publicRepos: json["public_repos"] ?? 0,
    followers: json["followers"] ?? 0,
    following: json["following"] ?? 0,
  );

  // Map<String, dynamic> toJson() => {
  //   "login": login,
  //   "avatar_url": avatarUrl,
  //   "url": url,
  //   "repos_url": reposUrl,
  //   "name": name,
  //   "company": company,
  //   "blog": blog,
  //   "location": location,
  //   "bio": bio,
  //   "public_repos": publicRepos,
  //   "followers": followers,
  //   "following": following,
  // };
}
