class Sensor {
  final double phAir;
  final double salinitasAir;
  final double ketinggianAir;

  Sensor({
    this.phAir,
    this.salinitasAir,
    this.ketinggianAir,
  });

  factory Sensor.fromJson(Map<dynamic, dynamic> json) {
    double parser(dynamic source) {
      try {
        return double.parse(source.toString());
      } on FormatException {
        return -1;
      }
    }

    return Sensor(
        phAir: parser(json['ph_air']),
        salinitasAir: parser(json['salinitas']),
        ketinggianAir: parser(json['tinggi_air']));
  }
}
