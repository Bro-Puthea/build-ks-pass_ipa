class SelectedItemModel {
  String? id;
  String? name;
  String? image;
  String? status;

  SelectedItemModel({this.id, this.name, this.image, this.status});

  SelectedItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['id'] = id ?? '';
    data['name'] = name ?? '';
    data['image'] = image ?? '';
    data['status'] = status ?? '';
    return data;
  }
}
