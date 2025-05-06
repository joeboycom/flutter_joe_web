import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  // 表單鍵和控制器
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  
  // 提交狀態
  bool _isSubmitting = false;
  String? _submitError;
  bool _submitSuccess = false;
  
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }
  
  // 表單提交處理
  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    setState(() {
      _isSubmitting = true;
      _submitError = null;
      _submitSuccess = false;
    });
    
    // 在實際應用中，這裡會是一個API調用來發送表單數據
    // 這裡模擬一個API調用
    await Future.delayed(const Duration(seconds: 2));
    
    // 模擬成功提交
    setState(() {
      _isSubmitting = false;
      _submitSuccess = true;
      
      // 清除表單
      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();
      _formKey.currentState!.reset();
    });
    
    // 5秒後重置成功狀態
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _submitSuccess = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 表單標題
          Text(
            'Send me a message',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn(duration: 600.ms),
          
          const SizedBox(height: 8),
          
          // 表單子標題
          Text(
            'Fill out the form below, and I\'ll get back to you as soon as possible.',
            style: theme.textTheme.bodyMedium,
          ).animate().fadeIn(duration: 600.ms, delay: 100.ms),
          
          const SizedBox(height: 24),
          
          // 名稱輸入欄位
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              hintText: 'Enter your full name',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
          
          const SizedBox(height: 16),
          
          // 電子郵件輸入欄位
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email address',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
          ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
          
          const SizedBox(height: 16),
          
          // 主題輸入欄位
          TextFormField(
            controller: _subjectController,
            decoration: const InputDecoration(
              labelText: 'Subject',
              hintText: 'What is your message about?',
              prefixIcon: Icon(Icons.subject),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a subject';
              }
              return null;
            },
          ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
          
          const SizedBox(height: 16),
          
          // 訊息輸入欄位
          TextFormField(
            controller: _messageController,
            decoration: const InputDecoration(
              labelText: 'Message',
              hintText: 'Type your message here...',
              prefixIcon: Icon(Icons.message),
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your message';
              }
              if (value.length < 10) {
                return 'Message should be at least 10 characters long';
              }
              return null;
            },
            maxLines: 5,
            minLines: 3,
          ).animate().fadeIn(duration: 600.ms, delay: 500.ms),
          
          const SizedBox(height: 24),
          
          // 提交按鈕
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _isSubmitting ? null : _submitForm,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: _isSubmitting
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Text('Send Message'),
            ),
          ).animate().fadeIn(duration: 600.ms, delay: 600.ms),
          
          const SizedBox(height: 16),
          
          // 錯誤訊息
          if (_submitError != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: theme.colorScheme.error,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.error,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      _submitError!,
                      style: TextStyle(
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms),
          
          // 成功訊息
          if (_submitSuccess)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.green,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Your message has been sent successfully! I\'ll get back to you soon.',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms),
        ],
      ),
    );
  }
} 