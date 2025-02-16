import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/otp_cubit.dart';

class OtpInputFields extends StatelessWidget {
  const OtpInputFields({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtpInputCubit, List<String>>(
      builder: (context, otpValues) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(4, (index) {
            return SizedBox(
              width: 60,
              height: 60,
              child: TextField(
                controller: TextEditingController(text: otpValues[index])..selection = TextSelection.collapsed(offset: otpValues[index].length),
                keyboardType: TextInputType.number,
                maxLength: 1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  counterText: "",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    context.read<OtpInputCubit>().updateOtp(index, value);

                    // Move to next field if not last
                    if (index < 3) {
                      FocusScope.of(context).nextFocus();
                    } else {
                      FocusScope.of(context).unfocus(); // Hide keyboard after last digit
                    }
                  } else {
                    // If user clears input, go back to previous field
                    if (index > 0) {
                      FocusScope.of(context).previousFocus();
                    }
                  }
                },
              ),
            );
          }),
        );
      },
    );
  }
}
