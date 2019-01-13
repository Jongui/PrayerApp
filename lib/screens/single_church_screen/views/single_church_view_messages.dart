import 'package:flutter/material.dart';
import 'package:prayer_app/screens/loading_screen/loading_view.dart';

class SingleChurchViewMessages extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SingleChurchViewMessagesState();
  }

}

class SingleChurchViewMessagesState extends StatefulWidget{
  _SingleChurchViewMessagesState createState() => _SingleChurchViewMessagesState();
}

class _SingleChurchViewMessagesState extends State<SingleChurchViewMessagesState>{
  @override
  Widget build(BuildContext context) {
    return LoadingView();
  }

}