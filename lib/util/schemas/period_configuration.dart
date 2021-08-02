class PeriodConfiguration {
  String name;
  String color;
  String icon;

  PeriodConfiguration(
      {required this.name, required this.color, required this.icon});

  Map<String, String> toJson() => {'name': name, 'color': color, 'icon': icon};
}
