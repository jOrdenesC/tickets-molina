import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:tickets/database/addresses.dart';
import 'package:tickets/database/sectors.dart';
import 'package:tickets/pages/finish_page_red.dart';
import 'package:tickets/pages/pending_page_red.dart';

class ViewTicketRed extends StatefulWidget {
  final Map data;
  final String id;
  const ViewTicketRed({super.key, required this.data, required this.id});

  @override
  State<ViewTicketRed> createState() => _ViewTicketRedState();
}

class _ViewTicketRedState extends State<ViewTicketRed> {
  final format = DateFormat('dd MMMM, yyyy hh:mm', 'es_ES');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                color: Colors.red.shade800,
                thickness: 2.0,
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
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                    TextSpan(
                      text: ' ${widget.data['name']}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0.sp),
                    )
                  ])),
              SizedBox(
                height: 2.0.h,
              ),
              FutureBuilder(
                future:
                    AddressesDB().getNameAddresses(widget.data['addresses']),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox.shrink();
                  }
                  return RichText(
                      text: TextSpan(
                          text: 'Dirección:',
                          style: TextStyle(
                            color: Colors.red.shade800,
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                        TextSpan(
                          text: ' ${snapshot.data}',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0.sp),
                        )
                      ]));
                },
              ),
              SizedBox(
                height: 2.0.h,
              ),
              FutureBuilder(
                future: DepartmentsDB()
                    .getNameDepartment(widget.data['department']),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox.shrink();
                  }
                  return RichText(
                    text: TextSpan(
                        text: 'Departamento:',
                        style: TextStyle(
                          color: Colors.red.shade800,
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: ' ${snapshot.data}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0.sp),
                          )
                        ]),
                  );
                },
              ),
              SizedBox(
                height: 2.0.h,
              ),
              RichText(
                  text: TextSpan(
                      text: 'Sección / Oficina / Programa:',
                      style: TextStyle(
                        color: Colors.red.shade800,
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                    TextSpan(
                      text: ' ${widget.data['section']}' == ' '
                          ? ' No aplica'
                          : ' ${widget.data['section']}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0.sp),
                    )
                  ])),
              SizedBox(
                height: 2.0.h,
              ),
              RichText(
                  text: TextSpan(
                      text: 'Fecha:',
                      style: TextStyle(
                        color: Colors.red.shade800,
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                    TextSpan(
                      text:
                          ' ${format.format(widget.data['date'].toDate())} hrs.',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0.sp),
                    )
                  ])),
              SizedBox(
                height: 2.0.h,
              ),
              RichText(
                text: TextSpan(
                    text: 'Forma de recepción:',
                    style: TextStyle(
                      color: Colors.red.shade800,
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: ' ${widget.data['reception']}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0.sp),
                      )
                    ]),
              ),
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
                        text: ' ${widget.data['observations']}' == ' '
                            ? ' No aplica'
                            : ' ${widget.data['observations']}',
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
                              builder: (context) => FinishPageRed(
                                  data: widget.data, id: widget.id)));
                    },
                    child: Text(
                      'Enviar a Revisión',
                      style: TextStyle(fontSize: 16.0.sp),
                    )),
              ),
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
                              builder: (context) => PendingPageRed(
                                  data: widget.data, id: widget.id)));
                    },
                    child: Text(
                      'Enviar a Pendiente',
                      style: TextStyle(fontSize: 16.0.sp),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
