extension DoubleExtension on double {
  static List<double> conventionalAngles = [0, 90, 180, -90];
  static double threshold = 0.8;
  double get getProperAngle {
    List getProperAngleList = conventionalAngles
        .where((element) => (element - this).abs() < 0.8)
        .toList();
    if (getProperAngleList.isNotEmpty) {
      return conventionalAngles.first;
    }
    return this;
  }
  // double get properAngle{
  //   if (cameNearConventionalAngle) {
  //     return
  //   }
  // }
}
