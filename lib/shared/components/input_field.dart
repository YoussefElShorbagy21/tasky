import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.title,
    required this.note,
    this.controller,
    required this.onTap,
    this.widget,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  final String title;

  final String note;

  final TextEditingController? controller;

  final Widget? widget;

  final Function() onTap;

  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
          ),
          Container(
              padding: const EdgeInsets.only(left: 14),
              margin: const EdgeInsets.only(top: 8),
              height: MediaQuery.of(context).size.height / 13,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0XFF408080),
                  )),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onTap: onTap,
                      controller: controller,
                      autofocus: false,
                      validator: validator,
                      keyboardType: keyboardType,
                      cursorColor: const Color(0XFF408080),
                      readOnly: widget != null ? true : false,
                      decoration: InputDecoration(
                        hoverColor: const Color(0XFF408080),
                        hintText: note,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.surface,
                          width: 0,
                        )),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.surface,
                          width: 0,
                        )),
                      ),
                    ),
                  ),
                  widget ?? Container(),
                ],
              )),
        ],
      ),
    );
  }
}
