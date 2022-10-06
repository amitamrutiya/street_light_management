import 'package:flutter/material.dart';
import 'package:street_light_management/common_weights/big_text.dart';

class CustomGridTile extends StatefulWidget {
  final String imageUrl;
  final int activeLight;
  final int deadLight;
  final String addressText;
  const CustomGridTile({
    Key? key,
    required this.imageUrl,
    required this.activeLight,
    required this.deadLight,
    required this.addressText,
  }) : super(key: key);

  @override
  State<CustomGridTile> createState() => _CustomGridTileState();
}

class _CustomGridTileState extends State<CustomGridTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                widget.imageUrl,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 10,
              left: 15,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20)),
                    height: 36,
                    width: 120,
                    child: Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20)),
                          ),
                          width: 60,
                          child: Center(
                              child: BigText(
                                  size: 20,
                                  color: Colors.white,
                                  text: "${widget.activeLight}")),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                          ),
                          width: 60,
                          child: Center(
                              child: BigText(
                                  size: 20,
                                  color: Colors.white,
                                  text: "${widget.deadLight}")),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        BigText(
          size: 16,
          text: widget.addressText,
        ),
      ],
    );
  }
}
