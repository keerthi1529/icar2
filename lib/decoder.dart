import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

class NetworkImageDecoder extends StatefulWidget {
  final String imageUrl;

  NetworkImageDecoder({required this.imageUrl});

  @override
  _NetworkImageDecoderState createState() => _NetworkImageDecoderState();
}

class _NetworkImageDecoderState extends State<NetworkImageDecoder> {
  img.Image? decodedImage;

  @override
  void initState() {
    super.initState();
    _decodeImageFromUrl();
  }

  Future<void> _decodeImageFromUrl() async {
    try {
      final response = await http.get(Uri.parse(widget.imageUrl));
      if (response.statusCode == 200) {
        setState(() {
          final imageBytes = response.bodyBytes;
          decodedImage = img.decodeImage(imageBytes);
        });
      }
    } catch (e) {
      print('Error decoding image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return decodedImage != null
        ? Image.memory(img.encodePng(decodedImage!))
        : CircularProgressIndicator();
  }
}
