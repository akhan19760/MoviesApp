import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class SearchDropDown extends StatefulWidget {
  const SearchDropDown({super.key});

  @override
  State<SearchDropDown> createState() => _SearchDropDownState();
}

class _SearchDropDownState extends State<SearchDropDown> {
  Icon f_icon = Icon(Icons.filter_list_outlined);

  List<dynamic> items = [
    'Sort By Rating',
    'Sort By Most Likes',
    'Sort By Recent'
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        // iconOnClick:  ,
        isExpanded: true,
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Row(
                    children: [
                      item == items[0]
                          ? Icon(
                              Icons.star,
                              color: Color(0xff09101d),
                            )
                          : (item == items[1]
                              ? Icon(
                                  Icons.thumb_up_alt_rounded,
                                  color: Color(0xff09101d),
                                )
                              : Icon(Icons.timer, color: Color(0xff09101d))),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff09101d),
                        ),
                        //overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ))
            .toList(),
        //value: selectedValue,
        onChanged: (value) {
          setState(() {
            if (value == items[0]) {
              f_icon = Icon(Icons.timer);
            }
            if (value == items[1]) {
              f_icon = Icon(Icons.trending_up);
            }
            if (value == items[2]) {
              f_icon = Icon(Icons.star);
            }
            selectedValue = value as String;
          });
        },
        icon: f_icon,

        iconSize: 14,
        iconEnabledColor: Color(0xff09101d),
        iconDisabledColor: Color(0xff09101d),
        buttonHeight: 50,
        buttonWidth: 60,
        buttonPadding: const EdgeInsets.only(right: 14),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          //border: Border.all(
          //color: Colors.whit,
          //),
          color: Colors.white,
        ),
        buttonElevation: 0,
        itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 20),
        dropdownMaxHeight: 200,
        dropdownWidth: MediaQuery.of(context).size.width,
        dropdownPadding: EdgeInsets.only(right: 30),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        dropdownElevation: 8,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        offset: const Offset(-20, 0),
      ),
    );
  }
}
