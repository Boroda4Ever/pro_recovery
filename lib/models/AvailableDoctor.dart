class AvailableDoctor {
  final String? name, sector, patients, image;
  final int? experience;

  AvailableDoctor(
      {this.name, this.sector, this.experience, this.patients, this.image});
}

List<AvailableDoctor> demoAvailableDoctors = [
  AvailableDoctor(
    name: "Алла Иванова",
    sector: "Булимия",
    experience: 8,
    patients: '25.04.22',
    image: "assets/images/Serena_Gome.png",
  ),
];
