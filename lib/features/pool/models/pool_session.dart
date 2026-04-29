class PoolSession {
  final String? id; // Firebase Document ID
  final String poolName;
  final List<String> participants; // Could later be a List<Participant> object
  final String? splitMethod;
  final String? poolCode;
  final bool isAdmin;
  final double totalBill;
  final double extraCosts;
  final bool isLive; // False while Admin is drafting, True when revealed

  PoolSession({
    this.id,
    required this.poolName,
    required this.participants,
    this.splitMethod,
    this.poolCode,
    this.isAdmin = false,
    this.totalBill = 0.0,
    this.extraCosts = 0.0,
    this.isLive = false,
  });

  PoolSession copyWith({
    String? id,
    String? splitMethod,
    String? poolCode,
    double? totalBill,
    double? extraCosts,
    bool? isLive,
    List<String>? participants,
  }) {
    return PoolSession(
      id: id ?? this.id,
      poolName: poolName,
      participants: participants ?? this.participants,
      splitMethod: splitMethod ?? this.splitMethod,
      poolCode: poolCode ?? this.poolCode,
      isAdmin: isAdmin,
      totalBill: totalBill ?? this.totalBill,
      extraCosts: extraCosts ?? this.extraCosts,
      isLive: isLive ?? this.isLive,
    );
  }
}
