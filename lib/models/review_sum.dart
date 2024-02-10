class ReviewSum {
  final String pros;
  final String cons;
  final String finalOpinion;

  ReviewSum({required this.pros, required this.cons, required this.finalOpinion});

  factory ReviewSum.fromJson(Map<String, dynamic> json) {
    return ReviewSum(
      pros: json['pros'],
      cons: json['cons'],
      finalOpinion: json['final'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pros': pros,
      'cons': cons,
      'final': finalOpinion,
    };
  }
}
