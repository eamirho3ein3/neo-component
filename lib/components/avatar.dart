part of bank_components;

class CustomAvatar extends StatelessWidget {
  final String image;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double radius;
  CustomAvatar(
      {this.image,
      @required this.icon,
      @required this.backgroundColor,
      @required this.iconColor,
      @required this.radius});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      foregroundImage: image != null ? NetworkImage(image) : null,
      child: icon != null
          ? Icon(
              icon,
              color: iconColor,
            )
          : SizedBox(),
      onForegroundImageError: (object, stackTrace) {
        print("stackTrace = $stackTrace");
      },
    );
  }
}