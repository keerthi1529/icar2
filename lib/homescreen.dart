import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:icar2/function.dart';
import 'package:icar2/globalvar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as tAgo;
import 'package:icar2/decoder.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth=FirebaseAuth.instance;
  String userName='';
  String userNumber='';
  String carPrice='';
  String carModel='';
  String carColor='';
  String description='';
  String urlImage='';
  String carLocation='';
  QuerySnapshot? cars;

  carMethods carobj=new carMethods();

  Future<bool?> showDialogForAddingData() async{
      return showDialog<bool?>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text('post a New ad',
                style: TextStyle(fontFamily:'Babas',fontSize: 24,letterSpacing: 2.0),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter your Name'),
                    onChanged: (value){
                      this.userName=value;
                    },
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter your Phone Number'),
                    onChanged: (value){
                      this.userNumber=value;
                    },
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter car Price'),
                    onChanged: (value){
                      this.carPrice=value;
                    },
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter car Name'),
                    onChanged: (value){
                      this.carModel=value;
                    },
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter car color'),
                    onChanged: (value){
                      this.carColor=value;
                    },
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter location'),
                    onChanged: (value){
                      this.carLocation=value;
                    },
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter description'),
                    onChanged: (value){
                      this.description=value;
                    },
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter image url'),
                    onChanged: (value){
                      this.urlImage=value;
                    },
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed:(){
                      Navigator.pop(context);
                    },
                    child: Text(
                      'cancel'
                    )),
                ElevatedButton(
                  child: Text('save'),
                    onPressed:(){
                      Map<String ,dynamic> carData={
                        'userName':this.userName,
                        'uid':userid,
                        'userNumber':this.userNumber,
                        'carPrice':this.carPrice,
                        'carModel':this.carModel,
                        'carColor':this.carColor,
                        'carLocation':this.carLocation,
                        'description':this.description,
                        'imageUrl':this.urlImage,
                        'imgPro':userImageUrl,
                        'time':DateTime.now(),
                      };
                      carobj.addData(carData).then((value) {
                        print('Data added successfully');
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen()));
                      }).catchError((error){
                        print(error);
                      });
                    },
                )
              ],
            );
          }
      );
  }

  getDatafromUsers(){
    FirebaseFirestore.instance.collection('users').doc(userid).get().then((results){
      setState((){
        //final data = results.data() as Map<String, dynamic>?;
       // userImageUrl=data?['ImgPro'] as String??'';
       // getUserName=data?['userName'] as String??'';
        userImageUrl=results.data()?['ImgPro'];
        getUserName=results.data()?['userName'];
      });
    });
  }
  @override
  void initState(){
    super.initState();
    userid=(FirebaseAuth.instance.currentUser?.uid as String)??'';
    userEmail=(FirebaseAuth.instance.currentUser?.email as String)??'';
    getDatafromUsers();
    carobj.getData().then((results){
      setState((){
        cars=results;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    double _screenwidth =MediaQuery.of(context).size.width,
    __screenheight =MediaQuery.of(context).size.height;
    Widget showCarList(){
      if(cars!=null) {
        return ListView.builder(
          itemCount: cars?.docs?.length ?? 0,
          padding: EdgeInsets.all(8.0),
          itemBuilder: (context, i) {
            return Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                      leading: GestureDetector(
                        onTap: () {
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                               // image:
                                // NetworkImage(
                                //   (cars?.docs[i].data() as Map<String,
                                //       dynamic>? ?? {})['ImgPro'] as String? ??
                                //       '',
                                // ),
                               image:AssetImage('images/img.png'),
                                fit: BoxFit.fill
                            ),
                          ),
                        ),
                      ),
                   title: GestureDetector(
                   onTap: () {},
                   child:Text((cars?.docs[i].data() as Map<String,
                        dynamic>? ?? {})['userName'] as String? ??'',)
            ),
                   subtitle: GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text((cars?.docs[i].data() as Map<String,
                                dynamic>? ?? {})['carLocation'] as String ?? '',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                            SizedBox(width: 4.0,),
                            Icon(Icons.location_pin, color: Colors.grey,)
                          ],
                        ),
                      ),
                      trailing: ((cars?.docs[i].data() as Map<
                          String,
                          dynamic>? ?? {})['uid'] as String ?? '') == userid ?
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Icon(Icons.edit_outlined),
                          ),
                          SizedBox(width: 20,),
                          GestureDetector(
                            onDoubleTap: () {},
                            child: Icon(Icons.delete_forever_sharp),
                          )
                        ],
                      )
                          : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [],
                      )
                  ),
                  Padding(padding: const EdgeInsets.all(16.0),
                    child:
                    NetworkImageDecoder(
                      imageUrl: '\$' + (cars?.docs[i].data() as Map<String, dynamic>? ??
                          {})['imageUrl'] as String ?? '',
                    ),
                    // Image.network(
                    //   '\$' + (cars?.docs[i].data() as Map<String, dynamic>? ??
                    //       {})['imageUrl'] as String ?? '',
                    // ),
                  ),
                  Padding(padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '\$' + (cars?.docs[i].data() as Map<String, dynamic>? ??
                          {})['carPrice'] as String ?? '',
                      style: TextStyle(
                        fontFamily: "Bebas",
                        letterSpacing: 2.0,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                    child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children:[
                          Icon(Icons.directions_car),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                            child: Align(
                              child: Text(
                                (cars?.docs[i].data() as Map<String,
                                    dynamic>? ?? {})['carModel'] as String ?? '',
                              ),
                              alignment: Alignment.topLeft,
                            ),
                          ),
                        ],
                      ),
                        Row(
                          children: [
                            Icon(Icons.watch_later_outlined),
                            Padding(padding: const EdgeInsets.only(left: 10.0),
                              child: Align(
                                child: Text(
                                    tAgo.format(
                                      ((cars?.docs[i].data() as Map<String, dynamic>?)?['time'] as Timestamp)?.toDate() ?? DateTime.now(),
                                )
                                ),
                                alignment: Alignment.topRight,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children:[
                              Icon(Icons.brush_outlined),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Align(
                                  child: Text(
                                    (cars?.docs[i].data() as Map<String,
                                        dynamic>? ??
                                        {})['carColor'] as String ?? '',
                                  ),
                                  alignment: Alignment.topLeft,
                                ),
                              )
                            ],
                          ),
                            Row(
                              children: [
                                Icon(Icons.phone_android),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Align(
                                    child: Text((cars?.docs[i].data() as Map<
                                        String,
                                        dynamic>? ??
                                        {})['userNumber'] as String ?? '',
                                    ),
                                    alignment: Alignment.topRight,
                                  ),
                                )
                              ],
                            ),
                          ]
                      )
                  ),
                  SizedBox(height: 10,),
                  Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Text((cars?.docs[i].data() as Map<
                          String,
                          dynamic>? ?? {})['description'] as String ?? '',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                      )
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            );
          },

        );
      }
      else{
       return Text('Loading');
      }
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.refresh,color: Colors.white,),
          onPressed: ()
          {},
        ),
        actions: <Widget>[
          TextButton(
              onPressed: (){},
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.person,color: Colors.white,),
              )
          ),
          TextButton(
              onPressed: (){},
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.search,color: Colors.white,),
              )
          ),
          TextButton(
              onPressed: (){},
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.login_outlined,color: Colors.white,),
              )
          ),
        ],
          flexibleSpace:Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    Colors.blueAccent,
                    Colors.redAccent,
                  ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0,1.0],
                tileMode: TileMode.clamp
              )
            ),
          ),
          title: Text(('Home Page')),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: _screenwidth*.5,
          child: showCarList(),
        )
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add post',
        child: Icon(Icons.add),
        onPressed: (){
          showDialogForAddingData();
        },
      ),
    );
  }
}
