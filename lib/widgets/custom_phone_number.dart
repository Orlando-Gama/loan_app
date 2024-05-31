import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:country_pickers/country.dart';
import 'package:tadza_loan/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:tadza_loan/core/app_export.dart';

// ignore: must_be_immutable
class CustomPhoneNumber extends StatelessWidget {
  CustomPhoneNumber({
    Key? key,
    required this.country,
    required this.onTap,
    required this.controller,
  }) : super(
          key: key,
        );

  Country country;

  Function(Country) onTap;

  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(
          17.h,
        ),
        border: Border.all(
          color: appTheme.blueGray100,
          width: 1.h,
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              _openCountryPicker(context);
            },
            child: Padding(
              padding: EdgeInsets.only(
                left: 30.h,
                top: 20.v,
                bottom: 20.v,
              ),
              child: Row(
                children: [
                  Text(
                    "+${country.phoneCode}",
                    style: CustomTextStyles.bodyLarge_2,
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgArrowDown,
                    height: 7.v,
                    margin: EdgeInsets.only(
                      left: 14.h,
                      top: 5.v,
                      bottom: 3.v,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: 10.h,
                right: 5.h,
              ),
              child: CustomTextFormField(
                width: 257.h,
                controller: controller,
                hintText: "1712345678",
                hintStyle: CustomTextStyles.bodyLargeGray700,
                textInputType: TextInputType.phone,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogItem(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          Container(
            margin: EdgeInsets.only(
              left: 10.h,
            ),
            width: 60.h,
            child: Text(
              "+${country.phoneCode}",
              style: TextStyle(fontSize: 14.fSize),
            ),
          ),
          const SizedBox(width: 8.0),
          Flexible(
            child: Text(
              country.name,
              style: TextStyle(fontSize: 14.fSize),
            ),
          ),
        ],
      );
  void _openCountryPicker(BuildContext context) => showDialog(
        context: context,
        builder: (context) => CountryPickerDialog(
          searchInputDecoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(fontSize: 14.fSize),
          ),
          isSearchable: true,
          title: Text('Select your phone code',
              style: TextStyle(fontSize: 14.fSize)),
          onValuePicked: (Country country) => onTap(country),
          itemBuilder: _buildDialogItem,
        ),
      );
}
