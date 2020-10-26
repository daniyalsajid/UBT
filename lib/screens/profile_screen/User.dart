class Users {
  final String scoreVal;
  final int scoreDate;
  Users(this.scoreVal, this.scoreDate);

  Users.fromMap(Map<String, dynamic> map)
      : assert(map['Distance'] != null),
        assert(map['Date'] != null),
        scoreVal = map['Distance'],
        scoreDate = map['Date'];

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
