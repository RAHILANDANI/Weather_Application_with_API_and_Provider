class TemphourModel {
  String time;
  double tempc;
  double tempf;
  double windmph;
  double windkph;
  String imageurl;
  String wheatertext;

  TemphourModel(
      {required this.imageurl,
      required this.wheatertext,
      required this.time,
      required this.tempc,
      required this.tempf,
      required this.windkph,
      required this.windmph});
}
