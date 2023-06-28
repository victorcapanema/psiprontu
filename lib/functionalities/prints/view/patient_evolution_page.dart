import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:prontuario/widgets/c_circular_progress_indicator.dart';
import '../controller/patient_evolution_controller.dart';

class PatientEvolutionPage extends StatefulWidget {
  const PatientEvolutionPage({required this.patientId, Key? key}) : super(key: key);

  final String? patientId;

  @override
  State<PatientEvolutionPage> createState() => _PatientEvolutionPageState();
}

class _PatientEvolutionPageState extends State<PatientEvolutionPage> {
  final patientEvolutionController = Modular.get<PatientEvolutionController>();

  @override
  void initState() {
    patientEvolutionController.initialState(widget.patientId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.max,
              children: [
                if (patientEvolutionController.isLoading())
                  Flexible(
                    child: Scaffold(
                      body: Padding(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),
                        child: const Center(child: CCircularProgressIndicator()),
                      ),
                    ),
                  ),
                if (patientEvolutionController.isError())
                  Flexible(
                    child: Scaffold(
                      body: Padding(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),
                        child: Center(
                            child:
                                Text(patientEvolutionController.errorMessage, style: const TextStyle(color: Colors.red))),
                      ),
                    ),
                  ),
                if (patientEvolutionController.isSuccess())
                  Flexible(
                    child: PdfPreview(
                      build: (format) => _generatePdf(format),
                    ),
                  )
              ],
            ));
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final ByteData image = await rootBundle.load('images/butterfly.jpeg');
    Uint8List imageData = (image).buffer.asUint8List();

    pdf.addPage(
      pw.MultiPage(
        footer: (context) {
          return pw.Center(
              child: pw.Text('(31) 99914-1848 | Rua Inconfidência, 357, sala 102. Centro. Betim',
                  style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)));
        },
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return <pw.Widget>[
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(
                    child: pw.SizedBox(
                        height: 200,
                        width: 200,
                        child: pw.Opacity(opacity: 0.5, child: pw.Image(pw.MemoryImage(imageData))))),
                pw.Center(child: pw.Text('LUDMILA CAPANEMA')),
                pw.Center(child: pw.Text('PSICÓLOGA', style: const pw.TextStyle(fontSize: 10))),
                pw.SizedBox(height: 16),
                pw.Text('Prontuario Psicológico', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 4),
                pw.SizedBox(
                    child: pw.Text('Número:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10))),
                pw.SizedBox(height: 4),
                pw.Stack(children: [
                  pw.RichText(
                      text: pw.TextSpan(children: [
                    pw.TextSpan(text: 'Nome: ', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                    pw.TextSpan(
                        text:
                            '${patientEvolutionController.patient.name} ${patientEvolutionController.patient.surname}',
                        style: const pw.TextStyle(fontSize: 10)),
                  ])),
                  pw.Padding(
                      padding: const pw.EdgeInsets.fromLTRB(322, 0, 0, 0),
                      child: pw.RichText(
                          text: pw.TextSpan(children: [
                        pw.TextSpan(
                            text: 'Data de Nascimento: ',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10)),
                        pw.TextSpan(
                            text: DateFormat('dd/MM/yyyy').format(patientEvolutionController.patient.dateBorn!),
                            style: const pw.TextStyle(fontSize: 10))
                      ]))),
                ]),
                pw.SizedBox(height: 4),
                pw.Stack(children: [
                  pw.RichText(
                      text: pw.TextSpan(children: [
                    pw.TextSpan(text: 'Endereço: ', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                    pw.TextSpan(
                        text: patientEvolutionController.patient.address, style: const pw.TextStyle(fontSize: 10)),
                  ])),
                  pw.Padding(
                      padding: const pw.EdgeInsets.fromLTRB(322, 0, 0, 0),
                      child: pw.RichText(
                          text: pw.TextSpan(children: [
                        pw.TextSpan(text: 'CPF: ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10)),
                        pw.TextSpan(
                            text: patientEvolutionController.patient.cpf, style: const pw.TextStyle(fontSize: 10))
                      ]))),
                ]),
                pw.SizedBox(height: 4),
                pw.Stack(children: [
                  pw.RichText(
                      text: pw.TextSpan(children: [
                    pw.TextSpan(
                        text: 'Iniciado em: ', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                    pw.TextSpan(
                        text: DateFormat('dd/MM/yyyy').format(patientEvolutionController.patient.dateStart!),
                        style: const pw.TextStyle(fontSize: 10)),
                  ])),
                  pw.Padding(
                      padding: const pw.EdgeInsets.fromLTRB(322, 0, 0, 0),
                      child: pw.RichText(
                          text: pw.TextSpan(children: [
                        pw.TextSpan(
                            text: 'Finalizado em: ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10)),
                        pw.TextSpan(
                            text: DateFormat('dd/MM/yyyy').format(patientEvolutionController.patient.dateEnd!),
                            style: const pw.TextStyle(fontSize: 10))
                      ]))),
                ]),
                pw.SizedBox(height: 4),
                pw.Stack(children: [
                  pw.RichText(
                      text: pw.TextSpan(children: [
                    pw.TextSpan(text: 'Psicóloga: ', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                    const pw.TextSpan(text: 'Ludmila Amaral Capanema', style: pw.TextStyle(fontSize: 10)),
                  ])),
                  pw.Padding(
                      padding: const pw.EdgeInsets.fromLTRB(322, 0, 0, 0),
                      child: pw.RichText(
                          text: pw.TextSpan(children: [
                        pw.TextSpan(text: 'CRP: ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10)),
                        const pw.TextSpan(text: '04/23909', style: pw.TextStyle(fontSize: 10))
                      ]))),
                ]),
                pw.SizedBox(height: 30),
                pw.RichText(
                    text: pw.TextSpan(children: [
                  pw.TextSpan(
                      text: 'Queixa Principal: ', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                  pw.TextSpan(
                      text: patientEvolutionController.patient.complaint, style: const pw.TextStyle(fontSize: 10))
                ])),
                pw.SizedBox(height: 10),
                pw.RichText(
                    text: pw.TextSpan(children: [
                  pw.TextSpan(
                      text: 'Uso de Medicação: ', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                  pw.TextSpan(
                      text: patientEvolutionController.patient.medication, style: const pw.TextStyle(fontSize: 10))
                ])),
                pw.SizedBox(height: 30),
                for (var i in patientEvolutionController.listAppointments)
                  pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                    pw.RichText(
                        text: pw.TextSpan(children: [
                      pw.TextSpan(text: 'Data: ', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                      pw.TextSpan(
                          text: DateFormat('dd/MM/yyyy').format(i.dateAppointment!),
                          style: const pw.TextStyle(fontSize: 10))
                    ])),
                    pw.SizedBox(height: 2),
                    pw.Text(i.dataAppointment),
                    pw.SizedBox(height: 8),
                  ])
              ],
            )
          ];
        },
      ),
    );

    return pdf.save();
  }
}
