import 'package:alllanze_app/theme/themes.dart';
import 'package:flutter/material.dart';
import 'add_user.dart';

class SelectUsers extends StatelessWidget {
  const SelectUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Themes.secondaryDark,
        title: const Text('Select User'),
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => ListTile(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddUser(
                    jobTitle: 'Mobile Developer',
                    name: 'Yasindu Samarasinghe',
                    profilePic:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOH2aZnIHWjMQj2lQUOWIL2f4Hljgab0ecZQ&usqp=CAU'),
              )),
          title: Text('Yasindu Samarasinghe'),
          subtitle: Text('Mobile App Developer'),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOH2aZnIHWjMQj2lQUOWIL2f4Hljgab0ecZQ&usqp=CAU'),
          ),
        ),
      ),
    );
  }
}
