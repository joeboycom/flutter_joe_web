import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_joe_web/features/contact/presentation/models/contact_model.dart';
import 'package:flutter_joe_web/features/contact/presentation/widgets/contact_card.dart';
import 'package:flutter_joe_web/features/contact/presentation/widgets/contact_form.dart';
import 'package:flutter_joe_web/features/contact/presentation/widgets/social_links.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    final contactMethods = ContactMethodModel.getSampleContactMethods();
    
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 頁面標題
            Text(
              'Contact Me',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(duration: 600.ms),
            
            const SizedBox(height: 16),
            
            // 頁面描述
            Text(
              'Let\'s connect! Feel free to reach out to me for collaboration, consultation, or just to say hello.',
              style: theme.textTheme.bodyLarge,
            ).animate().fadeIn(duration: 600.ms, delay: 100.ms),
            
            const SizedBox(height: 32),
            
            // 聯絡卡片和表單
            if (isDesktop)
              // 桌面版: 卡片在左側，表單在右側
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 左側：聯絡卡片
                  Expanded(
                    flex: 1,
                    child: _buildContactCards(contactMethods),
                  ),
                  
                  const SizedBox(width: 32),
                  
                  // 右側：聯絡表單
                  Expanded(
                    flex: 2,
                    child: _buildContactFormCard(context),
                  ),
                ],
              )
            else
              // 移動版：表單在上，卡片在下
              Column(
                children: [
                  // 聯絡卡片
                  _buildContactCards(contactMethods),
                  
                  const SizedBox(height: 32),
                  
                  // 聯絡表單
                  _buildContactFormCard(context),
                ],
              ),
            
            const SizedBox(height: 64),
            
            // 社交鏈接部分
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: ResponsiveRowColumn(
                  layout: isDesktop ? ResponsiveRowColumnType.ROW : ResponsiveRowColumnType.COLUMN,
                  rowCrossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 社交鏈接
                    ResponsiveRowColumnItem(
                      rowFlex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: SocialLinks(),
                      ),
                    ),
                    
                    // 分隔符
                    if (isDesktop)
                      ResponsiveRowColumnItem(
                        child: SizedBox(
                          height: 300,
                          child: VerticalDivider(
                            color: theme.colorScheme.outline.withOpacity(0.3),
                            width: 1,
                            thickness: 1,
                          ),
                        ),
                      ),
                    
                    // 預約會議部分
                    ResponsiveRowColumnItem(
                      rowFlex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Schedule a Meeting',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ).animate().fadeIn(duration: 600.ms),
                            
                            const SizedBox(height: 8),
                            
                            Text(
                              'Prefer a real-time conversation? Book a slot for a virtual meeting with me.',
                              style: theme.textTheme.bodyMedium,
                            ).animate().fadeIn(duration: 600.ms, delay: 100.ms),
                            
                            const SizedBox(height: 24),
                            
                            ElevatedButton.icon(
                              onPressed: () {
                                // 實際應用中，這裡可以打開一個日曆預約小部件
                                print('Opening calendar to schedule a meeting');
                              },
                              icon: const Icon(Icons.calendar_today),
                              label: const Text('Book a Meeting'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ),
                              ),
                            ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
            
            const SizedBox(height: 64),
            
            // 位置地圖
            Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map,
                    size: 64,
                    color: theme.colorScheme.primary.withOpacity(0.5),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Text(
                    'Map placeholder',
                    style: theme.textTheme.titleLarge,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    'In a real application, a Google Map or other map provider would be shown here.',
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 500.ms),
          ],
        ),
      ),
    );
  }
  
  // 構建聯絡卡片部分
  Widget _buildContactCards(List<ContactMethodModel> contactMethods) {
    return Column(
      children: List.generate(
        contactMethods.length,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: ContactCard(
            contactMethod: contactMethods[index],
            index: index,
          ),
        ),
      ),
    );
  }
  
  // 構建聯絡表單卡片
  Widget _buildContactFormCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ContactForm(),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 300.ms);
  }
}
