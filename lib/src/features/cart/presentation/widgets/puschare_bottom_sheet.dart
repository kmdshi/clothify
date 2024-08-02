import 'package:ecom_app/core/presentation/widgets/eleveated_button_widget.dart';
import 'package:ecom_app/src/features/cart/presentation/widgets/row_cost_widget.dart';
import 'package:ecom_app/src/features/cart/presentation/widgets/row_seporator_widget.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showPurchaseBottom({
  required BuildContext context,
  required TextEditingController promoController,
}) {
  showMaterialModalBottomSheet(
    context: context,
    barrierColor: Colors.transparent,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(42.0),
      ),
    ),
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * .45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              offset: const Offset(-4, -3),
              blurRadius: 30,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              offset: const Offset(4, -3),
              blurRadius: 30,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 60,
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey.withOpacity(.35),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: promoController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF3F3F3),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 13.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.4), width: 0.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.4), width: 0.5),
                  ),
                  prefixIcon: SizedBox(
                    width: 15,
                    height: 15,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Transform.scale(
                        scale: 1.4,
                        child: const Icon(Icons.abc),
                      ),
                    ),
                  ),
                  suffixIcon: SizedBox(
                    width: 15,
                    height: 15,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Transform.scale(
                        scale: 1.4,
                        child: const Icon(Icons.chevron_right),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const RowCostWidget(
                cost: 93.00,
                text: 'Subtotal',
              ),
              const SizedBox(height: 15),
              const RowCostWidget(
                cost: 6.00,
                text: 'Shipping',
              ),
              const SizedBox(height: 15),
              RowSeporatorWidget(
                color: Colors.grey.withOpacity(0.4),
              ),
              const SizedBox(height: 15),
              const RowCostWidget(
                cost: 98.00,
                text: 'Total amount',
              ),
              const SizedBox(height: 50),
              ElvButtonWidget(textContent: 'Checkout', onPressed: () {})
            ],
          ),
        ),
      );
    },
  );
}
