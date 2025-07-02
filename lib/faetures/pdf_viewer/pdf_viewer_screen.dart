import 'package:flutter/material.dart';
import 'package:healthcare_hub/core/Const/app_colors.dart';
import 'package:healthcare_hub/core/widgets/custom_appbar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatelessWidget {
  final String url;
  const PdfViewerScreen({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: "Pdf viewer",goBack: true,),
      body: SfPdfViewer.network(url,),
    );
  }
}
