
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Homepage extends StatefulWidget { 
  
  const Homepage({super.key});
 
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String userInput="";
  String result="";
  
  List<String> buttons=["AC","(",")","/",
  "7",
  "8",
  "9",
  "*",
  "4",
  "5",
  "6",
  "+",
  "1",
  "2","3","-","C","0",".","="
  ];
  @override
  Widget build(BuildContext context) {
     
    
    return Scaffold(backgroundColor: const Color(0xFF1d2630),
      body: Column(
        children: [
          
      SizedBox(height: MediaQuery.of(context).size.height/3,
        child: Column(mainAxisAlignment: MainAxisAlignment.end,
         children: [ Container(padding: const EdgeInsets.all(10),alignment: Alignment.centerRight,
          child: Text(userInput,style: const TextStyle(fontSize: 20,color: Colors.white),)),
         Container(
          padding: const EdgeInsets.all(10),alignment: Alignment.centerRight,
          child: Text(result,style: const TextStyle(fontSize: 40,color: Colors.white),))],
        ),
      ),

       const Divider(thickness: 1,color: Colors.black,),
        Expanded(
          child: Container(padding: const EdgeInsets.all(5),
            child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,mainAxisSpacing:4,crossAxisSpacing: 4), itemBuilder: (BuildContext context,index){
                return button(buttons[index]);
              }),
          ),
        )
     
        ],
      ),
    );
    
    }
    Widget button (String text){

  return InkWell(onTap: (){
    setState(() {
      buttonHandler(text);
    });
  },
    splashColor: const Color(0xFF1d2630),
  child: Ink(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: getBGColour(text),boxShadow:[BoxShadow(
spreadRadius: 0.5,blurRadius: 2.0,color: Colors.white.withOpacity(0.1),offset: const Offset(-3, -3)
  ) ]),
   
    child: Center(child: Text(text,style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: getTextcolor(text)),),
    ),
  ),
  
  );
}

getBGColour(String text){
  if(text=="AC"){return const Color.fromARGB(255, 252, 100, 100);}
 if(text=="="){return const Color.fromARGB(255, 104, 204, 159) ;}
return const Color(0xFF1d2630);
}
getTextcolor(String text){
  if(text==")"||
    text=="(" ||
    text=="+"||
    text=="/"|| text=="*"||
      text=="-"||text=="C"
  ) {
    return const Color.fromARGB(255, 252, 100, 100);
  } else {
    return Colors.white;
  }

}
buttonHandler(String text){
 
  if(text=="="){
    result=calculate();
    userInput=result;
    return;
  }
  if(text=="AC"){
    userInput="";
    result="0";return;
  }
  if(text=="C"){
    if(userInput.isNotEmpty){
      userInput="";
    }
    result="0";return;
  }
  if(result.endsWith(".0")){
    result=result.replaceAll(".0", "");

  }

  userInput=userInput +text;
}

String calculate(){
try {
  var exp=Parser().parse(userInput);
 var evaluate=exp.evaluate(EvaluationType.REAL, ContextModel());
 return evaluate.toString();
} catch (e) {
  return "Error";
}
}
    }


   