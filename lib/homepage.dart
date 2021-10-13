// ignore_for_file: use_key_in_widget_constructors, must_be_immutable
// ignore_for_file: prefer_const_constructors

// run "flutter pub get cached_network_image" to install cached_network_image dependency

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final assetImages = [
    'https://cdn.discordapp.com/attachments/892453181966143528/896762028411224124/flysafe.png',
    'https://cdn.discordapp.com/attachments/892453181966143528/896759101999161364/2.png',
  ];

  List<String> imgURLs = [
    'https://gttp.imgix.net/199790/x/0/ultimate-guide-palawan.jpg?ar=1.91%3A1&w=1200&fit=crop',
    'https://www.lakwatsero.com/wp-content/uploads/2017/11/Caramoan.jpg',
    'https://cdn.discordapp.com/attachments/892453181966143528/896763686990020628/airline.png',
    
  ];

  List<Widget> countrySheets = [
    Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Australia is abundant with unique experiences and awe-inspiring landscapes. There’s a well-known vibrancy in its natural beauty, but don’t forget to seek out its history and culture as well. There's plenty here to inspire your future travel plans so, go on, take a look around and let yourself dream of all the possibilities.",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        )),
    Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "India is on the bucket list for many travelers, and it’s no mystery why! The diverse landscape, colorful festivals, and spicy-hot cuisine are already reasons enough to pack your bags to visit Mumbai or Varanasi.",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        )),
    Container(
        decoration: BoxDecoration(
          shape:BoxShape.circle,
          color:Colors.blue,
        ),
        margin: EdgeInsets.all(25.0),
        padding: EdgeInsets.all(40.0),
    ),
  ];
   @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              
              buildIntro(),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView(
                  children: [
                    //for carousel slider
                    CarouselSlider.builder(
                      options: CarouselOptions(
                        height: 260,
                        autoPlay: true,
                        //pageSnapping: false,
                        //enlargeStrategy: CenterPageEnlargeStrategy.height,
                        autoPlayInterval: Duration(seconds: 6),
                        viewportFraction: 1,
                        //enlargeCenterPage: true,
                      ),
                      itemCount: assetImages.length,
                      itemBuilder: (context, index, realIndex) {
                        final assetImage = assetImages[index];
                        return buildImage(assetImage, index);
                      },
                    ),
                    SizedBox(height: 50),
                    Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: RichText(
                          textAlign: TextAlign.end,
                          text: TextSpan(
                            text: "Fly ",
                            style: TextStyle(fontSize: 25, color: Colors.deepOrange),
                            children: const <TextSpan>[
                              TextSpan(
                                text: "with us",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    for (int i = 0; i < imgURLs.length; i++)
                      buildImageWidgets(
                          context, this.imgURLs[i], this.countrySheets[i]),
                    Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: RichText(
                          textAlign: TextAlign.end,
                          text: TextSpan(
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.bold),
                            children: const <TextSpan>[
                              TextSpan(
                                text: "Book your tickets now!",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              )
            ]),
      );

  Widget buildIntro() {
    return Stack(children: [
      Column(children: const <Widget>[
        Padding(padding: EdgeInsets.only(top: 50)),
        Text.rich(
          TextSpan(
              text: "Welcome to",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40.0,
                color: Colors.deepOrange
              ),
              children: [
                TextSpan(
                  text: "\n Flightly!",
                  style: TextStyle(
                    color:Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 40.0,
                  ),
                ),
              ]),
        )
      ]),
    ]);
  }

  Widget buildImage(String assetImage, int index) {
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 8),
      color: Colors.transparent,
      child: ClipRRect(
        //borderRadius: BorderRadius.circular(20),
        child: FadeInImage.assetNetwork(
          placeholder: "assets/loading-fast.gif",
          image: assetImage,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }

  Widget buildImageWidgets(
      BuildContext context, String imgURLs, Widget countrySheets) {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.transparent,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
                offset: Offset(4, 4),
              )
            ]),
        child: Stack(
          alignment: Alignment.center,
          children: [
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50),
                  )),
                  context: context,
                  builder: (builder) => countrySheets,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: imgURLs,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ],
        ));
  }
}
