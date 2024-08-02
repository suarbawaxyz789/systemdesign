import 'package:flutter/material.dart';

import '../util.dart';

class PriceTag extends StatelessWidget {
  const PriceTag({
    super.key,
    required this.price,
    required this.priceDiscount,
    required this.percentDiscount,
  });

  final double price;
  final double priceDiscount;
  final double percentDiscount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 10,
          ),
          child: _RoundedContainer(
            price: price,
            priceDiscount: priceDiscount,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            right: 10,
          ),
          child: RotationTransition(
            turns: const AlwaysStoppedAnimation(15 / 360),
            child: _RoundedDiscountPercentContainer(
              percentDiscount: percentDiscount,
            ),
          ),
        )
      ],
    );
  }
}

class _RoundedDiscountPercentContainer extends StatelessWidget {
  const _RoundedDiscountPercentContainer({
    super.key,
    required this.percentDiscount,
  });

  final double percentDiscount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      // Width of the container
      height: 40,
      // Height of the container
      decoration: BoxDecoration(
        color: const Color(0xff127ff5),
        borderRadius: BorderRadius.circular(10), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            blurRadius: 10, // Spread radius
            offset: const Offset(0, 4), // Offset of the shadow
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          Text(
            "${percentDiscount.toInt().toString()}% OFF",
            style: Theme.of(context).primaryTextTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          )
        ],
      ),
    );
  }
}

class _RoundedContainer extends StatelessWidget {
  const _RoundedContainer({
    super.key,
    required this.price,
    required this.priceDiscount,
  });

  final double price;
  final double priceDiscount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 300, // Width of the container
          height: 100, // Height of the container
          decoration: BoxDecoration(
            color: const Color(0xff2f2e2f),
            borderRadius: BorderRadius.circular(20), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Shadow color
                blurRadius: 10, // Spread radius
                offset: Offset(0, 4), // Offset of the shadow
              ),
            ],
          ),
          child: CustomPaint(
            painter: _DiagonalPainter(),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 20,
            top: 20,
          ),
          width: 300,
          // Width of the container
          height: 100,
          // Height of the container
          decoration: BoxDecoration(
            color: Colors.transparent, // Background color of the container
            borderRadius: BorderRadius.circular(20), // Rounded corners
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 5,
                ),
                child: _DiagonalStrikethroughText(
                  text: SystemDesignUtil.formatMoney(value: price),
                  textStyle: Theme.of(context)
                      .primaryTextTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white, fontSize: 22),
                ),
              ),
              Text(
                SystemDesignUtil.formatMoney(value: priceDiscount),
                style:
                    Theme.of(context).primaryTextTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                        ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _DiagonalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Create a gradient
    const gradient = LinearGradient(
      colors: [Color(0xff127ff5), Color(0xff01259a)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final shader =
        gradient.createShader(Rect.fromLTWH(50, 50, size.width, size.height));

    final paintRight = Paint()
      ..shader = shader
      ..style = PaintingStyle.fill;

    Path rightPath = Path()
      ..moveTo(size.width * 0.7, 0)
      ..lineTo(size.width * 0.93, 0)
      ..quadraticBezierTo(size.width, 0, size.width, size.height * 0.2)
      ..lineTo(size.width, size.height * 0.8)
      ..quadraticBezierTo(
          size.width, size.height, size.width * 0.94, size.height)
      ..lineTo(size.width * 0.5, size.height)
      ..close();

    // Draw the shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3) // Shadow color
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 8); // Blur effect

    // Draw the shadow using the path
    canvas.drawPath(rightPath, shadowPaint);

    canvas.drawPath(rightPath, paintRight);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class _DiagonalStrikethroughText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  const _DiagonalStrikethroughText(
      {super.key, required this.text, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Text widget
        Text(
          text,
          style: textStyle,
        ),
        // Diagonal line
        CustomPaint(
          size: Size(
            textStyle.fontSize! * text.length * 0.6,
            textStyle.fontSize!,
          ),
          painter: _DiagonalLinePainter(
            textStyle: textStyle,
          ),
        ),
      ],
    );
  }
}

class _DiagonalLinePainter extends CustomPainter {
  final TextStyle textStyle;

  _DiagonalLinePainter({required this.textStyle});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2;

    // Drawing the diagonal line
    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width, 0),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
