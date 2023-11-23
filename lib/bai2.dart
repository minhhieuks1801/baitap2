import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class bai2 extends StatefulWidget{
  const bai2({super.key});
  @override
    _ghiChu createState() => _ghiChu();
}

class _ghiChu extends State<bai2>{
  final TextEditingController _txtGhi = TextEditingController();
  List<String> list = [];

  @override
  Widget build(BuildContext context) {
    duyet();
   return Scaffold(
     body: Center(
       child: ListView(
         children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               ElevatedButton(
                 onPressed: () {
                   _nhapTextDialog(context);
                 },
                 child: const Text('Ghi text',
                   style: TextStyle(fontSize: 20, color: Colors.white),
                 ),
               ),
               const SizedBox(
                 width: 10,
               ),

               ElevatedButton(
                 onPressed: () async {
                   SharedPreferences prefs = await SharedPreferences.getInstance();
                   for(int i = 0; i< 10; i++){
                     await prefs.remove('$i');
                   }
                   await prefs.remove('count');
                   setState(() {});
                 },
                 child: const Text('Chụp hình',
                   style: TextStyle(fontSize: 20, color: Colors.white),

                 ),
               ),
               const SizedBox(
                 width: 10,
               ),
               ElevatedButton(
                 onPressed: () {
                   _getSP();
                   setState(() {});
                 },
                 child: const Text('Ghi âm',
                   style: TextStyle(fontSize: 20, color: Colors.white),
                 ),
               ),
             ],
           ),
           const SizedBox(
             height: 10,
           ),
               for(int i = 0; i < list.length; i++)
               ListTile(
                 title: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   mainAxisSize: MainAxisSize.max,
                   children: [
                   SizedBox(
                     width: MediaQuery.of(context).size.width*0.5,
                     child: Text(list[i].toString(),
                     overflow: TextOverflow.ellipsis,
                     ),
                   ),
                   const Expanded(child: SizedBox()),
                   ElevatedButton(
                     onPressed: () {
                       _xemTextDialog(context, list[i].toString());
                     },
                     child: const Text('Xem'),
                   ),
                     const SizedBox(
                       width: 10,
                     ),
                   ElevatedButton(
                     onPressed: () {
                       list.remove(list[i]);
                       setState(() {});
                     },
                     child: const Text('Xóa'),
                   ),
                 ],
                 ),
               ),
             ],
           ),
     ),
   );
  }

  _getSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? listitems = prefs.getStringList('items');
    list = listitems!;

  }

  void duyet(){
    _getSP();
    setState(() {});
  }

  _setSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('items', list);
  }

  _nhapTextDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: TextField(
              controller: _txtGhi,
              decoration: const InputDecoration(hintText: "Nhập nội dung"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Nhập'),
                onPressed: () {
                  Navigator.of(context).pop();
                  list.add(_txtGhi.text);
                  _getSP();
                  _setSP();
                  setState(() {});
                },
              ),
            ],
          );
        });
  }

  _xemTextDialog(BuildContext context, String a) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Scrollbar(
                child: Text(a)
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Canel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }



}