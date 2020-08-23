import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/app/app_module.dart';
import 'package:ifmaacessivel/src/auth/auth.dart';
import 'package:ifmaacessivel/src/models/user.dart';
import 'package:ifmaacessivel/src/shared/widgets/float_page.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Perfil"),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection(AppModule.to.getDependency<Auth>().getUserId())
            .document("usuario")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              return Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height / 3.25,
                            width: double.infinity,
                            decoration: new BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).accentColor,
                                  blurRadius: 5.0,
                                  spreadRadius: 2.0,
                                )
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                  child: new Container(
                                    width: MediaQuery.of(context).size.height /
                                        4.5,
                                    height: MediaQuery.of(context).size.height /
                                        4.5,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                          User.image,
                                          scale: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    image = await ImagePicker.pickImage(
                                        source: ImageSource.gallery);
                                    print(image.path);
                                    addImageToFirebase();
                                  },
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => FloatPage(),
                                          );
                                        },
                                        child: Icon(
                                          Icons.settings,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Campus",
                                  style: Theme.of(context).textTheme.title,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  snapshot.data['campus'],
                                  style: Theme.of(context).textTheme.headline,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "Encarregado(a)",
                                  style: Theme.of(context).textTheme.title,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  snapshot.data['encarregado'],
                                  style: Theme.of(context).textTheme.headline,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "E-mail",
                                  style: Theme.of(context).textTheme.title,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  snapshot.data['email'],
                                  style: Theme.of(context).textTheme.headline,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "Telefone",
                                  style: Theme.of(context).textTheme.title,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  snapshot.data['telefone'],
                                  style: Theme.of(context).textTheme.headline,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "Endereço",
                                  style: Theme.of(context).textTheme.title,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  snapshot.data['endereco'],
                                  style: Theme.of(context).textTheme.headline,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }

  Future<void> addImageToFirebase() async {
    FirebaseStorage _storage = FirebaseStorage.instance;
    StorageReference ref = _storage.ref();
    String downloadUrl1;
    StorageUploadTask storageUploadTask =
        ref.child("image_" + User.responsible + ".jpg").putFile(image);

    if (storageUploadTask.isSuccessful || storageUploadTask.isComplete) {
      final String url = await ref.getDownloadURL();
      print("The download URL is " + url);
    } else if (storageUploadTask.isInProgress) {
      storageUploadTask.events.listen((event) {
        double percentage = 100 *
            (event.snapshot.bytesTransferred.toDouble() /
                event.snapshot.totalByteCount.toDouble());
        print("The percentage " + percentage.toString());
      });

      StorageTaskSnapshot storageTaskSnapshot =
          await storageUploadTask.onComplete;
      downloadUrl1 = await storageTaskSnapshot.ref.getDownloadURL();
      print("Download URL " + downloadUrl1.toString());
    } else {}
    Firestore.instance
        .collection(AppModule.to.getDependency<Auth>().getUserId())
        .document("image")
        .setData({'url': downloadUrl1.toString()});
    setState(() {
      User.image = downloadUrl1;
    });
  }
}
