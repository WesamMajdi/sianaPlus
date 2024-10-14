import 'domain.dart';

final List<MainCategory> categories = [
  MainCategory(
      id: 1,
      name: 'الأجهزة المنزلية',
      imagePath: 'assets/images/Household_items.jpeg'),
  MainCategory(
      id: 2,
      name: 'قطع الغيار',
      imagePath: 'assets/images/Microwave spare parts.jpeg'),
  MainCategory(
      id: 3,
      name: 'أدوات السيارات',
      imagePath: 'assets/images/download (2).jpeg'),
];
final List<SubCategory> subcategories = [
  SubCategory(
      id: 1,
      parentId: 1,
      name: 'أدوات المطبخ',
      description: '',
      imagePath: 'assets/images/kitchenware.jpeg'),
  SubCategory(
      id: 2,
      parentId: 1,
      name: 'المكيفات',
      description: '',
      imagePath: 'assets/images/Air conditioner.jpeg'),
  SubCategory(
      id: 3,
      parentId: 1,
      name: 'ثلاجات',
      description: '',
      imagePath: 'assets/images/Untitled-2.png'),
  SubCategory(
      id: 4,
      parentId: 1,
      name: 'غسالات',
      description: '',
      imagePath: 'assets/images/washing machine.jpeg'),
  SubCategory(
      id: 5,
      parentId: 2,
      name: 'قطع غيار الميكروويف',
      description: '',
      imagePath: 'assets/images/Microwave spare parts.jpeg'),
  SubCategory(
      id: 6,
      parentId: 2,
      name: 'قطع غيار المروحة',
      description: '',
      imagePath: 'assets/images/afan.jpeg'),
  SubCategory(
      id: 7,
      parentId: 3,
      name: 'إطارات السيارات',
      description: '',
      imagePath: 'assets/images/download (2).jpeg'),
  SubCategory(
      id: 8,
      parentId: 3,
      name: 'بطاريات السيارات',
      description: '',
      imagePath: 'assets/images/download (2).jpeg'),
];
