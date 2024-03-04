import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:second_ecommerce_app_flutter/models/payment_method_model.dart';
import 'package:second_ecommerce_app_flutter/utils/app_colors.dart';
import 'package:second_ecommerce_app_flutter/utils/route/app_routes.dart';
import 'package:second_ecommerce_app_flutter/view_models/payment_cubit/payment_cubit.dart';

class AddPaymentCard extends StatefulWidget {
  const AddPaymentCard({super.key});

  @override
  State<AddPaymentCard> createState() => _AddPaymentCardState();
}

class _AddPaymentCardState extends State<AddPaymentCard> {

  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _cardNumberController, _cardHolderNameController, _expiredController, _cvvCodeController;
  late FocusNode _cardNumberFocusNode, _cardHolderNameFocusNode, _expiredFocusNode, _cvvCodeFocusNode;
  bool visibility = false;

  //String? _cardNumber, _cardHolderName, _expired, _cvvCode ;

  @override
  void initState(){
    _formKey = GlobalKey<FormState>();

    _cardNumberController = TextEditingController();
    _cardHolderNameController = TextEditingController();
    _expiredController = TextEditingController();
    _cvvCodeController = TextEditingController();

    _cardNumberFocusNode = FocusNode();
    _cardHolderNameFocusNode = FocusNode();
    _expiredFocusNode = FocusNode();
    _cvvCodeFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose(){
    _cardNumberController.dispose();
    _cardHolderNameController.dispose(); 
    _expiredController.dispose(); 
    _cvvCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    PaymentMethodModel newPaymentMethod ;
    final paymentCubit = BlocProvider.of<PaymentCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Card',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
               key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24.0,),
                  Text(
                    'Card Number',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8.0,),
                  TextFormField(
                    controller: _cardNumberController,
                    keyboardType: TextInputType.number,
                    focusNode: _cardNumberFocusNode,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: (){
                      _cardNumberFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(_cardHolderNameFocusNode);
                    },
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please enter your card number';
                      }else if(value.contains(RegExp(r'[a-z-A-Z]'))){
                        return 'Please enter a valid card number';
                      }else{
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Card Number',
                      prefixIcon: const Icon(FontAwesomeIcons.alignLeft),
                      prefixIconColor: _cardNumberController.text.isNotEmpty ? Theme.of(context).colorScheme.primary : AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  Text(
                    'Card Holder Name',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8.0,),
                  TextFormField(
                    controller: _cardHolderNameController,
                    keyboardType: TextInputType.name,
                    focusNode: _cardHolderNameFocusNode,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: (){
                      _cardHolderNameFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(_expiredFocusNode);
                    },
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please enter your holder name';
                      }else if(value.length < 3){
                        return 'Holder Name must be at least 3 characters';
                      }else{
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Holder Name',
                      prefixIcon: const Icon(FontAwesomeIcons.user),
                      prefixIconColor:  _cardHolderNameController.text.isNotEmpty ? Theme.of(context).colorScheme.primary : AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  Text(
                    'Expired',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8.0,),
                  TextFormField(
                    controller: _expiredController,
                    keyboardType: TextInputType.number,
                    focusNode: _expiredFocusNode,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: (){
                      _expiredFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(_cvvCodeFocusNode);
                    },
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please enter your card expired date';
                      }else if(!value.contains(RegExp(r'[0-9]/[0-9]'))){
                        return 'Please enter a valid expire date with format (MM/YY)';
                      }
                      else{
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'MM/YY',
                      prefixIcon: const Icon(FontAwesomeIcons.calendar),
                      prefixIconColor:  _expiredController.text.isNotEmpty ? Theme.of(context).colorScheme.primary : AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  Text(
                    'CVV Code',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8.0,),
                  TextFormField(
                    controller: _cvvCodeController,
                    focusNode: _cvvCodeFocusNode,
                    onEditingComplete: () {
                          _cvvCodeFocusNode.unfocus();
                          if(_formKey.currentState!.validate()){

                            newPaymentMethod = PaymentMethodModel(
                                id: DateTime.now().toIso8601String(),
                                cardNumber: _cardNumberController.text, 
                                cardHolderName: _cardHolderNameController.text, 
                                expiryDate: _expiredController.text, 
                                ccvCard: _cvvCodeController.text,
                            );

                            paymentCubit.addNewPaymentMethod(newPaymentMethod);
      
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                              content: Text('Added new card Success!'),
                              ),
                            );

                            Navigator.of(context, rootNavigator: true).popAndPushNamed(
                              AppRoutes.payment ,
                            );
                          }
                    },
                    decoration: InputDecoration(
                      hintText: 'CVV',
                      prefixIcon: const Icon(Icons.password),
                      prefixIconColor: _cardHolderNameController.text.isNotEmpty ? Theme.of(context).colorScheme.primary : AppColors.grey,
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please enter your CCV code';
                      }else if(value.length < 5){
                        return 'CVV code must be at least 5 numbers';
                      }else if(value.contains(RegExp(r'[a-z-A-Z]'))){
                        return 'CVV code must be only numbers';
                      }
                      else{
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 40.0,),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: (){
                          if(_formKey.currentState!.validate()){

                            newPaymentMethod = PaymentMethodModel(
                                id: DateTime.now().toIso8601String(),
                                cardNumber: _cardNumberController.text, 
                                cardHolderName: _cardHolderNameController.text, 
                                expiryDate: _expiredController.text, 
                                ccvCard: _cvvCodeController.text
                            );

                            paymentCubit.addNewPaymentMethod(newPaymentMethod);
      
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                              content: Text('Added new card Success!'),
                              ),
                            );

                            Navigator.of(context, rootNavigator: true).popAndPushNamed(
                              AppRoutes.payment ,
                            );
                          }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: AppColors.white,
                          ), 
                          child: const Text('Add Card'),
                        ),
                      ),
                    ),
                  const SizedBox(height: 24.0,),
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}