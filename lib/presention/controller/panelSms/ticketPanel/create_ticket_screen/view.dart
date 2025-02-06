import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateTicketDialog extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final departments = ['Technical', 'Billing', 'General', 'Support'].obs;
  final selectedDepartment = 'Technical'.obs;

  CreateTicketDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'ایجاد تیکت جدید',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'موضوع',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                  value?.isEmpty ?? true ? 'لطفا موضوع را وارد کنید' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'توضیحات',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                  validator: (value) =>
                  value?.isEmpty ?? true ? 'لطفا توضیحات را وارد کنید' : null,
                ),
                const SizedBox(height: 16),
                Obx(() => DropdownButtonFormField<String>(
                  value: selectedDepartment.value,
                  decoration: const InputDecoration(
                    labelText: 'بخش مربوطه',
                    border: OutlineInputBorder(),
                  ),
                  items: departments
                      .map((dept) => DropdownMenuItem(
                    value: dept,
                    child: Text(dept),
                  ))
                      .toList(),
                  onChanged: (value) => selectedDepartment.value = value!,
                )),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // if (_formKey.currentState?.validate() ?? false) {
                      //   controller.createNewTicket(
                      //     titleController.text,
                      //     descriptionController.text,
                      //     selectedDepartment.value,
                      //   );
                      // }
                    },
                    child: const Text('ثبت تیکت'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
