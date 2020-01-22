import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/pages/checklist/checklist_bloc.dart';
import 'package:ifmaacessivel/src/pages/checklist/checklist_module.dart';
import 'package:ifmaacessivel/src/shared/widgets/checklist_card.dart';

class ChecklistPage extends StatefulWidget {
  @override
  _ChecklistPageState createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  //final _CheckclistBloc = ChecklistModule.to.getBloc<ChecklistBloc>();
  int _selectedRadio;


  @override
  void initState() {
    _selectedRadio = 0;
    super.initState();
  }

  void _setSelectedRadio(int val) {
    setState(() {
      _selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CheckList"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection("criterios_de_acessibilidade")
            .document("calcada")
            .collection("geral")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              return ListView(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      children: snapshot.data.documents
                          .map(
                            (document) => ChecklistCard(
                              document.data['texto'],
                            ),
                          )
                          .toList(),
                    ),
                  )
                ],
              );
          }
        },
      ),
    );
  }
}
