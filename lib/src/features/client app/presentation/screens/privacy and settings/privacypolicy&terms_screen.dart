import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarApplicationArrow(
        text: 'سياسة الخصوصية',
        onBackTap: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: (Theme.of(context).brightness == Brightness.dark
                  ? Colors.black54
                  : Colors.white),
              boxShadow: shadowList),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSizedBox.kVSpace20,
                CustomStyledText(
                  text: "البنود و الظروف",
                  fontSize: 16,
                  textColor: AppColors.secondaryColor,
                  fontWeight: FontWeight.w700,
                ),
                AppSizedBox.kVSpace10,
                CustomStyledText(
                    fontSize: 14,
                    height: 1.6,
                    text:
                        "من خلال تنزيل التطبيق أو استخدامه، ستنطبق هذه الشروط عليك تلقائيًا - لذا يجب عليك التأكد من قراءتها بعناية قبل استخدام التطبيق. لا يُسمح لك بنسخ أو تعديل التطبيق أو أي جزء من التطبيق أو علاماتنا التجارية بأي شكل من الأشكال. لا يُسمح لك بمحاولة استخراج الكود المصدري للتطبيق، ويجب ألا تحاول أيضًا ترجمة التطبيق إلى لغات أخرى أو إنشاء إصدارات مشتقة. لا يزال التطبيق نفسه وجميع العلامات التجارية وحقوق الطبع والنشر وحقوق قاعدة البيانات وحقوق الملكية الفكرية الأخرى المتعلقة به مملوكة لشركة OptimaWeb for Programming Solustions."),
                AppSizedBox.kVSpace10,
                CustomStyledText(
                    height: 1.6,
                    fontSize: 14,
                    text:
                        "تلتزم OptimaWeb for Programming Solustions بضمان أن يكون التطبيق مفيدًا وفعالًا قدر الإمكان. ولهذا السبب، نحتفظ بالحق في إجراء تغييرات على التطبيق أو فرض رسوم مقابل خدماته، في أي وقت ولأي سبب. لن نقوم أبدًا بتحصيل رسوم منك مقابل التطبيق أو خدماته دون أن نوضح لك تمامًا ما تدفع مقابله."),
                AppSizedBox.kVSpace10,
                CustomStyledText(
                    height: 1.6,
                    fontSize: 14,
                    text:
                        "يقوم تطبيق Siana Plus بتخزين ومعالجة البيانات الشخصية التي قدمتها لنا لتقديم خدمتنا. تقع على عاتقك مسؤولية الحفاظ على أمان هاتفك والوصول إلى التطبيق. لذلك نوصي بعدم كسر الحماية أو عمل روت لهاتفك، وهي عملية إزالة القيود والقيود البرمجية التي يفرضها نظام التشغيل الرسمي لجهازك. يمكن أن يجعل هاتفك عرضة للبرامج الضارة/الفيروسات/البرامج الضارة، مما يعرض ميزات أمان هاتفك للخطر، وقد يعني ذلك أن تطبيق الراية لن يعمل بشكل صحيح أو لن يعمل على الإطلاق."),
                AppSizedBox.kVSpace10,
                CustomStyledText(
                    height: 1.6,
                    fontSize: 14,
                    text:
                        "يستخدم التطبيق خدمات الجهات الخارجية التي تعلن الشروط والأحكام الخاصة بها."),
                CustomStyledText(
                    height: 1.6,
                    fontSize: 14,
                    text:
                        "رابط إلى الشروط والأحكام الخاصة بمقدمي خدمات الطرف الثالث الذين يستخدمهم التطبيق"),
                Divider(),
                AppSizedBox.kVSpace10,
                CustomStyledText(
                  text: "خدمات Google Play ",
                  fontSize: 16,
                  textColor: AppColors.secondaryColor,
                  fontWeight: FontWeight.w700,
                ),
                AppSizedBox.kVSpace10,
                CustomStyledText(
                    height: 1.6,
                    fontSize: 14,
                    text:
                        "يجب أن تدرك أن هناك أشياء معينة لن تتحمل OptimaWeb for Programming Solustions مسؤوليتها. ستتطلب بعض وظائف التطبيق أن يكون لدى التطبيق اتصال نشط بالإنترنت. يمكن أن يكون الاتصال عبر شبكة Wi-Fi أو يتم توفيره بواسطة مزود شبكة الهاتف المحمول الخاص بك، ولكن لا يمكن لـ OptimaWeb for Programming Solustions تحمل مسؤولية التطبيق الذي لا يعمل بكامل وظائفه إذا لم يكن لديك إمكانية الوصول إلى شبكة Wi-Fi، وليس لديك أي من بياناتك بدل اليسار."),
                AppSizedBox.kVSpace5,
                CustomStyledText(
                    height: 1.6,
                    fontSize: 14,
                    text:
                        "إذا كنت تستخدم التطبيق خارج منطقة بها شبكة Wi-Fi، فيجب أن تتذكر أن شروط الاتفاقية مع موفر شبكة الهاتف المحمول الخاص بك ستظل سارية. ونتيجة لذلك، قد يتم تحصيل رسوم منك من قبل مزود خدمة الهاتف المحمول الخاص بك مقابل تكلفة البيانات طوال مدة الاتصال أثناء الوصول إلى التطبيق، أو رسوم أخرى من طرف ثالث. باستخدام التطبيق، فإنك تقبل المسؤولية عن أي رسوم من هذا القبيل، بما في ذلك رسوم بيانات التجوال إذا كنت تستخدم التطبيق خارج إقليمك الأصلي (أي المنطقة أو البلد) دون إيقاف تشغيل تجوال البيانات. إذا لم تكن دافع الفاتورة للجهاز الذي تستخدم التطبيق عليه، فيرجى العلم أننا نفترض أنك حصلت على إذن من دافع الفاتورة لاستخدام التطبيق."),
                AppSizedBox.kVSpace5,
                CustomStyledText(
                    height: 1.6,
                    fontSize: 14,
                    text:
                        "وعلى نفس المنوال، لا يمكن لـ OptimaWeb for Programming Solustions دائمًا تحمل المسؤولية عن الطريقة التي تستخدم بها التطبيق، أي أنك بحاجة إلى التأكد من بقاء جهازك مشحونًا - إذا نفدت طاقة البطارية ولم تتمكن من تشغيله للاستفادة من الخدمة، فلن تتمكن OptimaWeb for Programming Solustions من ذلك. قبول المسؤولية."),
                AppSizedBox.kVSpace5,
                CustomStyledText(
                    height: 1.6,
                    fontSize: 14,
                    text:
                        "فيما يتعلق بمسؤولية OptimaWeb for Programming Solustions عن استخدامك للتطبيق، عند استخدامك التطبيق، من المهم أن تضع في اعتبارك أنه على الرغم من أننا نسعى لضمان تحديثه وتصحيحه في جميع الأوقات، إلا أننا نعتمد على أطراف ثالثة لتوفير المعلومات إلينا حتى نتمكن من إتاحتها لك. لا تتحمل OptimaWeb for Programming Solustions أي مسؤولية عن أي خسارة، مباشرة أو غير مباشرة، قد تتعرض لها نتيجة الاعتماد كليًا على هذه الوظيفة في التطبيق."),
                AppSizedBox.kVSpace10,
                CustomStyledText(
                    height: 1.6,
                    fontSize: 14,
                    text:
                        "في مرحلة ما، قد نرغب في تحديث التطبيق. التطبيق متاح حاليًا على نظامي التشغيل Android وiOS - قد تتغير متطلبات كلا النظامين (وأي أنظمة إضافية نقرر توسيع نطاق توفر التطبيق لها)، وستحتاج إلى تنزيل التحديثات إذا كنت تريد الاحتفاظ بها باستخدام التطبيق. لا تعد شركة OptimaWeb for Programming Solustions بأنها ستقوم دائمًا بتحديث التطبيق بحيث يكون مناسبًا لك و/أو يعمل مع إصدار Android وiOS الذي قمت بتثبيته على جهازك. ومع ذلك، فإنك تتعهد بقبول تحديثات التطبيق دائمًا عندما يتم عرضها عليك، وقد نرغب أيضًا في التوقف عن توفير التطبيق، ويجوز لنا إنهاء استخدامه في أي وقت دون إرسال إشعار إليك بالإنهاء. ما لم نخبرك بخلاف ذلك، عند أي إنهاء، (أ) ستنتهي الحقوق والتراخيص الممنوحة لك بموجب هذه الشروط؛ (ب) يجب عليك التوقف عن استخدام التطبيق، و(إذا لزم الأمر) حذفه من جهازك."),
                CustomStyledText(
                    height: 1.6,
                    fontSize: 14,
                    text: "التغييرات على هذه الشروط والأحكام"),
                AppSizedBox.kVSpace5,
                CustomStyledText(
                    height: 1.6,
                    fontSize: 14,
                    text:
                        "قد نقوم بتحديث الشروط والأحكام الخاصة بنا من وقت لآخر. لذا ننصحك بمراجعة هذه الصفحة بشكل دوري لمعرفة أي تغييرات. وسنقوم بإعلامك بأي تغييرات عن طريق نشر الشروط والأحكام الجديدة على هذه الصفحة."),
                AppSizedBox.kVSpace5,
                CustomStyledText(
                    height: 1.6,
                    fontSize: 14,
                    text: "تسري هذه الشروط والأحكام اعتبارًا من 10-10-2024"),
                Divider(),
                CustomStyledText(
                  textColor: AppColors.secondaryColor,
                  text: "اتصل بنا",
                  height: 1.6,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
                AppSizedBox.kVSpace10,
                CustomStyledText(
                    height: 1.6,
                    fontSize: 13.1,
                    text:
                        "إذا كان لديك أي أسئلة أو اقتراحات حول الشروط والأحكام الخاصة بنا، فلا تتردد في الاتصال بنا على  sianaplus3@gmail.com"),
                AppSizedBox.kVSpace10,
                CustomStyledText(
                    height: 1.6,
                    fontSize: 14,
                    text:
                        "تم إنشاء صفحة الشروط والأحكام هذه بواسطة منشئ سياسة خصوصية التطبيق"),
                AppSizedBox.kVSpace10,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
