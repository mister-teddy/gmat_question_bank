class Database {
  List<String> rc;
  List<String> sc;
  List<String> cr;
  List<String> ps;
  List<String> ds;

  Database({
    required this.rc,
    required this.sc,
    required this.cr,
    required this.ps,
    required this.ds,
  });

  factory Database.fromJson(Map<String, dynamic> json) => Database(
        rc: List<String>.from(json["RC"].map((x) => x)),
        sc: List<String>.from(json["SC"].map((x) => x)),
        cr: List<String>.from(json["CR"].map((x) => x)),
        ps: List<String>.from(json["PS"].map((x) => x)),
        ds: List<String>.from(json["DS"].map((x) => x)),
      );
}
