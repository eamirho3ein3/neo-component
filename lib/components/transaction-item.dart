part of neo_components;

class TransactionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String price;
  final TransactionItemTheme style;
  TransactionItem(
      {@required this.icon,
      @required this.title,
      @required this.subtitle,
      @required this.style,
      @required this.price});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: style.backgroundColor,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          // logo
          CircleAvatar(
            backgroundColor: style.logoBackgroundColor,
            radius: 24,
            child: Icon(
              icon,
              color: style.logoColor,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // title
                    Text(title, style: Theme.of(context).textTheme.subtitle1),
                    SizedBox(
                      width: 12,
                    ),
                    // price
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: price,
                                style: Theme.of(context).textTheme.subtitle1),
                            TextSpan(
                              text: ' ',
                            ),
                            TextSpan(
                                text: 'ریال',
                                style: Theme.of(context).textTheme.caption),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                // subtitle
                Text(subtitle,
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: style.subtitleColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionItemTheme {
  final Color backgroundColor;
  final Color logoColor;
  final Color logoBackgroundColor;
  final Color subtitleColor;

  TransactionItemTheme(
      {@required this.backgroundColor,
      @required this.logoColor,
      @required this.logoBackgroundColor,
      @required this.subtitleColor});
}