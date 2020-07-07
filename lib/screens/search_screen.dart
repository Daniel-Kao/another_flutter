import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(15, 30, 20, 0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: Container(
                height: 30,
                // padding: ,
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  strutStyle: StrutStyle(
                    fontSize: 16.0,
                    height: 1,
                  ),
                  decoration: InputDecoration(
                    fillColor: Colors.grey.withOpacity(0.4),
                    filled: true,
                    prefixIcon: Icon(
                      Icons.search,
                      size: 22,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: EdgeInsets.only(top: 5),
                    hintText: '搜索',
                    hintStyle: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  autofocus: true,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  '取消',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
