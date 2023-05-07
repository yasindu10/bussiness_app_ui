import 'package:flutter/material.dart';

class SimpleDataCard extends StatelessWidget {
  const SimpleDataCard(
      {super.key,
      required this.title,
      required this.subTitle1,
      required this.subTitle2,
      required this.value1,
      required this.value2,
      required this.color,
      required this.shodow});

  final String title;
  final String subTitle1;
  final String subTitle2;
  final String value1;
  final String value2;
  final Color color;
  final Color shodow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: shodow,
            offset: const Offset(9, 9),
            blurRadius: 6,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        subTitle1,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        value1,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        subTitle2,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        value2,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget personCard(String personImageAsset, String title, String subtitle,
        int bussinessCount, var data) =>
    GestureDetector(
      onTap: data,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(personImageAsset),
            maxRadius: 17,
          ),
          trailing: Text('$bussinessCount Business'),
        ),
      ),
    );

Widget didNotCreateDate() => Column(
      children: [
        const Text(
          'NO CREATED DATE',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          "Click this button to create a day",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 90,
              vertical: 10,
            ),
          ),
          child: const Text('CREATE DAY'),
        ),
      ],
    );
