import 'package:flutter/material.dart';
import 'package:note_app/Reusable_widget/reusable_container.dart';
import 'package:note_app/Services_folder/note_provider.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(height:70,width: double.infinity,color:Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Padding(
               padding: const EdgeInsets.only(top: 25.0),
               child: Column(
                 children: [

                   ///___ Headline
                   const Text("Notes",style: TextStyle(fontSize: 25, color: Colors.grey,fontWeight: FontWeight.w600),),
                   Container(height: 1,width: 100,color: Colors.grey,)
                 ],
               ),
             ),

            ///___ CountButton
            //ReusableContainerIcon(iconData: Icons.search_rounded,height: 40,width: 40,),
            Consumer<NoteProvider>(builder: (context, value, child) {
              return  ReusableContainerText(title: value.getCounterItem().toString(), height: 36, width: 36,onTap: (){},);

            },)
          ],
        ),
      ),
    );

  }
}
