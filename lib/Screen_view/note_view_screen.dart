import 'package:flutter/material.dart';
import 'package:note_app/Reusable_widget/reusable_container.dart';
import 'package:note_app/Reusable_widget/reusable_text_style.dart';
import 'package:note_app/Screen_view/update_note_screen.dart';
import 'package:note_app/Services_folder/note_model.dart';
import 'package:provider/provider.dart';

import '../Services_folder/note_provider.dart';

class NoteViewScreen extends StatefulWidget {
  final NoteModel index;
  final int id;
  final String title;
  final String subtitle;
  final String time;
  final String date;
  const NoteViewScreen({super.key, required this.title, required this.subtitle, required this.time, required this.date, required this.index,required this.id});
  @override
  State<NoteViewScreen> createState() => _NoteViewScreenState();
}
class _NoteViewScreenState extends State<NoteViewScreen> {

  deleteNote(int id)async{
      context.read<NoteProvider>().deleteNote(id);
    }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:10,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///___ Appbar
            const SizedBox(height: 50,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 8.0),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 ///___ Back button
                 ReusableContainerIcon(iconData: Icons.arrow_back, height: 36, width: 36,onTap: (){Navigator.pop(context);}),

                 ///___ Menu bar
                 Container(height: 36,width: 36,decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(5),border: Border.all(color: Colors.grey,width: 0.8)
                 ),
                   child: Center(
                     child:Consumer<NoteProvider>(
                       builder: (context, value, child) {
                         return  PopupMenuButton(
                           color: Colors.grey,
                           icon:  Icon(Icons.more_vert,color: Colors.grey,),
                           itemBuilder: (context) => [
                             PopupMenuItem(
                               child: const Text("Update"),onTap: (){
                               showModalBottomSheet(context: context,
                                 isScrollControlled: true,
                                 backgroundColor: Colors.black,
                                 builder: (context) {
                                   return UpdateNoteScreen(id:widget.index.id!,title: widget.index.title!,subtitle: widget.index.subtitle!);
                                 },
                               );

                             },),

                             PopupMenuItem(child: const Text("Delete"),onTap: (){
                               deleteNote(widget.index.id!);
                               value.removeCountItem();
                               Navigator.pop(context);

                             },),
                           ],);
                       },
                     ),
                   ),
                 )
               ],
             ),
           ),
            const SizedBox(height: 30,),

            Expanded(
              child: Container(
                width: 500,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey,),),
                child:Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height:30,),
                      Text("Title- ${widget.title}",style: textStyle17,),
                      Container(height: 1,color: Colors.grey,),
                      Text(widget.time+"- "+widget.date,style: textStyleB54,),
                      const SizedBox(height: 15,),
                      Text("Subtitle- ${widget.subtitle}",style: textStyle17,),
                    ],
                  ),
                ) ,
              ),
            ),
            const SizedBox(height: 80,),

          ],
        ),
      ),
    );
  }
}
