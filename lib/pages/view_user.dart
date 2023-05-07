import 'package:alllanze_app/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ViewUser extends StatefulWidget {
  const ViewUser({
    super.key,
    required this.name,
    required this.jobTitle,
    required this.selectedDate,
    required this.branch,
    required this.businessCount,
    required this.income,
    required this.profilePic,
  });

  final String name;
  final String jobTitle;
  final DateTime selectedDate;
  final String branch;
  final int businessCount;
  final double income;
  final String profilePic;

  @override
  State<ViewUser> createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  late TextEditingController _bussinessCount;
  late TextEditingController _income;

  @override
  void initState() {
    super.initState();
    _bussinessCount = TextEditingController();
    _income = TextEditingController();
  }

  @override
  void dispose() {
    _bussinessCount.dispose();
    _income.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Themes.secondaryDark,
        title: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 0),
          title: Text(
            widget.name,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            widget.jobTitle,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              widget.profilePic,
            ),
          ),
        ),
        actions: [
          Tooltip(
            message: 'Add PDF File',
            height: 40,
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () async {},
              icon: const Icon(
                Icons.note_add,
              ),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: Column(
                children: [
                  Row(
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
                      Tooltip(
                        message: 'Branch',
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton.icon(
                          autofocus: false,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.location_on,
                            size: 19,
                          ),
                          label: const Text(
                            'Mathugama',
                            style: const TextStyle(fontSize: 15),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 85, 155, 247),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 25),
                  TextField(
                    decoration:
                        const InputDecoration(labelText: "Bussiness Count"),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ], // Only numbers can be entered
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: const InputDecoration(labelText: "Income"),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ], // Only numbers can be entered
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
              childCount: 10,
              (context, index) => GestureDetector(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                  child: PhysicalModel(
                    color: const Color.fromARGB(221, 244, 67, 54),
                    elevation: 18,
                    shadowColor: const Color.fromARGB(120, 255, 82, 82),
                    borderRadius: BorderRadius.circular(10),
                    child: ListTile(
                        leading: const Icon(
                          Icons.picture_as_pdf_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                        title: Text(
                          'PDF File',
                          style: const TextStyle(
                            fontSize: 17,
                            //COLOR DEL TEXTO TITULO
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          'File Type', // file type
                          style: const TextStyle(
                            fontSize: 16,
                            //COLOR DEL TEXTO TITULO
                            color: Colors.white,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            // showSnak(
                            //     context,
                            //     '${name[index]} this file was deleted',
                            //     Colors.redAccent);
                            // name.removeAt(index);
                            // extension.removeAt(index);
                            // path.removeAt(index);

                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ),
              ),
            ),
            itemExtent: 70.0,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: Themes.secondaryDark,
                ),
                onPressed: () {},
                child: const Text(
                  'Upgrade User',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
