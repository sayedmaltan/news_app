import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello/web_view/web_view.dart';
import 'package:hexcolor/hexcolor.dart';

Widget defaultTextFormFeild({
  required TextEditingController control,
  required String labletext,
  required IconData prfexicon,
  IconData? sufxexicon,
  TextInputType? keyboard,
  required String? Function(String? value) validator,
  bool isPassword = false,
  void Function()? SwitchEyeIcon,
  ValueChanged<String>? onChange,
  FormFieldSetter<String>? onFieldSubmitted,
  Function()? onTap,
  bool showcursor=false,
  bool readonley=false,
  Color colorOfEnabledBorder=const Color(0xFF000000),
  Color colorOfFocusedBorder=const Color(0xFF000000),
  Color? colorOfInputText,
  Color? colorOfprefixIcon,
  Color? colorOfLabel,
}) =>
    TextFormField(
      validator: validator,
      controller: control,

      decoration: InputDecoration(
        labelText: labletext,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorOfEnabledBorder), // Change the enabled border color
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorOfFocusedBorder), // Change the focused border color
        ),
        labelStyle: (
        TextStyle(color: colorOfLabel)
        ),
        border: OutlineInputBorder(
        ),
        prefixIcon: Icon(
          prfexicon,
          color: colorOfprefixIcon,
        ),
        suffixIcon: IconButton(
          icon: Icon(sufxexicon),
          onPressed: SwitchEyeIcon,
        ),
      ),
      keyboardType: keyboard,
      obscureText: isPassword,
      onTap: onTap,
      showCursor: showcursor,
      readOnly: readonley,
      onChanged: onChange,
      onFieldSubmitted: onFieldSubmitted,
      style: TextStyle(
          color: colorOfInputText
            ),
    );

Widget taskOFTodoApp(Map task, context, database, AppCubit) {
  return Dismissible(
    key: Key(task['id'].toString()),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text(
              "${task["date"]}",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${task["title"]}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ),
                ),
                Text(
                  "${task["time"]}",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              AppCubit.getCubit(context).updateDataBase("done", task['id']);
              AppCubit.getCubit(context).getDataBase(database);
              print(AppCubit.getCubit(context).tasks);
            },
            icon: Icon(Icons.check_box_rounded),
            color: Colors.green,
          ),
          IconButton(
            onPressed: () {
              AppCubit.getCubit(context).updateDataBase("archive", task['id']);
              AppCubit.getCubit(context).getDataBase(database);
            },
            icon: Icon(Icons.archive),
            color: Colors.grey,
          ),
        ],
      ),
    ),
    onDismissed: (direction) {
      AppCubit.getCubit(context).deleteRowDataBase(task['id']);
      AppCubit.getCubit(context).getDataBase(database);
    },
  );
}

Widget nOTasksYetAddSomeTask(context, bulider, taskType) {
  return ConditionalBuilder(
    condition: taskType.length > 0,
    builder: (context) => bulider,
    fallback: (context) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 75,
              color: Colors.grey,
            ),
            Text(
              "No Tasks Yet Please Add Some Tasks",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    },
  );
}

Widget BuiledNewsApp (Map map,context,String type)=> InkWell(
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child:   Row(



        children: [



          Container(



            height: 120,



            width: 120,



            decoration: BoxDecoration(



                borderRadius: BorderRadiusDirectional.circular(10),



                image: DecorationImage(



                    image: map["urlToImage"]!=null ? NetworkImage(map["urlToImage"]) :
                        type=="sports"?
                    NetworkImage("https://cdn.britannica.com/51/190751-131-B431C216/soccer-ball-goal.jpg"):
                        type=="science"?
                    NetworkImage("https://uwaterloo.ca/science/sites/default/files/uploads/images/190424-uw-mur-dscf2586_resized.jpg"):
                        type=="business"?
                            NetworkImage("https://www.middleweb.com/wp-content/uploads/2017/08/breaking-news-blue-600.jpg"):
                            NetworkImage("https://www.lifewire.com/thmb/9LILR_bPSZLFbsxlvr5gA-a3EsI=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/GettyImages-1047578412-692fa117cf86450287d8873eeb1a95c8.jpg")
                    ,
                  



                    fit: BoxFit.cover



                )



            ),



          ),

     SizedBox(width: 10,),

          Expanded(



            child: Container(



              height: 120,



              child: Column(



                mainAxisSize: MainAxisSize.min,



                mainAxisAlignment: MainAxisAlignment.start,



                crossAxisAlignment: CrossAxisAlignment.start,



                children: [



                  Expanded(



                    child: Text(map["title"],



                      style: Theme.of(context).textTheme.button,



                      maxLines: 3,



                      overflow:TextOverflow.ellipsis ,



                    ),



                  ),



                  Text(getDate(map["publishedAt"]),



                    style: TextStyle(



                      fontSize: 15,



                      color: Colors.grey,



                    ),



                  )



                ],



              ),



            ),



          )







        ],



      ),

  ),
  onTap: () {
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => WebViewScreen(map['url']) ,)
    );
  },
);

Widget BuiledSeprationBuilder ()=>Padding(
  padding: const EdgeInsetsDirectional.only(start: 20),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  ),
);

String getDate(String date) {
  String newDate="";
  for(int i=0;i<10;i++)
    {
      newDate="${newDate}${date[i]}";
    }
  return newDate;
}
