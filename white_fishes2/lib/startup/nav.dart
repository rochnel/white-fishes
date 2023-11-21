//Navigation :----------------------------------------------------------------
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';






//Navigation :----------------------------------------------------------------


Future<bool> willPop(BuildContext ctx,{String? title}) {
  final completer = Completer<bool>();
  showModalBottomSheet(
      context: ctx,
      builder: (buildContext) {
        return Container(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Text(
                  title??"Est vous sûr quitter cette action?",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  )
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                        child: const Text(
                            "NON",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            )
                        ),
                        onPressed: () {
                          completer.complete(false);
                          Navigator.of(buildContext).pop(false);
                        }),
                  ),
                  Expanded(
                    child: TextButton(
                        child: const Text(
                            "OUI",
                            style: TextStyle(
                              //color: AppColors.primary,
                              fontSize: 16,
                            )
                        ),
                        onPressed: () {
                          completer.complete(true);
                          Navigator.of(buildContext).pop();
                        }),
                  ),

                ],
              )
            ],
          ),
        );
      });
  return completer.future;
}





