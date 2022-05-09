import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class IndicatorScrolling extends StatelessWidget {
  const IndicatorScrolling({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scrollbar(
          child: ListView.builder(
            itemCount: 50,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                color: Colors.amber,
                child: SizedBox(
                  height: 50,
                  child: Center(
                    child: Text("data ${index + 1}"),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: PdfDocumentLoader.openAsset(
            'assets/example_pdf_landscape.pdf',
            documentBuilder: (context, pdfDocument, pageCount) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return Scrollbar(
                    thickness: 8,
                    radius: const Radius.circular(10),
                    interactive: true,
                    showTrackOnHover: true,
                    child: ListView.builder(
                      itemCount: pageCount,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(8.0),
                          color: Colors.black12,
                          child: PdfPageView(
                            pdfDocument: pdfDocument,
                            pageNumber: index + 1,
                            pageBuilder: (context, textureBuilder, pageSize) {
                              return Stack(
                                children: [
                                  textureBuilder(),
                                  // if (index + 1 == 1) ...[
                                  //   Container(
                                  //     width: 595.0,
                                  //     height: constraints.maxHeight * 0.5,
                                  //     decoration: BoxDecoration(
                                  //       border: Border.all(
                                  //         color: Colors.red,
                                  //       ),
                                  //     ),
                                  //   )
                                  // ]
                                ],
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
