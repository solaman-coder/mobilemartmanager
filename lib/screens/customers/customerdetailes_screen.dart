import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobilemart/database/models/customer_model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CustomerDetailScreen extends StatelessWidget {
  final CustomerModel customer;

  const CustomerDetailScreen({super.key, required this.customer});
  void generatePdf(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) => [
          pw.Text("Customer Details",
              style:
                  pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 16),
          pw.Text("Name: ${customer.customerName}"),
          pw.Text("Email: ${customer.customerEmail}"),
          pw.Text("Phone: +91 ${customer.customerPhone}"),
          pw.Text("Address: ${customer.customerAdress}"),
          pw.SizedBox(height: 16),
          pw.Text("Purchased Items:",
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 8),
          pw.ListView.builder(
            itemCount: customer.productNames.length,
            itemBuilder: (context, index) {
              return pw.Container(
                margin: const pw.EdgeInsets.only(bottom: 8),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(customer.productNames[index]),
                    pw.Text("Qty: ${customer.quantities[index]}"),
                  ],
                ),
              );
            },
          ),
          pw.Divider(),
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text("Total: ₹${customer.total}",
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          ),
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Details"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(customer.customerName,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                IconButton(
                    onPressed: () {
                      generatePdf(context);
                    },
                    icon: const Icon(
                      Icons.picture_as_pdf,
                      color: Colors.black,
                    ))
              ],
            ),
            Text(customer.customerEmail),
            Text("+91 ${customer.customerPhone}"),
            Text(customer.customerAdress),
            const SizedBox(height: 20),
            const Text("Purchased Items:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: customer.productNames.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading:
                        Image.file(File(customer.imagePaths[index]), width: 50),
                    title: Text(customer.productNames[index]),
                    subtitle: Text("Qty: ${customer.quantities[index]}"),
                  );
                },
              ),
            ),
            const SizedBox(),
            Container(
              width: double.infinity,
              color: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              child: Text(
                'Total: ₹${customer.total}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
