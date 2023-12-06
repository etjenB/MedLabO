import 'package:flutter/material.dart';
import 'package:medlabo_mobile/utils/constants/design.dart';
import 'package:medlabo_mobile/utils/general/util.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class PogledajRezultatScreen extends StatefulWidget {
  final String? rezultatTerminaPDF;

  PogledajRezultatScreen(this.rezultatTerminaPDF, {super.key});

  @override
  State<PogledajRezultatScreen> createState() => _PogledajRezultatScreenState();
}

class _PogledajRezultatScreenState extends State<PogledajRezultatScreen> {
  String? pdfFilePath;

  @override
  void initState() {
    super.initState();
    initForm();
  }

  Future initForm() async {
    String base64Pdf = widget.rezultatTerminaPDF!;
    var file = await createTemporaryFileFromBase64(base64Pdf);
    setState(() {
      pdfFilePath = file;
    });
  }

  Future<void> downloadPDF() async {
    if (pdfFilePath == null) return;

    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory == null) {
      return;
    }

    File sourceFile = File(pdfFilePath!);
    String fileName = sourceFile.uri.pathSegments.last;
    await sourceFile.copy('$selectedDirectory/$fileName');

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('PDF preuzet u $selectedDirectory')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                pdfFilePath == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width,
                        child: SfPdfViewer.file(
                          File(pdfFilePath!),
                        ),
                      ),
                sizedBoxHeightXL,
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ElevatedButton(
                    onPressed: downloadPDF,
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green)),
                    child: const Text('Preuzmi'),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
