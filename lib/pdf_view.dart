import 'package:flutter/material.dart';
import 'package:gp/DatabaseManager.dart';
import 'package:gp/classes/student.dart';
import 'package:gp/classes/studentBehavior.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'Levels.dart';

class pdf_view extends StatefulWidget {
  final student std;
  final ForText forText;
  pdf_view(this.std, this.forText);
  @override
  _pdf_view createState() => _pdf_view(std, forText);
}

class _pdf_view extends State<pdf_view> {
  student std;
  ForText forText;
  _pdf_view(this.std, this.forText);
  DatabaseManager db = DatabaseManager();
  late PdfViewerController _pdfViewerController;
  final GlobalKey<SfPdfViewerState> _pdfViewerStateKey = GlobalKey();
  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime initialTime = DateTime.now();
    final initialHour = initialTime.hour.toString().padLeft(2, '0');
    final initialMinute = initialTime.minute.toString().padLeft(2, '0');
    final initialSecond = initialTime.second.toString().padLeft(2, '0');

    String x = '$initialHour$initialMinute$initialSecond';
    int firstTime = int.parse(x);
    return SafeArea(
        child: Scaffold(
      body: SfPdfViewer.network(
          'https://firebasestorage.googleapis.com/v0/b/graduation-project-a9cdf.appspot.com/o/Revision%2C%20Variables%20%26%20Constants%2FEnglish%2FRevision%2C%20Variables%20%26%20Constants.pdf?alt=media&token=cb4470fe-1b65-48fb-8924-e494e7b2515c',
          controller: _pdfViewerController,
          key: _pdfViewerStateKey),
      appBar: AppBar(
        title: Text('Revision, Variables & Constants'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                _pdfViewerStateKey.currentState!.openBookmarkView();
              },
              icon: Icon(
                Icons.bookmark,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                //   _pdfViewerController.jumpToPage(5);
                _pdfViewerController.lastPage();
              },
              icon: Icon(
                Icons.arrow_drop_down_rounded,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                //   _pdfViewerController.jumpToPage(5);
                _pdfViewerController.firstPage();
              },
              icon: Icon(
                Icons.arrow_drop_up_rounded,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                _pdfViewerController.zoomLevel = 3.25;
              },
              icon: Icon(
                Icons.zoom_in,
                color: Colors.white,
              ))
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            DateTime FinalTime = DateTime.now();
            final FinalHour = FinalTime.hour.toString().padLeft(2, '0');
            final FinalMinute = FinalTime.minute.toString().padLeft(2, '0');
            final FinalSecond = FinalTime.second.toString().padLeft(2, '0');
            x = '$FinalHour$FinalMinute$FinalSecond';
            int SecondTime = int.parse(x);
            ForText NewforText = ForText();
            NewforText.NumberOfVisitedPage = forText.NumberOfVisitedPage + 1;
            NewforText.TimeSpendInPage =
                forText.TimeSpendInPage + (SecondTime - firstTime);
            db.updateStudentBehavior(NewforText.TimeSpendInPage,
                NewforText.NumberOfVisitedPage, "text", std.id);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Levels(1, std)));
            // _selectedIndex-=2;
          },
        ),
      ),
    ));
  }
}