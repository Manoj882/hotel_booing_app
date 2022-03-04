class OnBoardingData {
  late String title;
  late String image;
  late String subtitle;

  OnBoardingData({
    required this.title,
    required this.image,
    required this.subtitle,
  });
}

List<OnBoardingData> onboardingDataList = [
  OnBoardingData(
    title: "Choose Hotel",
    image: "assets/images/choose_hotel.jpg",
    subtitle:  "Find nearby hotel",
  ),
  OnBoardingData(
    title: "Check In and Check Out Date",
    image: "assets/images/check_in_date.jpg",
    subtitle:  "Find nearby hotel",
  ),
  OnBoardingData(
    title: "Select Rooms",
    image: "assets/images/select_room.jpg",
    subtitle:  "Find nearby hotel",
  ),
];
