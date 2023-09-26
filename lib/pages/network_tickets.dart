import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:tickets/database/ticket.dart';
import 'package:tickets/database/users.dart';
import 'package:tickets/pages/view_ticket_red.dart';

class Network extends StatefulWidget {
  const Network({super.key});

  @override
  State<Network> createState() => _NetworkState();
}

class _NetworkState extends State<Network> {
  String myId = '';
  final format = DateFormat('dd MMMM, yyyy hh:mm', 'es_ES');
  @override
  void initState() {
    super.initState();
    getMyId();
    updateToken();
  }

  getMyId() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      myId = prefs.getString('uid')!;
    });
  }

  updateToken() async {
    var prefs = await SharedPreferences.getInstance();
    var token = await FirebaseMessaging.instance.getToken();

    if (prefs.getString('uid')! != token) {
      print('uid actualizado $token');
      UsersDB().updateUser({'token': token!}, prefs.getString('uid')!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 5.0.h,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Mis tickets pendientes',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0.sp,
              color: Colors.red.shade900,
            ),
          ),
        ),
        Expanded(
            child: StreamBuilder(
                stream: TicketsDB.getMyTicketsRed(myId),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Image.asset(
                        'assets/loading.gif',
                        width: 30.0.w,
                      ),
                    );
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
      ]),
    );
  }

  Widget ticket(data) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewTicketRed(
              data: data.data(),
              id: data.id,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            ClipPath(
              clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Container(
                width: 89.0.w,
                height: 16.0.h,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(
                    width: 2,
                    color: Colors.red.shade800,
                    // You can set the border color here if desired
                  ),
                ),
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
                            radius: 20,
                            backgroundColor: Colors.red.shade800,

                            // You can set the background color of the CircleAvatar here if desired
                          ),
                          Text(
                            '${data['name']}',
                            style: TextStyle(
                              fontSize: 14.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${data['tender']}',
                            style: TextStyle(
                              fontSize: 14.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
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
                              style: TextStyle(fontSize: 14.0.sp),
                            ),
                          ],
                        ),
                      ),
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
                    color: Colors.red.shade500,
                    // You can set the color of this container here if desired
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
