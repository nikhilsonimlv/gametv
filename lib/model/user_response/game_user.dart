class GameUser {
  String id;
  String createdAt;
  String name;
  String avatar;
  String username;
  String noOfTournament;
  String noOfTournamentWon;
  String winPercentage;
  String rating;

  GameUser(
      {this.id,
      this.createdAt,
      this.name,
      this.avatar,
      this.username,
      this.noOfTournament,
      this.noOfTournamentWon,
      this.winPercentage,
      this.rating});

  GameUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    name = json['name'];
    avatar = json['avatar'];
    username = json['username'];
    noOfTournament = json['noOfTournament'];
    noOfTournamentWon = json['noOfTournamentWon'];
    winPercentage = json['winPercentage'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['username'] = this.username;
    data['noOfTournament'] = this.noOfTournament;
    data['noOfTournamentWon'] = this.noOfTournamentWon;
    data['winPercentage'] = this.winPercentage;
    data['rating'] = this.rating;
    return data;
  }
}
