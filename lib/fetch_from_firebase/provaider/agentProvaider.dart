import 'dart:core';

import 'package:ami_milk/fetch_from_firebase/models/agentModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AgentProvaider with ChangeNotifier {
  late AgentModel agentModel;
  List<AgentModel> ListOfAgent = [];
  List<String>? ListOfAgentName = [];
  fetchAgentData() async {
    List<AgentModel> newList = [];

    final QuerySnapshot AgentData = await FirebaseFirestore.instance
        .collection("Admin")
        .doc('PG2lndSUQG3e3ju13VEm')
        .collection('Agents')
        .get();

    AgentData.docs.forEach((e) {
      agentModel = AgentModel(
        agentId: e.get('agentId'),
        agentName: e.get('agentName'),
        agentPhone: e.get('agentPhone'),
        agentEmail: e.get('agentEmail'),
      );
      newList.add(agentModel);
    });

    ListOfAgent = newList;

    notifyListeners();
  }

  List<AgentModel> get getAgentDataList {
    return ListOfAgent;
  }

  // List<String>? getAgentName() {
  //   ListOfAgent.forEach((e) {
  //     ListOfAgentName?.add(e.agentName.toString());
  //   });
  //   return ListOfAgentName;
  // }
  List<String>? getAgentName() {
    ListOfAgentName = ListOfAgent.map((e) => e.agentName.toString()).toList();
    return ListOfAgentName;
  }

  String? getAgentId(String agentName) {
    final agent = ListOfAgent.firstWhere((e) => e.agentName == agentName,
        orElse: () => AgentModel());
    return agent.agentId;
  }
}
