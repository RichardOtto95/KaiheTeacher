import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teacher_side/app/Model/constants.dart';

class SearchCard extends StatelessWidget {
  final String hour, text;
  final bool isActive;
  final VoidCallback press;

  SearchCard({
    this.isActive = true,
    required this.hour,
    required this.press,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            color: MessageColor,
            borderRadius: BorderRadius.circular(7),
          ),
          child: TextButton(
            onPressed: press,
            child: Stack(
              children: [
                Container(
                  // color: isActive ? MessageColor : Colors.white,
                  padding: EdgeInsets.fromLTRB(
                      10, defaultPadding, 10, defaultPadding),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Center(
                            child: SvgPicture.asset(
                              "assets/icons/Icon_mensagem.svg",
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: defaultPadding / 2),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  text,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                hour,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      // color: isActive ? Colors.white : null,
                                      color: Colors.white,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
                // if (true)
                //   Positioned(
                //       right: 8,
                //       top: 8,
                //       child: Container(
                //         height: 12,
                //         width: 12,
                //         decoration: BoxDecoration(
                //           shape: BoxShape.circle,
                //           color: Colors.red,
                //         ),
                //       )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
