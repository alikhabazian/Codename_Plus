import 'package:flutter/material.dart';
import 'dart:math';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Code name plus'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool block=false ;
  int _counter = 0;
  int first=1;
  int turn=Random().nextInt(2)+1;//blue
  List<int> tile=[0,0];
  List<int> round=[0,0];
  List<int> end_tile=[0,0];
  // -1 bomb 0 nothing 1 blu 2 red
  //2 -1    1-2    2-1   2 -0
  // 8 ,7 ,1 ,4
  List<int> list = [for (var i = 0; i <= 19; i++) i];
  
  
  List<List<int>> state=[[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]];
  List<List<int>> card=[[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]];
  @override
  initState() {
    turn=Random().nextInt(2)+1;
    list = [for (var i = 0; i <= 19; i++) i];
    first=1;
    state=[[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]];
    card=[[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]];
    tile=[0,0];
    if(turn==1){//blue at start
     end_tile=[8,7];
    }
    else{
      end_tile=[7,8];
    }

    print("initState Called");
    block=false ;
    setState(() { });
  }


  
//  List<List<int>> card=[[1,1,2,1,2],[1,2,0,2,2],[2,2,0,-1,1],[1,2,1,0,0]];
  void _incrementCounter() {
    initState();
    // setState(() {
    //   // This call to setState tells the Flutter framework that something has
    //   // changed in this State, which causes it to rerun the build method below
    //   // so that the display can reflect the updated values. If we changed
    //   // _counter without calling setState(), then the build method would not be
    //   // called again, and so nothing would appear to happen.
    //   _counter++;
    // });
  }

  @override
  Widget build(BuildContext context) {
    
      if(first==1){ 

       List<int> sh=list..shuffle();
      for(var i=0;i<8;i++){
        // print(sh[i]);
        // print((sh[i]/5).floor());
        // print(sh[i]%5);
        // print(' ');
        card[(sh[i]/5).floor()][sh[i]%5]=turn;
      }
      for(var i=8;i<15;i++){
        
        card[(sh[i]/5).floor()][sh[i]%5]=3-turn;
      }
      for(var i=15;i<19;i++){
        
        card[(sh[i]/5).floor()][sh[i]%5]=0;
      }
      card[(sh[19]/5).floor()][sh[19]%5]=-1;
      first=0;
      }
     double width = MediaQuery.of(context).size.width;
     double height = MediaQuery.of(context).size.height;
     print([width,height]);
     double min_size=min(width,height)*0.9;
     print(min_size);
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
      child:Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          
          children: <Widget>[
            

            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Text('Tiles:',
            style: TextStyle(
              fontSize: 40,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 2
                ..color = Colors.blue[700]!,
            ),
            ),
                Container(
                  color: Colors.blue,
                  // r
                  margin: EdgeInsets.all(min_size/100),
                  width: min_size/5,
                  height: min_size/5,
              child:Center(child:Text('${tile[0]}'))
              ),
               Container(
                  color: Colors.red,
                  // r
                  margin: EdgeInsets.all(min_size/100),
                  width: min_size/5,
                  height: min_size/5,
              child:Center(child:Text('${tile[1]}'))
              ),
              ]
            ),


            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Text('Scors:',
            style: TextStyle(
              fontSize: 34,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 2
                ..color = Colors.blue[700]!,
            ),
            ),
                Container(
                  color: Colors.blue,
                  // r
                  margin: EdgeInsets.all(min_size/100),
                  width: min_size/5,
                  height: min_size/5,
              child:Center(child:Text('${round[0]}'))
              ),
               Container(
                  color: Colors.red,
                  // r
                  margin: EdgeInsets.all(min_size/100),
                  width: min_size/5,
                  height: min_size/5,
              child:Center(child:Text('${round[1]}'))
              ),
              ]
            ),




           GestureDetector(
                  child:Container(
                  color:turn==1?Colors.blue:Colors.red,
                  // r
                  // margin: EdgeInsets.all(min_size/100),
                  width: min_size/5,
                  height: min_size/5,
                  child:Icon(Icons.repeat)),
                  onTap: (){
                    if(!block){
                    var rimn_turn=0;
                    for(var ii=0;ii<4;ii++){
                      for(var jj=0;jj<5;jj++){
                        if(card[ii][jj]==turn && state[ii][jj]==0){
                            rimn_turn++;
                        }
                      }
                    }
                    var rimn_unturn=0;
                    for(var ii=0;ii<4;ii++){
                      for(var jj=0;jj<5;jj++){
                        if(card[ii][jj]==3-turn && state[ii][jj]==0){
                            rimn_unturn++;
                        }
                      }
                    }
                    var rimn_blank=0;
                    for(var ii=0;ii<4;ii++){
                      for(var jj=0;jj<5;jj++){
                        if(card[ii][jj]==0 && state[ii][jj]==0){
                            rimn_blank++;
                        }
                      }
                    }
                    print(rimn_turn);
                    print(rimn_unturn);
                    print(rimn_blank);
                    List<int> newlist = [for (var k = 0; k <= 19; k++) k];
                    for(var ii=0;ii<4;ii++){
                      for(var jj=0;jj<5;jj++){
                        if (state[ii][jj]==1){
                          newlist.remove(5*ii+jj);
                        }
                      }
                    }  
                    List<int> shn=newlist..shuffle();
                    var t=0;
                    while(t!=rimn_turn) {
                      int x=shn.removeAt(0);
                      card[(x/5).floor()][x%5]=turn;
                      t++;
                    }
                    t=0;
                    while(t!=rimn_unturn) {
                      int x=shn.removeAt(0);
                      card[(x/5).floor()][x%5]=3-turn;
                      t++;
                    }
                    t=0;
                    while(t!=rimn_blank) {
                      int x=shn.removeAt(0);
                      card[(x/5).floor()][x%5]=0;
                      t++;
                    }
                    int x=shn.removeAt(0);
                    card[(x/5).floor()][x%5]=-1;

                    print(newlist);
                    

                    // var remain_is_turn=
                   turn=3-turn;
                   
                    setState(() {
                    
                    }
                    
                    );
                    }
                  }
                ),
              
                // Icon(Icons.square,size: 100.0,color:turn==1?Colors.blue:Colors.red),
                // GestureDetector(
                //   child:Icon(Icons.repeat),
                //   onTap: (){
                //     var rimn_turn=0;
                //     for(var ii=0;ii<4;ii++){
                //       for(var jj=0;jj<5;jj++){
                //         if(card[ii][jj]==turn && state[ii][jj]==0){
                //             rimn_turn++;
                //         }
                //       }
                //     }
                //     var rimn_unturn=0;
                //     for(var ii=0;ii<4;ii++){
                //       for(var jj=0;jj<5;jj++){
                //         if(card[ii][jj]==3-turn && state[ii][jj]==0){
                //             rimn_unturn++;
                //         }
                //       }
                //     }
                //     var rimn_blank=0;
                //     for(var ii=0;ii<4;ii++){
                //       for(var jj=0;jj<5;jj++){
                //         if(card[ii][jj]==0 && state[ii][jj]==0){
                //             rimn_blank++;
                //         }
                //       }
                //     }
                //     print(rimn_turn);
                //     print(rimn_unturn);
                //     print(rimn_blank);
                //     List<int> newlist = [for (var k = 0; k <= 19; k++) k];
                //     for(var ii=0;ii<4;ii++){
                //       for(var jj=0;jj<5;jj++){
                //         if (state[ii][jj]==1){
                //           newlist.remove(5*ii+jj);
                //         }
                //       }
                //     }  
                //     List<int> shn=newlist..shuffle();
                //     var t=0;
                //     while(t!=rimn_turn) {
                //       int x=shn.removeAt(0);
                //       card[(x/5).floor()][x%5]=turn;
                //       t++;
                //     }
                //     t=0;
                //     while(t!=rimn_unturn) {
                //       int x=shn.removeAt(0);
                //       card[(x/5).floor()][x%5]=3-turn;
                //       t++;
                //     }
                //     t=0;
                //     while(t!=rimn_blank) {
                //       int x=shn.removeAt(0);
                //       card[(x/5).floor()][x%5]=0;
                //       t++;
                //     }
                //     int x=shn.removeAt(0);
                //     card[(x/5).floor()][x%5]=-1;

                //     print(newlist);
                    

                //     // var remain_is_turn=
                //    turn=3-turn;
                   
                //     setState(() {
                    
                //   });
  
                //   }
                // )
                
                
                
                ]
            +card.asMap().entries.map((entry)=>Row(

            mainAxisAlignment: MainAxisAlignment.center,
            
            children:
            
            card[entry.key].asMap().entries.map((entryj)=>
            GestureDetector(
            onTap: (){
                if (state[entry.key][entryj.key]==0 && !block){
                setState(() {
                  state[entry.key][entryj.key]=1;
                  if (card[entry.key][entryj.key]==-1){
                    print('bomb');
                    print('win this game');
                      block=true;
                      round[2-turn]=round[2-turn]+1;
                  }
                  else if (turn!=card[entry.key][entryj.key]){
                    var rimn_turn=0;
                    for(var ii=0;ii<4;ii++){
                      for(var jj=0;jj<5;jj++){
                        if(card[ii][jj]==turn && state[ii][jj]==0){
                            rimn_turn++;
                        }
                      }
                    }
                    var rimn_unturn=0;
                    for(var ii=0;ii<4;ii++){
                      for(var jj=0;jj<5;jj++){
                        if(card[ii][jj]==3-turn && state[ii][jj]==0){
                            rimn_unturn++;
                        }
                      }
                    }
                    var rimn_blank=0;
                    for(var ii=0;ii<4;ii++){
                      for(var jj=0;jj<5;jj++){
                        if(card[ii][jj]==0 && state[ii][jj]==0){
                            rimn_blank++;
                        }
                      }
                    }
                    print(rimn_turn);
                    print(rimn_unturn);
                    print(rimn_blank);
                    List<int> newlist = [for (var k = 0; k <= 19; k++) k];
                    for(var ii=0;ii<4;ii++){
                      for(var jj=0;jj<5;jj++){
                        if (state[ii][jj]==1){
                          newlist.remove(5*ii+jj);
                        }
                      }
                    }  
                    List<int> shn=newlist..shuffle();
                    var t=0;
                    while(t!=rimn_turn) {
                      int x=shn.removeAt(0);
                      card[(x/5).floor()][x%5]=turn;
                      t++;
                    }
                    t=0;
                    while(t!=rimn_unturn) {
                      int x=shn.removeAt(0);
                      card[(x/5).floor()][x%5]=3-turn;
                      t++;
                    }
                    t=0;
                    while(t!=rimn_blank) {
                      int x=shn.removeAt(0);
                      card[(x/5).floor()][x%5]=0;
                      t++;
                    }
                    int x=shn.removeAt(0);
                    card[(x/5).floor()][x%5]=-1;

                    print(newlist);
                    

                    // var remain_is_turn=
                   if(card[entry.key][entryj.key]==3-turn){
                    tile[2-turn]=tile[2-turn]+1;
                    if(end_tile[2-turn]==tile[2-turn]){
                      print('win this game');
                      block=true;
                      round[2-turn]=round[2-turn]+1;
                      
                    }
                   }
                   turn=3-turn;
                   
                   
                  }
                  else{
                    tile[turn-1]=tile[turn-1]+1;
                    if(end_tile[turn-1]==tile[turn-1]){
                      print('win this game');
                      block=true;
                      round[turn-1]=round[turn-1]+1;
                      
                    }
                  }
                    
                  });
                }
                setState(() {
                    
                  });
              },
            child:Container(
                  color: entryj.value==1? Colors.blue: (entryj.value==-1?Colors.black:(entryj.value==2?Colors.red:Colors.yellow)),
                  // r
                  margin: EdgeInsets.all(min_size/100),
                  width: min_size/5,
                  height: min_size/5,
              child:Center(child:Text('${state[entry.key][entryj.key]}'))
              )
            )
              ).toList()
          )).toList(),
        ),
      )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
