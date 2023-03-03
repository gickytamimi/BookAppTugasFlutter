import 'package:book_app/controller/book_controller.dart';
import 'package:book_app/views/detail_book_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
 BookController? bookController;
 // ignore: non_constant_identifier_names
 void State() {
    bookController = Provider.of<BookController>(context, listen: false) ; 
    bookController!.fetchBookApi();
    // 
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Catalogue"),
      ),
      body: Consumer<BookController>(
        child: const Center (child : CircularProgressIndicator()),
        builder: (context, controller, child) => Container(
          child: controller.bookList == null 
          ?  child
          : ListView.builder(itemCount: controller.bookList!.books!.length, itemBuilder: (context, index) {
            final currentBook = controller.bookList!.books![index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailBookPage(
                  isbn:currentBook.isbn13!
                ),),);
                
              },
              child: Row(
                children: [
                  Image.network (currentBook.image!,
                  height: 100,),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric (horizontal : 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(currentBook.title!),
                          Text(currentBook.subtitle!),
                          Align(
                            alignment: Alignment.topRight,
                            child : Text(currentBook.price!)
                          ),
                        ],
                      ),
                    ),
                  )
                ]
              ),
            );
          },),
        ),
      ),
    );
  }
}
