
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthcare_hub/data/models/appointment_model.dart';
import 'package:healthcare_hub/data/models/doctor_model.dart';
import 'package:healthcare_hub/data/models/patient_model.dart';
import 'package:healthcare_hub/core/Const/app_colors.dart';
import 'package:healthcare_hub/core/Const/app_images.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class AppointmentConfirmationScreen extends StatelessWidget {
  const AppointmentConfirmationScreen({
    super.key,
    required this.appointment,
    required this.doctor,
    required this.patient,
  });

  final PatientModel patient;
  final AppointmentModel appointment;
  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text("Appointment Confirmation"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Success Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 60,
                  ),
                  Gap(16),
                  Text(
                    "Your appointment is confirmed",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gap(8),
                  Text(
                    "Here are the details of your upcoming appointment. You can download this information as a PDF for your records.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            Gap(24),
            
            // Doctor Information Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.blue.withOpacity(0.3),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Doctor Avatar
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: doctor.imageUrl != null && doctor.imageUrl!.isNotEmpty
                          ? NetworkImage(doctor.imageUrl!)
                          : AssetImage(
                              doctor.gender?.toLowerCase() == 'female'
                                  ? AppImages.femalePatient
                                  : AppImages.malePatient,
                            ) as ImageProvider,
                    ),
                  ),
                  Gap(16),
                  Text(
                    "Dr. ${doctor.firstName} ${doctor.lastName}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Gap(4),
                  Text(
                    doctor.hospitalName ?? "Medico Health Center",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  Gap(4),
                  Text(
                    doctor.specialization ?? "General Medicine",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            
            Gap(24),
            
            // Appointment Details Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow(
                    icon: Icons.person,
                    label: "Patient Name",
                    value: "${patient.firstName} ${patient.lastName}",
                  ),
                  _buildDetailRow(
                    icon: Icons.calendar_today,
                    label: "Appointment Date",
                    value: DateFormat('EEEE, dd MMM yyyy').format(appointment.date),
                  ),
                  _buildDetailRow(
                    icon: Icons.access_time,
                    label: "Time",
                    value: appointment.timeSlot,
                  ),

                  if (appointment.notes != null && appointment.notes!.isNotEmpty)
                    _buildDetailRow(
                      icon: Icons.notes,
                      label: "Notes",
                      value: appointment.notes!,
                    ),
                ],
              ),
            ),
            
            Gap(32),
            
            // Download PDF Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _downloadPDF(context),
                icon: Icon(Icons.picture_as_pdf, size: 24),
                label: Text(
                  "Download PDF",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
              ),
            ),
            
            Gap(16),
            
            // Preview PDF Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _previewPDF(context),
                icon: Icon(Icons.preview, size: 24),
                label: Text(
                  "Preview PDF",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: BorderSide(color: AppColors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.blue, size: 20),
          Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                Gap(4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<pw.Document> _generatePDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            padding: pw.EdgeInsets.all(32),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header
                pw.Center(
                  child: pw.Text(
                    "APPOINTMENT CONFIRMATION",
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue800,
                    ),
                  ),
                ),
                pw.SizedBox(height: 32),
                
                // Doctor Information
                pw.Container(
                  padding: pw.EdgeInsets.all(16),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.blue50,
                    borderRadius: pw.BorderRadius.circular(8),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "DOCTOR INFORMATION",
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.blue800,
                        ),
                      ),
                      pw.SizedBox(height: 12),
                      pw.Text("Dr. ${doctor.firstName} ${doctor.lastName}"),
                      pw.Text("${doctor.specialization ?? 'General Medicine'}"),
                      pw.Text("${doctor.hospitalName ?? 'Medico Health Center'}"),
                    ],
                  ),
                ),
                
                pw.SizedBox(height: 24),
                
                // Appointment Details
                pw.Container(
                  padding: pw.EdgeInsets.all(16),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey300),
                    borderRadius: pw.BorderRadius.circular(8),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "APPOINTMENT DETAILS",
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.blue800,
                        ),
                      ),
                      pw.SizedBox(height: 12),
                      _buildPdfDetailRow("Patient Name", "${patient.firstName} ${patient.lastName}"),
                      _buildPdfDetailRow("Appointment Date", DateFormat('EEEE, dd MMM yyyy').format(appointment.date)),
                      _buildPdfDetailRow("Time", appointment.timeSlot),
                      // _buildPdfDetailRow("Appointment ID", appointment.id ?? "123456789"),
                      if (appointment.notes != null && appointment.notes!.isNotEmpty)
                        _buildPdfDetailRow("Notes", appointment.notes!),
                    ],
                  ),
                ),
                
                pw.SizedBox(height: 32),
                
                // Footer
                pw.Center(
                  child: pw.Text(
                    "Please arrive 15 minutes before your appointment time.\nBring a valid ID and insurance card.",
                    style: pw.TextStyle(
                      fontSize: 12,
                      color: PdfColors.grey600,
                    ),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
                
                pw.Spacer(),
                
                pw.Center(
                  child: pw.Text(
                    "Generated on ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now())}",
                    style: pw.TextStyle(
                      fontSize: 10,
                      color: PdfColors.grey500,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    return pdf;
  }

  pw.Widget _buildPdfDetailRow(String label, String value) {
    return pw.Padding(
      padding: pw.EdgeInsets.only(bottom: 8),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 120,
            child: pw.Text(
              "$label:",
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Expanded(
            child: pw.Text(value),
          ),
        ],
      ),
    );
  }

  Future<void> _downloadPDF(BuildContext context) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );

      final pdf = await _generatePDF();
      
      // Get the directory to save the file
      final directory = await getApplicationDocumentsDirectory();
      final fileName = 'appointment_confirmation_${appointment.title ?? DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File('${directory.path}/$fileName');
      
      // Save the PDF
      await file.writeAsBytes(await pdf.save());
      
      // Close loading dialog
      Navigator.of(context).pop();
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PDF downloaded successfully!'),
          backgroundColor: Colors.green,
          action: SnackBarAction(
            label: 'Open',
            textColor: Colors.white,
            onPressed: () async => Printing.sharePdf(bytes: await pdf.save()),
          ),
        ),
      );
    } catch (e) {
      // Close loading dialog
      Navigator.of(context).pop();
      
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error downloading PDF: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _previewPDF(BuildContext context) async {
    try {
      final pdf = await _generatePDF();
      
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
        name: 'appointment_confirmation.pdf',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error previewing PDF: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}





