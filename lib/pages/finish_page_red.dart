// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tickets/database/ticket.dart';
import 'package:tickets/utils/motion.dart';

class FinishPageRed extends StatefulWidget {
  final Map data;
  final String id;
  const FinishPageRed({super.key, required this.data, required this.id});

  @override
  State<FinishPageRed> createState() => _FinishPageState();
}

class _FinishPageState extends State<FinishPageRed> {
  TextEditingController text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.0.h,
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
                'Enviar a revisión',
                style: TextStyle(
                    color: Colors.red.shade800,
                    fontSize: 20.0.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.0.h,
              ),
              Container(
                width: 100.0.w,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.red.shade800),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: text,
                      textInputAction: TextInputAction.newline,
                      maxLines: 10,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Indica la resolución del caso...',
                          hintStyle: TextStyle(
                              fontSize: 16.0.sp, color: Colors.red.shade200)),
                    ),
                  ),
                ),
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
                      finish();
                    },
                    child: Text(
                      'Finalizar',
                      style: TextStyle(fontSize: 16.0.sp),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  finish() async {
    showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              content: Container(
                color: Colors.white,
                height: 20.0.h,
                child: Center(
                    child: Column(
                  children: [
                    Image.asset(
                      'assets/loading.gif',
                      width: 30.0.w,
                    ),
                    Text(
                      'Cargando...',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )),
              ),
            ));
    var res = await TicketsDB().updateTicketRed(text.text, widget.id);
    if (res) {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Utils().alertNormal('Se ha finalizado el ticket.', 'Realizado', context);
    } else {
      Navigator.pop(context);
      Utils().alertNormal(
          'Ha ocurrido un error. Inténtalo nuevamente.', 'Error', context);
    }
  }
}
