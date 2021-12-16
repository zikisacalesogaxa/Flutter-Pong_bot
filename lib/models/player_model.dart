class PlayerModel {
  late String email;
  late String username;
  late int wins;
  late int losses;
  late int gamesPlayed;
  late bool playing;
  late String avatar;
  late int avg;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['email'] = email;
    map['username'] = username;
    map['wins'] = wins;
    map['losses'] = losses;
    map['gamesPlayed'] = gamesPlayed;
    map['playing'] = playing;
    map['avatar'] = avatar;
    map['avg'] = avg;
    return map;
  }

  PlayerModel.fromMap(Map<String, dynamic> map) {
    email = map['email'];
    username = map['username'];
    wins = map['wins'];
    losses = map['losses'];
    gamesPlayed = map['gamesPlayed'];
    playing = map['playing'];
    avatar = map['avatar'];
    avg = map['avg'];
  }
}
