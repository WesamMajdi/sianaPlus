import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarApplicationArrow(
        text: 'سياسة الخصوصية',
        onBackTap: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black54
                : Colors.white,
            boxShadow: shadowList,
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSizedBox.kVSpace20,
                CustomStyledText(
                  text: "سياسة الخصوصية",
                  fontSize: 16,
                  textColor: AppColors.secondaryColor,
                  fontWeight: FontWeight.w700,
                ),
                AppSizedBox.kVSpace10,
                CustomStyledText(
                  fontSize: 14,
                  height: 1.6,
                  textAlign: TextAlign.justify,
                  text:
                      "نحن في Siana Plus نأخذ خصوصيتك على محمل الجد. يتم جمع رقم الهاتف فقط لغرض إرسال رمز تحقق لضمان أمان الحساب، ولا تتم مشاركة أي بيانات شخصية مع أي طرف ثالث. لا نقوم بجمع بيانات حساسة مثل الصور، الصوت، أو الموقع الجغرافي إلا بموافقة صريحة من المستخدم، ويتم استخدامها فقط لتقديم الخدمات المطلوبة. يتم حفظ البيانات بشكل آمن ومشفّر، ولا يتم استخدامها لأي أغراض تجارية أو دعائية.",
                ),
                AppSizedBox.kVSpace10,
                CustomStyledText(
                  fontSize: 14,
                  height: 1.6,
                  textAlign: TextAlign.justify,
                  text:
                      "قد نستخدم بعض خدمات الجهات الخارجية (مثل Firebase، خرائط Google) لتوفير تجربة مستخدم أفضل، وقد تخضع هذه الخدمات لسياسات خصوصية منفصلة. نحن نوصي بمراجعة سياسات الخصوصية الخاصة بها.",
                ),
                Divider(),
                AppSizedBox.kVSpace10,
                CustomStyledText(
                  text: "خدمات الطرف الثالث",
                  fontSize: 16,
                  textColor: AppColors.secondaryColor,
                  fontWeight: FontWeight.w700,
                ),
                AppSizedBox.kVSpace10,
                CustomStyledText(
                  fontSize: 14,
                  height: 1.6,
                  textAlign: TextAlign.justify,
                  text:
                      "قد يتضمن التطبيق روابط إلى خدمات خارجية مثل Google Play Services أو خرائط Google، والتي قد تجمع معلومات لتحديد هويتك. نحن لا نتحكم في سياسات الخصوصية لهذه الخدمات، لذا ننصح بقراءتها بشكل منفصل.",
                ),
                Divider(),
                AppSizedBox.kVSpace10,
                CustomStyledText(
                  text: "أمان البيانات",
                  fontSize: 16,
                  textColor: AppColors.secondaryColor,
                  fontWeight: FontWeight.w700,
                ),
                AppSizedBox.kVSpace10,
                CustomStyledText(
                  fontSize: 14,
                  height: 1.6,
                  textAlign: TextAlign.justify,
                  text:
                      "نستخدم بروتوكولات حماية حديثة لتشفير وتخزين البيانات بشكل آمن. ومع ذلك، لا يمكن ضمان أمان أي وسيلة نقل عبر الإنترنت بنسبة 100%.",
                ),
                Divider(),
                AppSizedBox.kVSpace10,
                CustomStyledText(
                  text: "حقوق المستخدم",
                  fontSize: 16,
                  textColor: AppColors.secondaryColor,
                  fontWeight: FontWeight.w700,
                ),
                AppSizedBox.kVSpace10,
                CustomStyledText(
                  fontSize: 14,
                  height: 1.6,
                  textAlign: TextAlign.justify,
                  text:
                      "يحق لك الوصول إلى بياناتك الشخصية أو تعديلها أو طلب حذفها في أي وقت عن طريق التواصل معنا.",
                ),
                Divider(),
                AppSizedBox.kVSpace10,
                CustomStyledText(
                  text: "تغييرات على سياسة الخصوصية",
                  fontSize: 16,
                  textColor: AppColors.secondaryColor,
                  fontWeight: FontWeight.w700,
                ),
                AppSizedBox.kVSpace10,
                CustomStyledText(
                  fontSize: 14,
                  height: 1.6,
                  textAlign: TextAlign.justify,
                  text:
                      "قد نقوم بتحديث هذه السياسة من وقت لآخر. سيتم إعلام المستخدم بأي تغييرات من خلال هذه الصفحة.",
                ),
                AppSizedBox.kVSpace10,
                CustomStyledText(
                  fontSize: 14,
                  height: 1.6,
                  text: "آخر تحديث: 10-10-2024",
                ),
                Divider(),
                CustomStyledText(
                  text: "اتصل بنا",
                  fontSize: 16,
                  textColor: AppColors.secondaryColor,
                  fontWeight: FontWeight.w800,
                ),
                AppSizedBox.kVSpace10,
                CustomStyledText(
                  fontSize: 13.1,
                  height: 1.6,
                  textAlign: TextAlign.justify,
                  text:
                      "إذا كان لديك أي استفسار حول سياسة الخصوصية الخاصة بنا، يرجى التواصل معنا عبر البريد الإلكتروني: sianaplus3@gmail.com",
                ),
                AppSizedBox.kVSpace20,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
