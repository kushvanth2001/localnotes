

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurinom_notes_app/hivecontroller.dart';
import 'package:qurinom_notes_app/screens/addnotescreen.dart';
import 'package:qurinom_notes_app/screens/opennotescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}
 
class _HomepageState extends State<Homepage> {
 late final SharedPreferences prefs;
  bool containskey=false;
  String username = "";
  String password = "";
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final NoteController noteController = Get.find();
  @override
  void initState() {
    
      takePrefs();
  
     
    super.initState();
   
  }
@override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

 Future takePrefs() async {
     SharedPreferences prefs1 = await SharedPreferences.getInstance();
    
    debugPrint(prefs1.getString("username"));

    setState(() {
    containskey= prefs1.containsKey("username");
    if(containskey){

    username= prefs1.getString("username")!;
    }
 prefs=prefs1;
     
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: containskey?Text("Welcome "+username):Container(),
        actions: [
       containskey?   ElevatedButton(
            onPressed: () {

Get.to(AddNoteScreen(),arguments: ["","","",false]);

            },
            child: Text("Add note"),
          ):Container(),
        ],
      ),
      body:containskey
          ? FutureBuilder(
  future: noteController.fetchNotesFromHive(), 
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
    
      return Center(child: Text('Error: ${snapshot.error}'));
    } else {
    
      return ListView.builder(
        shrinkWrap: true,
        itemCount: noteController.titles.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            child: ListTile(
              onTap: () {
                
                Get.to(OpenNote(title:noteController.titles[index] ,note: noteController.notes[index],datetime: noteController.dateOfCreation[index].toString(),));
              },
              title: Text(noteController.titles[index]),
              subtitle: Text(noteController.notes[index]),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.to(AddNoteScreen(), arguments: [noteController.titles[index], noteController.notes[index], index, true]);
                    },
                    icon: Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () async {
                     noteController.deleteNoteAtIndex(index);
                      setState(() {
                  
                      });
                    },
                    icon: Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  },
)

          : AlertDialog(
              title: Text("Enter the username and password"),
              content: Column(
                children: [
                  SizedBox(
                    height: 60,
                    width: 150,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Name",
                        border: OutlineInputBorder(),
                      ),
                      controller: _usernameController,
                    ),
                  ),

                  SizedBox(
                    height: 60,
                    width: 150,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(),
                      ),
                      controller: _passwordController,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    if (_usernameController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty) {
                    await  prefs.setString("username", _usernameController.text);
                    await  prefs.setString("password", _passwordController.text);
                     /* Get.snackbar(
                        "User Created",
                        "",
                        duration: Duration(milliseconds: 600),
                        backgroundColor: Colors.green,
                      );*/
                      Get.offAll(Homepage());
                    } else {
                      Get.snackbar(
                        "Error",
                        "Please enter valid details",
                        duration: Duration(milliseconds: 600),
                        backgroundColor: Colors.red,
                      );
                    }
                  },
                  child: Text("Create User"),
                ),
              ],
            ),
    );
  }
}
