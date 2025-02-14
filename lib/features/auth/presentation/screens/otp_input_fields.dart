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
          children: List.generate(
            4,
            (index) {
              final focusNodes = List.generate(4, (i) => FocusNode());

              return SizedBox(
                width: 60,
                height:60,
                child: TextField(
                  focusNode: focusNodes[index],
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
                      if (index < 3) {
                        FocusScope.of(context).nextFocus(); 
                      }
                    }
                  },
                  onSubmitted: (value) {
                    if (value.isEmpty && index > 0) {
                      FocusScope.of(context).previousFocus(); 
                    }
                  },
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
