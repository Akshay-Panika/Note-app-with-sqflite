import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app/Reusable_widget/reusable_text_style.dart';
import 'package:note_app/Services_folder/note_provider.dart';
import 'package:provider/provider.dart';
import '../Reusable_widget/appbar_widget.dart';
import 'floating_action_button.dart';
import 'note_view_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [

            ///___ App bar
            const SizedBox(height: 30,),
            const AppBarWidget(),

           ///___User Data
           Consumer<NoteProvider>(builder: (context, value, child) {
             if(value.getNote().isNotEmpty){
               return Expanded(
                   child:MasonryGridView.builder(
                     itemCount:value.getNote().length,
                     gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount:2,
                     ),
                     itemBuilder: (context, index) {
                       return  InkWell(
                         child: Card(
                           color: Colors.black54,
                           shape:  const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                           child: Stack(
                             children: [
                               Padding(
                                 padding: const EdgeInsets.only(top:15,left: 15,right: 15,bottom:30),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [

                                     ///___ Title
                                     Text(value.getNote()[index].title.toString(),style: const TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w500,)),
                                     const SizedBox(height: 5,),
                                     ///___ Subtitle
                                     Text(value.getNote()[index].subtitle.toString(),style: textStyle17,),
                                   ],
                                 ),
                               ),

                               ///___ Time date
                               Positioned(
                                   right: 5,
                                   bottom:5,
                                   child:Text(value.getNote()[index].date.toString(),style: textStyleB54,) )

                             ],
                           ),
                         ),
                         onTap: (){
                           showModalBottomSheet(context: context,
                             isScrollControlled: true,
                             backgroundColor: Colors.black,
                             builder: (context) {
                               return  NoteViewScreen(title:value.getNote()[index].title.toString(),subtitle:value.getNote()[index].subtitle.toString(),
                                 time: value.getNote()[index].time.toString(),date: value.getNote()[index].date.toString(),
                                 id:value.getNote()[index].id!,
                                 index:value.getNote()[index],
                               );
                             },
                           );
                         },
                       );
                     },));
             }
             else{
               return Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   const SizedBox(height:170,),

                   ///______ Cart is Empty
                   SizedBox(
                       height: 200,
                       child: Image.asset("assets/images/Empty.png")),
                   Text("No data is here!",style: textStyle19,)
                 ],
               );
             }
           },
           ),
          ],
        ),
      ),

        ///___ FloatingActionButtonWidget
      floatingActionButton:const FloatingActionButtonWidget(),
    );
  }
}
