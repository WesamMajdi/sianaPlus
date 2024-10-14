import '../../../export file/exportfiles.dart';

class StatisticsCard extends StatelessWidget {
  final String title;
  final String value;

  const StatisticsCard({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomStyledText(
              text: value,
              fontSize: 40,
              fontWeight: FontWeight.w600,
            ),
            AppSizedBox.kVSpace5,
            CustomStyledText(
              text: title,
              fontSize: 13.2,
              fontWeight: FontWeight.bold,
              textColor: AppColors.secondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
