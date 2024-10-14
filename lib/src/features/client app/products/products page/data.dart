import '../../../../core/export file/exportfiles.dart';

List<Color> clrs = [
  Colors.white,
  Colors.grey,
  AppColors.darkGrayColor,
  Colors.black
];

final List<Product> products = [
  Product(
      name: "طقم طناجر",
      description: "هو عبارة عن طقم طناجر مكون من 16 قطعة",
      imagePath: "assets/images/kitchenware.jpeg",
      price: 55.0,
      discount: 0.50,
      colors: clrs,
      rating: 2),
  Product(
      name: "مكيف",
      description: "هو مكيف LG بحجم 2 طن مع ضمانة لمدة سنتين",
      imagePath: "assets/images/Air conditioner.jpeg",
      price: 75.0,
      discount: 0.20,
      isFavorite: true,
      colors: clrs,
      rating: 2),
  Product(
      name: "ثلاجة",
      description:
          "هي ثلاجة LG بطاقة استيعابية تبلغ 12 إلى 16 قدم مكعب تعادل 340 لتر حتى 450 لتر تقريباً  ",
      imagePath: "assets/images/refrigerator.jpeg",
      price: 300.0,
      discount: 0.60,
      isFavorite: true,
      colors: clrs,
      rating: 2),
  Product(
      name: "غسالة",
      description: "غسالة ونشافة بسعة 15/8 كغ WDL91H62PN لون سلفر",
      imagePath: "assets/images/washing machine.jpeg",
      price: 350.0,
      discount: 0.45,
      colors: clrs,
      rating: 2),
  Product(
      name: "قطع غيار ميكروويف",
      description: "قطع غيار ميكروويف فريش و الاصلاح بالمنزل فى جميع الاعطال",
      imagePath: "assets/images/Microwave spare parts.jpeg",
      price: 150,
      discount: 0.30,
      colors: clrs,
      rating: 3.5),
  Product(
      name: "قطع غيار مروحة",
      description: "قطع غيار مروحة كهربائية عالية الجودة والفعالة للمركبات",
      imagePath: "assets/images/afan.jpeg",
      price: 200.0,
      discount: 0,
      colors: clrs,
      rating: 2),
  Product(
      name: "قطع غيار ميكروويف",
      description: "قطع غيار ميكروويف فريش و الاصلاح بالمنزل فى جميع الاعطال",
      imagePath: "assets/images/Microwave spare parts.jpeg",
      price: 150,
      discount: 0.30,
      isFavorite: true,
      colors: clrs,
      rating: 2),
];
