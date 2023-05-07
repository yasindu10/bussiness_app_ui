import 'package:alllanze_app/pages/manage_date.dart';
import 'package:alllanze_app/pages/view_user.dart';
import 'package:alllanze_app/services/firestore_services.dart';
import 'package:alllanze_app/theme/themes.dart';
import 'package:alllanze_app/widgets/alerts.dart';
import 'package:alllanze_app/widgets/cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as developer;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // auto genarate day
  DateTime? day = DateTime.now();

  //DateFormat.yMMMMd('en_US').format(DateTime.now()),

  // all branches
  List<String> branches = [
    'Colombo',
    'Mathugama',
    'Horana',
    'Badulla',
    'Megahathenna',
  ];

  // current selected branch
  String currentDropdownValue = 'Colombo';

  bool isLoading = false;
  bool isThisDateCreated = false;
  bool thisMonthCreated = false;

  DocumentReference? document;

  // branch selector
  void searchBranch(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: SizedBox(
            width: 300,
            height: 300,
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  setState(() {
                    currentDropdownValue = branches[index];
                  });

                  Navigator.pop(context);
                },
                title: Text(branches[index]),
              ),
            ),
          ),
        ),
      );

  // check selected day was created
  Future<void> checkDayAlredyCreated() async {
    // show loader
    setState(() {
      isLoading = true;
    });

    // check and get data
    document = await FirebaseServices.getSelectedDateData(
      currentDropdownValue,
      '${day?.year}-${DateFormat.MMMM('en_US').format(day!)}',
      '0${DateFormat.d('en_US').format(day!)}',
    );

    // get data (future)
    final checkExists = await document?.get();

    // check alredy exeis
    if (checkExists?.exists ?? false) {
      developer.log('This day was created');
      isThisDateCreated = true;
    } else {
      developer.log("Did't created day on this Date");
      isThisDateCreated = false;
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> checkMonthAlredyExists() async {
    // show loader
    setState(() {
      isLoading = true;
    });

    // check and get data
    QuerySnapshot values = await FirebaseServices.getSelectedMonthData(
      currentDropdownValue,
      '${day?.year}-${DateFormat.MMMM('en_US').format(day!)}',
    );

    if (values.docs.isNotEmpty) {
      thisMonthCreated = true;
    } else {
      thisMonthCreated = false;
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        backgroundColor: Themes.secondaryDark,
        title: const Text(
          'Bussiness App',
          style: TextStyle(
            fontSize: 23,
            // color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ManageDay(),
                )),
            icon: const Icon(Icons.edit_document),
          ),
          IconButton(
            onPressed: () async {
              day = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(3000),
              );

              if (day != null) {
                await checkDayAlredyCreated();
                await checkMonthAlredyExists();
              } else {
                showSnak(context, "Date did't Selected", Colors.black54);
              }
            },
            icon: const Icon(
              Icons.date_range,
            ),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat.yMMMMd('en_US').format(day!),
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 19,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            searchBranch(context);
                            await checkDayAlredyCreated();
                            await checkMonthAlredyExists();
                          },
                          icon: const Icon(Icons.list),
                          label: Text(
                            currentDropdownValue,
                            style: const TextStyle(fontSize: 15),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 85, 155, 247),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  // This Month Total
                  isLoading
                      ? Container()
                      : isThisDateCreated
                          ? StreamBuilder(
                              stream: document!.snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState !=
                                    ConnectionState.waiting) {
                                  return SimpleDataCard(
                                    title: '${DateFormat.MMMM('en_US').format(
                                      day!,
                                    )} Total',
                                    subTitle1: 'Income',
                                    subTitle2: 'Bussiness',
                                    value1: '+1000',
                                    value2: '+100',
                                    color: const Color(0xFF57B3FC),
                                    shodow:
                                        const Color.fromARGB(144, 87, 178, 252),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            )
                          : Container(),
                  const SizedBox(height: 20),
                  // this day
                  isLoading
                      ? Container()
                      : thisMonthCreated
                          ? SimpleDataCard(
                              title: DateFormat.yMMMMd('en_US').format(day!),
                              subTitle1: 'Income',
                              subTitle2: 'Bussiness',
                              value1: '+1000',
                              value2: '+100',
                              color: Themes.primaryDark,
                              shodow: const Color.fromARGB(144, 87, 178, 252),
                            )
                          : Container(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          isLoading
              ? const SliverToBoxAdapter()
              : isThisDateCreated
                  ? StreamBuilder(
                      stream: document!.collection('Businesses').snapshots(),
                      builder: (context, snapshot) => SliverFixedExtentList(
                        itemExtent: 50.0,
                        delegate: SliverChildBuilderDelegate(
                          childCount: snapshot.data?.docs.length ?? 0,
                          (BuildContext context, int index) {
                            return personCard(
                              'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg',
                              'Samantha',
                              'Sales Officer',
                              10,
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewUser(
                                    name: 'Yasindu Samarasinghe',
                                    jobTitle: 'Mobile App Developer',
                                    selectedDate: DateTime.now(),
                                    branch: 'Mathugama',
                                    businessCount: 10,
                                    income: 10000,
                                    profilePic:
                                        'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg',
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : const SliverToBoxAdapter(),
          SliverFillRemaining(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : isThisDateCreated
                    ? Container()
                    : Center(
                        child: didNotCreateDate(),
                      ),
          ),
        ],
      ),
    );
  }
}
