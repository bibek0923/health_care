import 'package:flutter/material.dart';
import 'package:healthcare_hub/core/Const/app_colors.dart';
import 'package:healthcare_hub/core/widgets/custom_appbar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// class PdfViewerScreen extends StatelessWidget {
//   final String url;
//   const PdfViewerScreen({key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: CustomAppBar(title: "Pdf viewer",goBack: true,),
//       body: Center(
//         child: Text("Currently Not Available"),
//       ),
//     );
//   }
// }
class PdfViewerScreen extends StatelessWidget {
  const PdfViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: "Pdf viewer",goBack: true,),
      body: Center(
        child: Text("Currently Not Available"),
      ),
    ) ;
  }
}