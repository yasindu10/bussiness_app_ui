import 'package:alllanze_app/res/file_managements.dart';
import 'package:alllanze_app/theme/themes.dart';
import 'package:alllanze_app/widgets/alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// when admin select a user navigate to this screen (add user data)

class AddUser extends StatefulWidget {
  const AddUser(
      {super.key,
      required this.name,
      required this.profilePic,
      required this.jobTitle});

  final String name;
  final String profilePic;
  final String jobTitle;

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  List<String?> path = [];
  List<String?> name = [];
  List<String?> extension = [];

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
              onPressed: () async {
                final result = await pickFile(['pdf']);

                if (result != null) {
                  setState(() {
                    path.add(result.files.single.path);
                    name.add(result.files.single.name);
                    extension.add(result.files.single.extension);
                  });

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PdfViewFrame(
                          pdfPath: result.files.single.path!,
                          pdfName: result.files.single.name,
                        ),
                      ));
                }
              },
              icon: Icon(
                Icons.note_add,
              ),
            ),
          )
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
              childCount: path.length,
              (context, index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
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
                        name[index]!,
                        style: const TextStyle(
                          fontSize: 17,
                          //COLOR DEL TEXTO TITULO
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        '${extension[index]!.toUpperCase()} File',
                        style: const TextStyle(
                          fontSize: 16,
                          //COLOR DEL TEXTO TITULO
                          color: Colors.white,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          showSnak(
                              context,
                              '${name[index]} this file was deleted',
                              Colors.redAccent);
                          name.removeAt(index);
                          extension.removeAt(index);
                          path.removeAt(index);

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
                  'Add User',
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

class PdfViewFrame extends StatelessWidget {
  const PdfViewFrame({super.key, required this.pdfPath, required this.pdfName});

  final String? pdfPath;
  final String? pdfName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Themes.secondaryDark,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
          title: Text(pdfName ?? 'PDF View'),
        ),
        body: PDFView(
          filePath: pdfPath,
          enableSwipe: true,
          swipeHorizontal: false,
          autoSpacing: false,
          pageFling: false,
        ));
  }
}
