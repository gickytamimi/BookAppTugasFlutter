import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:book_app/Models/book_list_response.dart';
import 'package:book_app/views/detail_book_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;


class BookController extends ChangeNotifier {
   Book_List_Response? bookList;
  fetchBookApi() async {
    var url = Uri.parse('https://api.itbook.store/1.0/new');
    var response =
        await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');


if (response.statusCode == 200){
final jsonBookList = jsonDecode(response.body);
bookList = Book_List_Response.fromJson(jsonBookList);
notifyListeners();
}
  
    // print(await http.read(Uri.https('example.com', 'foobar.txt')));
  }
}