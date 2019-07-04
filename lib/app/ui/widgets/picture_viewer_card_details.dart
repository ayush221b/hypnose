import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hypnose/app/models/picture.dart';
import 'package:intl/intl.dart';

class PictureViewerCardDetails extends StatelessWidget {
  const PictureViewerCardDetails({
    Key key,
    @required this.picture,
  }) : super(key: key);

  final Picture picture;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 250,
          width: 300,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(10),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image:
                      CachedNetworkImageProvider(
                          picture.downloadUrl))),
        ),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                "Title",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                    color: Colors.white,
                    fontSize: 16),
              ),
              Text(
                '${picture.title}',
                style: TextStyle(fontSize: 14,color: Colors.white,),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Description",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',color: Colors.white,
                    fontSize: 16),
              ),
              Text(
                '${picture.description}',
                style: TextStyle(fontSize: 14,color: Colors.white,),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Category",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',color: Colors.white,
                    fontSize: 16),
              ),
              Text(
                '${picture.category}',
                style: TextStyle(fontSize: 14,color: Colors.white,),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Added On",
                style: TextStyle(
                    fontWeight: FontWeight.bold,color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 16),
              ),
              Text(
                '${DateFormat.yMMMMd().format(picture.dateTime.toDate())}',
                style: TextStyle(fontSize: 14,color: Colors.white,),
              ),
            ],
          ),
        ),
      ],
    );
  }
}