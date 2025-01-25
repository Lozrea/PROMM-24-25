class Stat {
  final String name;
  final String url;
  final int baseStat;
  final int effort;

  Stat({
    required this.name,
    required this.url,
    required this.baseStat,
    required this.effort,
  });

  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(
      name: json['stat']['name'] as String,
      url: json['stat']['url'] as String,
      baseStat: json['base_stat'] as int,
      effort: json['effort'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stat': {'name': name, 'url': url},
      'base_stat': baseStat,
      'effort': effort,
    };
  }
}