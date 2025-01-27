import 'package:wirebird/inspector/Field.dart';

import 'inspector/Server.dart';

class FieldRetrieval{
  //called in the init main function to populate the different fields without values
  static void populate(Map<String, List<dynamic>> sectionFields){
    sectionFields.addAll({
      "Device": [
        Field(name: "Bluetooth"),
        Field(name: "Network controller (lspci)")],
      "Router": [
        Field(name: "Signal Strength"),
        Field(name: "Link speed"),
        Field(name: "Security"),
        Field(name: "IPv4 Address"),
        Field(name: "IPv6 Address"),
        Field(name: "Hardware Address"),
        Field(name: "Supported Frequencies"),
        Field(name: "Default Route"),
        Field(name: "DNS"),],
      "Inspection": [
        Field(name: "Blocked IPs"),
        Field(name: "Blocked Ports"),
        Field(name: "Automatic Split Tunnel on Block",),
        Field(name:"Wireguard Handshake Interval (Match NAT Session Timeout)",)],
      "Control Center": [
        Field(name: "Whitelisted Networks"),
        Field(name:"Blacklisted Networks"),],
      "VPN Server": [Server()],
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
      case "VPN Server":
        break;
    }
  }
}