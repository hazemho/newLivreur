

class CarTypeData {

  final String carTitle;
  final String carImagePath;
  final String? carDescription;

  CarTypeData({required this.carTitle, required this.carImagePath, this.carDescription});

  static List<CarTypeData> get listCarData{
    return [
      CarTypeData(carTitle: 'Moto', carImagePath: ''),
      CarTypeData(carTitle: 'Voiture', carImagePath: ''),
      CarTypeData(carTitle: 'Camion', carImagePath: ''),
    ];
  }

}