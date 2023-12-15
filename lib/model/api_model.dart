class ApiModel {
  String name;
  String region;
  String country;
  String lattitude;
  String longititude;
  String timezone;
  String localtime;

  ApiModel(
      {required this.name,
      required this.country,
      required this.lattitude,
      required this.localtime,
      required this.longititude,
      required this.region,
      required this.timezone});
}
