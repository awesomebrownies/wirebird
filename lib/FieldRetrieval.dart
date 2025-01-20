import 'package:wirebird/inspector/Field.dart';

import 'inspector/Server.dart';

class FieldRetrieval{
  //called in the init main function to populate the different fields without values
  static void populate(Map<String, List<dynamic>> sectionFields){
    sectionFields.addAll({
      "Device": [Field(name: "Bluetooth")],
      "Router": [Field(name: "Type")],
      "Inspection": [Field(name: "Blocked")],
      "Control Center": [Field(name: "Trusted Networks")],
      "Proxy Server": [Server()],
    });

  }

  void update(String selectableID){
    switch (selectableID) {
      case "Device":
        break;
      case "Router":
        break;
      case "Inspection":
        break;
      case "Control Center":
        break;
      case "Proxy Server":
        break;
    }
  }
}