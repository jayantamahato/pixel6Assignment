import 'package:flutter/material.dart';

import '../../core/exports.dart';
import '../../uiHelper/exports.dart';

class AddressCard extends StatelessWidget {
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String postalCode;
  final String state;
  final Function delete;
  final Function edit;
  const AddressCard(
      {super.key,
      required this.addressLine1,
      required this.addressLine2,
      required this.city,
      required this.state,
      required this.delete,
      required this.edit,
      required this.postalCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      width: percentWidth(percent: 55),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            AppColor.gradient2.withOpacity(0.1),
            AppColor.gradient1.withOpacity(0.1)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: percentWidth(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  addressLine1,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
                addressLine2.isNotEmpty
                    ? Text(
                        addressLine2,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                      )
                    : const SizedBox(),
                Text(
                  city,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
                Text(
                  state,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
                Text(
                  postalCode,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  maxRadius: 15,
                  backgroundColor: AppColor.primary.withOpacity(0.5),
                  foregroundColor: AppColor.white,
                  child: IconButton(
                    onPressed: () {
                      edit();
                    },
                    icon: const Icon(
                      Icons.edit,
                      size: 15,
                    ),
                  ),
                ),
                whiteSpace(width: 10),
                CircleAvatar(
                  maxRadius: 15,
                  backgroundColor: AppColor.primary.withOpacity(0.5),
                  foregroundColor: AppColor.white,
                  child: IconButton(
                    onPressed: () {
                      delete();
                    },
                    icon: const Icon(
                      Icons.delete,
                      size: 15,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
