import 'package:flutter/material.dart';

import '../utils/size_config.dart';
import '../utils/text_form_field.dart';
import '../utils/validation_mixin.dart';

class GeneralButtomSheet {
  customBottomSheet(BuildContext context) async{
    final roomNameController = TextEditingController();
  
    return await showModalBottomSheet(
        context: context,
        builder: (_) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 10,
              right: 16,
              left: 16,
            ),
          
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                   Text(
                          "Hotel Name",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(
                          height: SizeConfig.height,
                        ),
                        InputTextField(
                          title: "Enter room name",
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          controller: roomNameController,
                          validate: (value) =>
                              ValidationMixin().validate(value!, "hotel name"),
                          onFieldSubmitted: (_) {},
                        ),
                        SizedBox(
                          height: SizeConfig.height * 2,
                        ),
                  
            
            
                 
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        
                        Navigator.of(context).pop(roomNameController.text);
                      },
                      child: const Text('Add'),
                    ),
                  ),
                ],
              ),
            
          );
        });
  }
}
