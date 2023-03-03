
// ignore_for_file: file_names
import 'package:book_app/controller/book_controller.dart';
import 'package:book_app/views/image_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailBookPage extends StatefulWidget {
  const DetailBookPage ({Key? key, required this.isbn}) : super(key: key);
  final String isbn;
  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
    BookController? bookController;
    @override
  void initState() {
    super.initState();
    bookController = Provider.of<BookController>(context, listen : false);
     bookController!.fetchDetailBookApi(widget.isbn);  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      body: Consumer<BookController>(
        builder: (context, controller, child) {
          return bookController!.detailBook == null
      ? const Center(child: CircularProgressIndicator ())
      : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                onTap: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder:(context) => 
                      ImageViewScreen (imageUrl: bookController!.detailBook!.image!),
                      ),
                    );
                 },
                 child: Image.network(bookController!.detailBook!.image!,
                  height: 150,
                  ),
              ),
                  Expanded(
                   child: Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(bookController!.detailBook!.title!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),),
                        Text(bookController!.detailBook!.authors!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          // fontWeight: FontWeight.bold
                        ),),
                        const SizedBox(height: 10),
                        Row(
                children: List.generate(5,
                 (index) => Icon(
                  Icons.star,
                  color: index < int.parse(bookController!.detailBook!.rating!) 
                  ? Colors.yellow 
                  : Colors.grey,),
              ),
              // Text(detailBook!.rating!),    
              ),
                        Text(bookController!.detailBook!.subtitle!,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          // fontWeight: FontWeight.bold
                        ),),
                        Text(bookController!.detailBook!.price!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,),),
                      ],
                    ),
                  ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // fixedSize: Size(double.infinity, 50)
                  ),
                  onPressed: () async {
                    Uri uri = Uri.parse(bookController!.detailBook!.url!);
                    try {
                      (await canLaunchUrl(uri)) ? launchUrl(uri) : print ("tidak bisa menampilkan navigasi");
                    } catch (e) {
                      print("Error");
                      print(e);
                    }
                   
                  }, child: Text ("BUY")),
              ),
              SizedBox(height: 20,),
              Text(bookController!.detailBook!.desc!),
              SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              Text("Year : " + bookController!.detailBook!.year!),
              Text("ISBN " + bookController!.detailBook!.isbn13!),
              Text(bookController!.detailBook!.pages! + "Pages"),
              Text("Publisher : " + bookController!.detailBook!.publisher!),
              Text("Language : " + bookController!.detailBook!.language!),
              ],
              ),
              Divider(),
              bookController!.similiarBooks == null 
              ? CircularProgressIndicator()
              : SizedBox(
                height: 180,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: bookController!.similiarBooks!.books!.length,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    final current = bookController!.similiarBooks!.books![index];
                    return SizedBox(
                      width: 100,
                      child: Column(
                        children: [
                          Image.network(current.image!,
                          height: 100,),
                          Text(current.title!,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                          ),),
                        ],
                      ),
                    );
                  }
                ),
              )
            ],),
          );
        }
      )
    );
  }
}