import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:opencv/core/core.dart';
import 'package:opencv/opencv.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

   final picker =  ImagePicker();
   File? file;
   Image? image;

   Future getImagePicker() async {
   var pickfile= await ImagePicker().pickImage(source: ImageSource.gallery);
    var tempfile= File(pickfile!.path);
    setState(() {
      file= tempfile;
      image = Image.file(tempfile);
    });
   }
   applyFilter() async{
     var bytes=  await file!.readAsBytes(); 
     var res = await ImgProc.blur(
           bytes,
            [45, 45], [20, 30],
             Core.borderReflect);

     setState(() {
       image = Image.memory(res);
     });        
   }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('OPENCV-FLUTTER_APP'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.blueGrey,
              width: double.maxFinite,
              height:80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton.icon(
                    icon: Icon(Icons.add_a_photo),
                    label: Text('ADICIONAR'),
                     onPressed: getImagePicker, 
                    ),
                    FlatButton.icon(
                      icon: Icon(Icons.cancel_outlined),
                    label: Text('CANCELAR'),
                     onPressed: null, 
                    ),
                ],
              ),
            ),
            Expanded( // NESSA PARTE A GENTE IMPRIMI A FOTO NESSE ESPAÇO DO APLICATIVO 
              child: Container( 
                alignment: Alignment.center,
                color: Colors.white,
                child: image!= null ? image:null,
              ),
            ),
              Container(
               color: Colors.blue,
               width: double.maxFinite,
               height: 100,
               child: ListView(
                 scrollDirection: Axis.horizontal,
                 padding: EdgeInsets.all(10.0),
                 children: [
                   //
                    GestureDetector(
                      onTap: applyFilter,
                     child: Container(
                       width: 80,
                       height: 80,
                       color: Colors.white,
                       margin: EdgeInsets.only(right: 7.0),
                       child: Center(child:Text('Blur')),
                     ),
                   ),
                   //
                   Container(
                     width: 80,
                     height: 80,
                     color: Colors.white,
                      margin: EdgeInsets.only(right: 7.0),
                   ),
                   //
                   Container(
                     width: 80,
                     height: 80,
                     color: Colors.white,
                      margin: EdgeInsets.only(right: 7.0),
                   ),
                   //
                   Container(
                     width: 80,
                     height: 80,
                     color: Colors.white,
                      margin: EdgeInsets.only(right: 7.0),
                   ),
                   //
                   Container(
                     width: 80,
                     height: 80,
                     color: Colors.white,
                      margin: EdgeInsets.only(right: 7.0),
                   ),

                 ],
               ),
            ),
          ]
        ),
      ),
    );
  }
}