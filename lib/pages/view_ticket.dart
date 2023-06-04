import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:tickets/database/sectors.dart';
import 'package:tickets/pages/finish_page.dart';

class ViewTicket extends StatefulWidget {
  final Map data;
  final String id;
  const ViewTicket({super.key, required this.data, required this.id});

  @override
  State<ViewTicket> createState() => _ViewTicketState();
}

class _ViewTicketState extends State<ViewTicket> {
  final format = DateFormat('dd MMMM, yyyy hh:mm', 'es_ES');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 4.0.h,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.red.shade800,
                size: 7.0.w,
              ),
            ),
            SizedBox(
              height: 2.0.h,
            ),
            Text(
              'Detalles de ticket',
              style: TextStyle(
                  color: Colors.red.shade800,
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.bold),
            ),
            const Divider(
              color: Colors.red,
              thickness: 2,
            ),
            SizedBox(
              height: 3.0.h,
            ),
            RichText(
                text: TextSpan(
                    text: 'Contacto:',
                    style: TextStyle(
                        color: Colors.red.shade800,
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.bold),
                    children: [
                  TextSpan(
                      text: ' ${widget.data['name']}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0.sp))
                ])),
            SizedBox(
              height: 3.0.h,
            ),
            FutureBuilder(
                future: SectorsDB().getNameSector(widget.data['idSectors']),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox.shrink();
                  }
                  return RichText(
                      text: TextSpan(
                          text: 'Sector:',
                          style: TextStyle(
                              color: Colors.red.shade800,
                              fontSize: 16.0.sp,
                              fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                            text: ' ${snapshot.data}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0.sp))
                      ]));
                }),
            SizedBox(
              height: 3.0.h,
            ),
            RichText(
                text: TextSpan(
                    text: 'Ubicación:',
                    style: TextStyle(
                        color: Colors.red.shade800,
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.bold),
                    children: [
                  TextSpan(
                      text: ' ${widget.data['address']}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0.sp))
                ])),
            SizedBox(
              height: 3.0.h,
            ),
            RichText(
                text: TextSpan(
                    text: 'Fecha:',
                    style: TextStyle(
                        color: Colors.red.shade800,
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.bold),
                    children: [
                  TextSpan(
                      text:
                          ' ${format.format(widget.data['date'].toDate())} hrs.',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0.sp))
                ])),
            // Text('Fecha: ${widget.data['date'].toDate()}'),
            SizedBox(
              height: 3.0.h,
            ),
            RichText(
                text: TextSpan(
                    text: 'Forma de recepción:',
                    style: TextStyle(
                        color: Colors.red.shade800,
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.bold),
                    children: [
                  TextSpan(
                      text: ' ${widget.data['reception']}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0.sp))
                ])),
            SizedBox(
              height: 3.0.h,
            ),
            RichText(
                text: TextSpan(
                    text: 'Prioridad: ',
                    style: TextStyle(
                        color: Colors.red.shade800,
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.bold),
                    children: [
                  TextSpan(
                      text: widget.data['priority'] == 'low'
                          ? 'Baja'
                          : widget.data['priority'] == 'medium'
                              ? 'Media'
                              : 'Alta',
                      style: TextStyle(
                          color: widget.data['priority'] == 'low'
                              ? Colors.green
                              : widget.data['priority'] == 'medium'
                                  ? Colors.yellow.shade800
                                  : Colors.redAccent,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0.sp))
                ])),
            SizedBox(
              height: 3.0.h,
            ),
            RichText(
                text: TextSpan(
                    text: 'Problema:',
                    style: TextStyle(
                        color: Colors.red.shade800,
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.bold),
                    children: [
                  TextSpan(
                      text: ' ${widget.data['details']}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0.sp))
                ])),
            SizedBox(
              height: 5.0.h,
            ),
            Center(
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red.shade800),
                      minimumSize:
                          MaterialStateProperty.all(Size(80.0.w, 7.0.h))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FinishPage(
                            data: widget.data,
                            id: widget.id,
                          ),
                        ));
                  },
                  child: Text(
                    'Cerrar ticket',
                    style: TextStyle(fontSize: 16.0.sp),
                  )),
            )
            // Text('Problema: ${widget.data['details']}')
          ],
        ),
      ),
    );
  }
}
