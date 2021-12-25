part of bank_components;

class Skeleton extends StatelessWidget {
  final Widget child;
  final SkeletonSetting setting;
  Skeleton({@required this.child, @required this.setting});
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      color: setting.highlightColor,
      direction: setting.direction,
      child: child,
    );
  }
}

class SkeletonSetting {
  final Color color;
  final Color highlightColor;
  final ShimmerDirection direction;

  SkeletonSetting(
      {@required this.color,
      @required this.highlightColor,
      @required this.direction});
}