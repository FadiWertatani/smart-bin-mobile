class Bin {
  final String reference;
  final int fillLevel;

  Bin({required this.reference, required this.fillLevel});

  factory Bin.fromJson(Map<String, dynamic> json) {
    return Bin(
      reference: json['reference'],
      fillLevel: json['fill_level'],
    );
  }

  String get status {
    if (fillLevel >= 90) return "Full";
    if (fillLevel >= 70) return "Near Full";
    return "Collected";
  }
}
