import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:tickets/database/ticket.dart';
import 'package:tickets/pages/view_ticket.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String myId = '';
  final format = DateFormat('dd MMMM, yyyy hh:mm', 'es_ES');
  @override
  void initState() {
    super.initState();
    getMyId();
  }

  getMyId() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      myId = prefs.getString('uid')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5.0.h,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Mis tickets pendientes',
              style: TextStyle(
                  color: Colors.red.shade800,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0.sp),
            ),
          ),
          Expanded(
              child: StreamBuilder(
                  stream: TicketsDB.getMyTickets(myId),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: Image.asset(
                        'assets/loading.gif',
                        width: 30.0.w,
                      ));
                    }
                    return ListView.builder(
                      physics:
                          const ScrollPhysics(parent: BouncingScrollPhysics()),
                      itemBuilder: (context, index) {
                        return ticket(snapshot.data.docs[index]);
                      },
                      itemCount: snapshot.data.docs.length,
                    );
                  }))
        ],
      ),
    );
  }

  Widget ticket(data) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewTicket(
                data: data.data(),
                id: data.id,
              ),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            ClipPath(
              // clipper: TicketPassClipper(holeRadius: 30, position: 10.0.w),
              child: Container(
                width: 89.0.w,
                height: 16.0.h,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    color: data['priority'] == 'low'
                        ? Colors.green.shade300
                        : data['priority'] == 'medium'
                            ? Colors.yellow.shade600
                            : Colors.red.shade300,
                    border: Border.all(
                      width: 2,
                      color: data['priority'] == 'low'
                          ? Colors.green
                          : data['priority'] == 'medium'
                              ? Colors.yellow.shade800
                              : Colors.red,
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: data['priority'] == 'low'
                                ? Colors.green
                                : data['priority'] == 'medium'
                                    ? Colors.yellow.shade800
                                    : Colors.red,
                            // child: Center(
                            //   child: Text(
                            //     data['ticketNumber'],
                            //     style: TextStyle(
                            //         color: Colors.white,
                            //         fontSize: 12.0.sp,
                            //         fontWeight: FontWeight.bold),
                            //   ),
                            // ),
                          ),
                          Text(
                            '${data['name']}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              format.format(data['date'].toDate()),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.0.sp),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              data['address'],
                              style: TextStyle(
                                  fontSize: 14.0.sp, color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 7.0.w,
                  height: 16.0.h,
                  decoration: BoxDecoration(
                      color: data['priority'] == 'low'
                          ? Colors.green
                          : data['priority'] == 'medium'
                              ? Colors.yellow.shade800
                              : Colors.red,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5))),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
