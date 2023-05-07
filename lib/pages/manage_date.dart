import 'package:alllanze_app/pages/select_user.dart';
import 'package:alllanze_app/pages/view_user.dart';
import 'package:alllanze_app/theme/themes.dart';
import 'package:alllanze_app/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ManageDay extends StatefulWidget {
  const ManageDay({super.key});

  @override
  State<ManageDay> createState() => ManageDayState();
}

class ManageDayState extends State<ManageDay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        backgroundColor: Themes.secondaryDark,
        title: const Text(
          'Manage Day',
          style: TextStyle(
            fontSize: 20,
            // color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Tooltip(
            message: 'Add A User',
            height: 40,
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectUsers(),
                  )),
              icon: const Icon(Icons.add_circle_rounded),
            ),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat.yMMMMd('en_US').format(DateTime.now()),
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 19,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.location_on,
                          size: 19,
                        ),
                        label: const Text(
                          'Mathugama',
                          style: TextStyle(fontSize: 15),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 85, 155, 247),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
              childCount: 20,
              (context, index) => personCard(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOH2aZnIHWjMQj2lQUOWIL2f4Hljgab0ecZQ&usqp=CAU',
                'Samantha',
                'Sales Officer',
                5,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewUser(
                      branch: 'Mathugama',
                      businessCount: 10,
                      income: 1000,
                      jobTitle: 'Mobile Developer',
                      name: 'Yasindu Samarasinghe',
                      selectedDate: DateTime.now(),
                      profilePic:
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRudDbHeW2OobhX8E9fAY-ctpUAHeTNWfaqJA&usqp=CAU',
                    ),
                  ),
                ),
              ),
            ),
            itemExtent: 50.0,
          )
        ],
      ),
    );
  }
}
