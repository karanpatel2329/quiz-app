import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({Key? key}) : super(key: key);

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SizedBox(
        width: MediaQuery.of(context).size.width,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Leader Board",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900),),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.8,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('users').orderBy('highestScore',).snapshots(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    var data = snapshot.data!.docs;
                    return ListView.builder(itemBuilder: (context,index){
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        child: Column(
                          children: [
                            Text(data[index].get('name'),style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),),
                            Text("Score :- "+data[index].get('highestScore').toString(),style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15)),
                          ],
                        ),
                      );
                    },
                    itemCount: data.length,
                    );
                  }
                  return Container();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
