import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pembekalan_flutter/views/submenu/detail/detailimagescreen.dart';

class ImagingSliderScreen extends StatefulWidget {
  const ImagingSliderScreen({super.key});

  @override
  State<ImagingSliderScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ImagingSliderScreen> {
  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls = [
      'https://staticg.sportskeeda.com/editor/2023/11/a167a-17011347520349-1920.jpg',
      'https://cdn.oneesports.id/cdn-data/sites/2/2022/03/Naruto-Uzumaki.jpg',
      'https://www.retorika.id/gambar_artikel/29unnamed.jpg',
      'https://fwmedia.fandomwire.com/wp-content/uploads/2024/02/15053436/Kaiju-No.-8-1.jpg',
      'https://static1.srcdn.com/wordpress/wp-content/uploads/2022/10/Anya-Forger-in-Spy-X-Family-anime.jpg',
      'https://static1.srcdn.com/wordpress/wp-content/uploads/2023/08/bleach-kenpachi-zaraki-shikai.jpg'
    ];

    //konversi list url menjadi items Carousel
    final List<Widget> imageSliderItems = imageUrls
        .map((item) => Container(
              margin: EdgeInsets.all(5),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: GestureDetector(
                  onTap: () {
                    // aksi jika image di tap
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailImageScreen(urlImage: item)));
                  },
                  child: Stack(
                    children: [
                      Image.network(
                        item,
                        fit: BoxFit.cover,
                        width: 1000,
                      ),
                      Positioned(
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.black45, Colors.amberAccent],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter)),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Text(
                            'Gambar ke ${imageUrls.indexOf(item) + 1}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                        bottom: 0,
                        left: 0,
                        right: 0,
                      )
                    ],
                  ),
                ),
              ),
            ))
        .toList();

    int currentPosition = 0;

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Image Slider'),
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          backgroundColor: Colors.amberAccent,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CarouselSlider(
              items: imageSliderItems,
              options: CarouselOptions(
                autoPlay: false,
                aspectRatio: 2,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                onPageChanged: (index, reason) {
                  setState(() {
                    // mengubah index posisi image
                    currentPosition = index;
                    // mau diapakan proses selanjutnya
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
