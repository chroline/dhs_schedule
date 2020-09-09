class PeriodConfiguration {
  String name;
  String color;
  String icon;

  PeriodConfiguration({this.name, this.color, this.icon});

  toJson() => {"name": name, "color": color, "icon": icon};
}
