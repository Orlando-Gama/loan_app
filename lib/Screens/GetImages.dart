
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tadza_loan/theme/theme_helper.dart';




class GetImage extends StatefulWidget {
  const GetImage({Key? key}) : super(key: key);

  @override
  State<GetImage> createState() => _GetImageState();
}

class _GetImageState extends State<GetImage> {
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(24  ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 3  ),
          Center(
            child: SizedBox(
              width: 60  ,
              child: Divider(),
            ),
          ),

          SizedBox(
            width: 350  ,
            child: Text(
              "Choose image from ?",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: theme.textTheme.headlineSmall!.copyWith(
                height: 1.50,
              ),
            ),
          ),
          SizedBox(height: 27  ),
          Row(
            children: [
              CircleAvatar(
                child: IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: ()async{
                    final result = await ImagePicker().pickImage(source: ImageSource.camera);
                    Navigator.of(context).pop(File(result!.path));
                  },
                ),
              ),
              SizedBox(width: 10,),

              TextButton(onPressed: ()async{
                final result = await ImagePicker().pickImage(source: ImageSource.camera);
                Navigator.of(context).pop(File(result!.path));
              }, child: Text("Camera"))



              /*  CircleAvatar(
                child: IconButton(
                  icon: Icon(Icons.image),
                  onPressed: () async{
                    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
                    Navigator.of(context).pop(File(result!.path));
                  },
                ),
              )*/
            ],
          ),
          SizedBox(height: 15 ),
          Row(
            children: [



              CircleAvatar(
                child: IconButton(
                  icon: Icon(Icons.image),
                  onPressed: () async{
                    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
                    Navigator.of(context).pop(File(result!.path));
                  },
                ),
              ),
              SizedBox(width: 10,),

              TextButton(onPressed: ()async{
                final result = await ImagePicker().pickImage(source: ImageSource.gallery);
                Navigator.of(context).pop(File(result!.path));
              }, child: Text("Gallery"))


            ],
          ),
          SizedBox(height: 28  ),



        ],
      ),
    );
    /*return Container(
      padding: EdgeInsets.all(10),
      color: Color(0xff016DD1),
      height: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Choose image from ?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "DMsans",
            ),),
          SizedBox(height: 10,),
          Row(
            children: [
              CircleAvatar(
                child: IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: ()async{
                    final result = await ImagePicker().pickImage(source: ImageSource.camera);
                    Navigator.of(context).pop(File(result!.path));
                  },
                ),
              ),
              SizedBox(width: 10,),

              CircleAvatar(
                child: IconButton(
                  icon: Icon(Icons.image),
                  onPressed: () async{
                    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
                    Navigator.of(context).pop(File(result!.path));
                  },
                ),
              )
            ],
          )
        ],
      ),
    );*/
  }
}
