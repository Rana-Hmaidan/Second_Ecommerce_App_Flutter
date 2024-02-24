enum ProductSize {
  S,
  M,
  L,
  XL,
}

class ProductItemModel {
  final String id;
  final String name;
  final String imgUrl;
  final String description;
  final double price;
  final int quantity;
  final String category;
  final ProductSize? size;
  final double averageRate;
  final int searchCount;
  bool isFavorite;
  bool isAddedToCart;

  ProductItemModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    this.size,
    this.description =
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    required this.price,
    required this.category,
    this.averageRate = 4.5,
    this.searchCount = 4,
    this.isFavorite = false,
    this.isAddedToCart =false,
    this.quantity = 1,
  });

  ProductItemModel copyWith({
    String? id,
    String? name,
    String? imgUrl,
    String? description,
    double? price,
    String? category,
    double? averageRate,
    int? searchCount,
    int? quantity,
    ProductSize? size,
    bool? isFavorite,
    bool? isAddedToCart,
  }) {
    return ProductItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      averageRate: averageRate ?? this.averageRate,
      searchCount: searchCount ?? this.searchCount,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      isFavorite: isFavorite ?? this.isFavorite,
      isAddedToCart: isAddedToCart ?? this.isAddedToCart,
    );
  }

    Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'imgUrl': imgUrl});
    result.addAll({'description': description});
    result.addAll({'price': price});
    result.addAll({'category': category});
    result.addAll({'averageRate': averageRate});
    result.addAll({'searchCount': searchCount});
    result.addAll({'quantity': quantity});
    result.addAll({'size': size});
    result.addAll({'isFavorite': isFavorite});
    result.addAll({'isAddedToCart': isAddedToCart});

    return result;
  }

  factory ProductItemModel.fromMap(
      Map<String, dynamic> map, String documentId) {
    return ProductItemModel(
      id: documentId,
      name: map['name'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      category: map['category'] ?? '',
      averageRate: map['averageRate']?.toDouble() ?? 0.0,
      searchCount: map['searchCount']?.toInt() ?? 0,
      quantity: map['quantity']?.toInt() ?? 0,
      size: map['size'] ?? '',
      isFavorite: map['isFavorite'] ?? false,
      isAddedToCart: map['isAddedToCart'] ?? false,
    );
  }
}

//List<ProductItemModel> favProducts = dummyProducts.where((item) => item.isFavorite == true).toList();

List<ProductItemModel> dummyProducts = [
  ProductItemModel(
    id: 'cuKC6kIxLS3AFYqpHboW',
    name: 'Sweet Shirt',
    imgUrl:
        'https://www.usherbrand.com/cdn/shop/products/5uYjJeWpde9urtZyWKwFK4GHS6S3thwKRuYaMRph7bBDyqSZwZ_87x1mq24b2e7_1800x1800.png',
    price: 15,
    category: 'Clothes',
    size: ProductSize.S,
    isAddedToCart: true,
  ),
  ProductItemModel(
    id: 'jf2oK0qTObicuOktO2Ay',
    name: 'Black Shoes',
    imgUrl: 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAoHCBYVFRgWFhYZGBgaGhgYGhoYGBoaHB4cGBoaGRgeHhgcIS4lHB4rHxghJjgmKy8xNTU1HCQ7QDs0Py40NTEBDAwMDw8PGBERGDQdGCE/NDE0MT8xMTQ0NDE/MT80PzExND8xNDExMTQxNDQ/NDE/Pz80MTQxMTQxMT80PzQ0P//AABEIALcBEwMBIgACEQEDEQH/xAAcAAACAgMBAQAAAAAAAAAAAAAAAQIFBAYHAwj/xABAEAABAgQCBwYEBgIBAgcBAAABAAIRIUFRA2EEEjFScYHwBSJCYoKiBqGxwQcTMnKR4ZLRFCPxMzRDRLLS4hX/xAAWAQEBAQAAAAAAAAAAAAAAAAAAAQL/xAAXEQEBAQEAAAAAAAAAAAAAAAAAAREx/9oADAMBAAIRAxEAPwDrkoeX5xTnHzUtBE4+a1IJSh5amsf9ICUDu1vHJOov4eGaDGIvQUIzRe3iyOSAv7uOSLe3+/ki3tzGaV/dlwQSv7v6Stbw8c0re3Pii9/FkMkDEYm9bQyRKA3aXj1FKUBahqTmnOPmqKQQOcfN8oKMoeX5xRKHlvWKc4+a1IICcfNS0ESgd2t49QRKHlqaxROPmoKQzQFRfw8M0Xt4uOSVDbxXByTtfw5jNA7e3+0r+7+kr+7Lgi3tz4oHa3h45onE38VoZIvfxZDJKgt4TUnNA5QG7S8UTj5q2ggEx81RSGSJQ8tDWKBSh5fnFSnHzfKCU4+a1IIlDy3rFASgd2t49QQYxF6WhmicfNQUglKBtU1ByQO9vFxyRb2/2la/hzGaL+7Lggd/d/XzRb2/2lb258UX92XBA6m/i4ZJSgN2l45p2t4czmgRib1FAMkBOPmraCJQ8vziiUPLQ1iicfNakEEu/khefduUIJSht7t6xREx2d6gpC6Jx2T3acUuct6oNkBKHlqag2GSf1oLjNHKdBQ5pfSp3cggL+7Lgnb258UidnyG9xUYmnPy0l1RBK/uy4Itbwm5zR0PNxT6I3cwgPrUUAySlDy0NSbJ/ShvkUcp1bQC/V0BOOzvWpC6Uobe7esbIleW9XgnO092nFATjs71qQSlDKpqDYJ85b1eCOU6Noc+rID60FCM0Xt4sjkoF0pbNpNv6XPfxC/EAaIHYGAQcb9LnyOpEbADEF8DExk2IiCTBBvmmdo4WFD83FYzd13tbrf5Fe7Hhwi0ggiJIMQAag1XyRpenYmI8ve9znO2uLiSeJJiea7F+GXxE9mDqPi5oDXAVmNgjeAPNB1a3tz4p/WosMl46JpLMVjcRjg5j2teCNmq4RBHIr2+lDfIoCUMqGpKBGOzvVFIXRynUUGaUry3qxsgcobe7esUTjs71qQuidp7tOKiXC5hvViaXQOUNvdqag2R9aChFyk2NROjb5p/SpqMggL28Rsck7e3Pin0BfMqPR8vBAX92XBFvbnxT6Hm49VR0fLwQF71Fhkl9KGpNin9KG+RRynUUGaAiY7J1FALolDb3b1ikT/FDUm3VlEEkyE92kLoPSLrBCjLeKED5y3q8Ecp7tDn1ZPl6fulz9VsuroDn6rZdXSJ/wC29mU+Xpvn1ZQM/wDe6gRnwr5VMDZanm49VSA63s0+v29fZA+j5eHVEugd7Ip9fu6+6OobuaB8uVs1HnLeqcurI5+q+SfL02z6ugOU92nFHOW9Xgjn6vsny9P3QLlPdoc+rKDjQHi6oyTcaR9X26utT+MfjLD0JpaNU40I6pm1gd+l74TJNGCboUAJAePx/wDFzdCwnMY6GO5sRCBGG0+Jw2a58InOezb88aXpBe4uMZx2kkzMTEnaSTEmpJKze2+1naQ9z3EklxcXOMXOJAEXf4yAk0SCqiEHphYZcQAIkkADM7F0zsxzcFrGtPgaDGR2REQdiovg/sOX/JxB3BHUafFnwpmvbtB73Pc8yMZ9cER0n8Nu2v8AoswHGQiGf5OAacjD5roPUN3NcA+H+0NRrQJd1hHGZP1XbOwO0Rj4LXE94SddxH/cIRZc5b18urJ8p7tBn1dHL02z6ukTn6vt1ZFDnQG31V4KLQYzE92U80AVh6b5qQGfqtkgBx9VsurqXLlfNLl6b59WS5+rdyQHRO7kEdDzcU+ob2aOv29fZAdHy8OqJdDzcU+v3dfdLr9uaB9EbuYSJzlvXy6smejvZKBnSe7u5oFMnZ6aDZPj/tTAzlvVOSAM4Devl1ZPl6fugJ7qaXrQgfP1fZLl6b59WRylu14pc571Bl1dAc/VbLq6fUN7NHL03z6sjqO7kgOo7uSOv3dfdLo+bMJ9Dy8eqIF1+3r7J9R3skdHzcOqo6hu5oFy9O7mnz9V8urI5897JHL02z6ugq+2u2W6M1sW6znmDWRhs2uJhIclWu+KixutiYYhdjw50P2uDR81S9s4TNI01+sA9uGAzvCIlMgDYJrWvi/R8LCbBjAwwj3CWD+BI/wiL34p/EljcMjRT3od97m/+HOAAYYF7zTwjbEriXaXaDsZxc4mZJm4uJJ2uc4/qcangBAAAewc8P1mElwibxFYgyMqJ6ZgNeNfDbqu2vYIwzc2wnNtIylsKqgFuvwx8Hl4GNpAIZtayruNhkrn4O+EGtaMbGbEwBAdnYdfNbL2hpAEhsEgiawMdw/QBASkNgAVD2zBoJosvTNOawEkrUu0O0nYndCoMDSYMZDbNv8Ai9w+hC27sn4mczFwMNh7wc0mF3FsW/4NMcnLStDwXBzgIBzTMkRDQ6EzDaYmAaJkmABVp2YzVxe4IlsZmZjWJq6riJbGiMIqFfRWg6W3FYHsMjGJrESLTn/pZHL02z6uud/hr2oS5+A7vAxcMiNp/hdE5z3qHLqyEPn6vsly9P3Rylu14o5z3qcEUc/VbLq6XL03zT5em+fVkufq3ckD6ju5I6/d190uob2YT6Hl4oF1+3r7J9fuyR0fNw6ql1+3igfUN3NHP1Xy6sjqO9kjl6bZ9XQHL02z6unz9X2S5+q+XVkcpbteKA9CE/UhApx2z3qcEuUt2pz6siUNndtWN04GO2dDQCyA5zoaDJH0qL5hL6VFSbhP60NhmgOh5eKOj5uHVUr+7Pgnb5ZcUC6Hl4p9E72QRf3Z8EWtQW4oD6UFsysbtHShhYb8Qn9DS4uoZSH8wWT9amhFgtS+PNLhh4eA0w/MdEioa3bHIlBUfD+GSC921xLzzmtJ+N9L1nOnsP0W/NgzCJjRcj+L9K1n6oqiPT4QwGve57wC1rXF0bDNY2g6I52LhtbIl4gLRjt8obHbZZnZI1NGLa4hgf2N7z45HZ0Qrv4R0Ya78dw/TFjLRdAvPEABvMoNpxn6gDYkwAETMyFc1r/a2nhgJJWdpukwBJWids6drvhrQaNpVHji4rtIeYSaNpyU8EiJbhU/XiEawbGQAA/U87A0bTzhiYTzixZhxbhiGs6s9kqknY2uQiRlaO04h/KwRqsbHWfGO0d4B3icauG0SEG7YPfBwy7/AKeC0mEXOdGMJEFxeP1PhEawkIkNq52QzGbgsIZNxENkIL10jt3CwG/laOAJQc83qY1OewLZ/gP4Tbi6mlaS7C/47mv1WPcQ5x1i2MwAGyJBBMZIL78Kvh/Fw2v0nGBaXtDcMGrXQcX8DIDKN10XlLdqM1j4GkYZAaxzC0QDWtc0whskDsWRAx296ppCyKJ3nvU4JStLdrxRKGzu2rG6c47e9ekLIDnOjqDLq6PpUXzSlDZKoqTdP60NALFAugd3Io6Pm4J3tUX4JW9uXFA+h5ePVEuj5uCL+7Pgi3ty4oDoDdzKfOdTQ5IvepuMkvpQVBuUBylu1GfV0+c96nBEDHbOpoRZKUNndtWN0DlulClO4SQKcfNekEhCHlqKxTlDy/OKJx81LQQBjHzUNAM0Xt4szklKB3a3jknUX8PDNAW9uXFK/uz4J393HJFvb/fyQK3ty4p3v4sxki/u/pFreHjmgJQyplxyXMO0tMOk6a94m1n/AE2ctp5lbl8Xdqf8fAdD/wAR/cHMTP8AC03sDRdUAnbtiiPbtjSNRkDJce7SxPzNINowXRfjTSZEa38LnGjYBfiREzFFW2nuIxRgt2NYwGFA4a7sp6zf5AWxYGiYmCxrWYusBMteO7rGbtV7RECJqDxXjg6O3EewFoJgIuq1jDFzgdoLnAMBsCrDtTEaASJIjW+2e2nBpaWlrrRBHIjatWwWnFdCMBtcTsa0bSeokwAmQvXtLS3YjyBOcAL8llEjBZqx75PeNdYSP+Jk27tZ3hailpGKAPy291rZOPiiZOERtedhsO6JR1sXH7ScW6jRqsFB9zVYZMZWtRecEFn2OXteMRji1zDrB0AQHTAECCDfgCrX/wDpODgHue673uJcaV2DL5ry0FzRq906ocJGRjUknxF0B/AorH4h7KgwYjB3YR2U/ooLfsvFYYfqBuHu/wBwXSPhbtdwAZiPL2eEu/U05kfqb/EMxEjiHZOmwgIrdeyO0TETndVHapx816QRKHltWKpvh/tIYjNR21oFZkX5V5Zq6nHzfKCilOPmoaQSlA2qKk5Jygd2t49QQYxF6WhmgVr+HIZov7s+Cd7eLjknb2/2gjb25cUX92fBO/u/pBp7eOaAtbw5HNA2m9TQjJFTfxcMkpQG7S8c0DlDy0FYonHzXpBE4+atoJSh5fnFAu7YoXp38kIFOPm+UFGUPLW8eoJyh5b1iicfNQUggJxG9S0EXt4uOSUoHdqaxyTtfw5jNAidnt4Zpa+33fPYkXbR/lkY05pgbL+HOs0Ere3+1HExA0OJMIfq4ZZqV/dlwWm/FXbwDdVpkZMu6Mi7hRtDMzGqUFD29pp0nSYCP5bJNH1VgwBjImgWB2RoDmgvcJmZvzWN8Q9qhrNUFVGofFenxcQFXdiYQDXPdsESTLZlmYwCx362PjQEwD9Stg7KwhEOh3MMxFnvFc2tpcqKt9EwPy2FzpPxIF1mgSawCwC1r4j7Q1WEAzMgr7T9MkSufdoY7sXElOcGgVNAqiOgAiOJUSZ+4g970gF3EBR0kFzg0D9I1eENoyhszIJqsp7NQCHhkDdxP6gaguErtw81n9i6I1us17YPLQ4R2w1nAjj+k8woqnw8KDYQU2M2NpVbM3BZCBASxOzGGBHyRFHoOOGudhYs2OP6qiNb9Fb12Cw4jH6M8gva3XwzLvsOxzSJEHL/AEtG7a0HUg4HhfqSyOx+1HjUEXAMJeNQQdIxLWEESJEXCcRGsYlYvaGinAxSNgirzs7SRAQKvfi/s5ukNGNhwIe1rwW7JtjRaNg4zsN+qaSQdS7B7Wdhua4HZNdN0HTWYjA5p7tRUH/S4d2VpQMIH+VunYPaLsNwc0ylERkVWeOjNcSfNS0OoolA2reOSx9E0lj2xae7tO8D/pZM4i9LQzUaFr+Hhmi/u/pF7eLI5It7c+KAt7f7+Sd/d/Sjf3ZcEW9ufFAUFvDxzTnE71bQyRe/iyGSUoDdpeOaAJEJ/ppeKNY63m+UP9qLnGMv1fLqf1QAIDdvWKBwbmhekXWCEEZx2d61IJSht7tTWNkShtlvVjZOuydBQi6A+tBQjNQcZS2VNjYKX0qag2CA2eydBQ5oEBsv4c+KYr7suCANvz8vBVHxR2wNF0c4ki8lrMJpMnPfJut5R+p3lDkGF8U9uNwmlsZCGvDadYRayN3CZqGkbNdpGo9laK/FecbEmT+kUaKACixuzsB+lPDyXOY0nULv1PcTF+I6FXOiYCQkBIAK97V0tmjMgYRgkR59q9otwWGdFyftrtV2M/Uw4mJp1Livft7tt+O4wdBkYF0/4aKnIc4Car9Bw4xayIEe86PeN534SGZmSrLs7RBAsae7/wCpiCp3Gn7/APZXT9JaxsJACQ4KtZiNY2AkANiqNO0p7zqtiSTAAbTyRD7a7Uj3WmRjEheeh6CWDWdEPMoDa0OEYCPjcP8AFsXHaF6aHoYZB5Ie+cCIOa0jaGDY9wq89xvmOyw7E7OdpekM0ZryzX1w54aXhjQC9xAiC6JADnEzLrSJVbouAzGeWuJDGtjFgk50WtgJSbAQGTRWKeP2eGnWY+MIw1SGnPyn5LYO2uzDoZGjv1gcOMHOBaH6ziYto4EmkYKg0uDpyjfYf5RFdi6RitMyeYhH7HlFe+i9uvaZryL3iUYixmF5v0drpgapym3+upIq4fpbcYxoGw5uJj/8R/JVRjs/LfsiNpEYfwRsOa8MMuw3bM5TBAqs/ExA8DNBsHw/8QHDaWv7+E4zOyDjvbjjf9J2yMSvftrsduKPzMMgrUtGx3YL4jYZEGYINCNhW09nMi3X0Z4iduA93dNTqPP6TGmzigwuz8YsOq4asL/ZbfoGniUDNU+M7CedTEBwX7r+7zDjJwzB5LFxuzcbD72G6I2gX4Ko6T2dpzmkEGa2vQu1A4QcCI7SOpLgrPivFwjqva5vJXXZ/wAdAkAuRMsdvw8VrjIgkbBlQkUU7+7Lgud9nfEjcQCMTCYLS4Obm1wmPvWIV52N8WYb8b/jPxWufAaji1zHOJMNVwLQ3XEptMHRPdbsUWVtFvbnxTv7suCV/n5eHVEdDzcUUz8qG/FRcTzhMU5H+P5UvrUWzCQaOVDfJAoCEIyjI1jb6qQjHZ3rUhdA4Tq2gzSlDbLerGyBd25QpT3R8k0C5T3acUuct6oy6unz9X2Ry9N8+rIFynu0OfVkdE7uQT5+q2XV0cuW9mgOh5syuafiXjNxcfDwCHluEBiODASQ58WhsqaoIP7tohPpfUd3Jc1/ETRCMb8xh7xa2JBnKQiOUeaDE0f4rwtHYYYGMXAQaAyAgLRWg/EXxK7HcYs1RHxun/iNv8kZLG7UxtIcS381wbaJH0VM3s90doQeZxi47TaOyVgBsGQVzoXdbYKvYxjJzefkOaz8F7iIkBvERPJp+pHJB7viYRMAdkoud+1m08ZC5CYaGgiEAZERiTk9w/V+xsr6yiHHwtc5ziGxEXOe6jY7XGwHJdK+G/wycMR7tNLHYepBjcN7wdYlp1i4BurAAjVmDrG0w1T4b+GsbTMVrCzEw8B7XOdj6h1S0NOpB5Gq4a4aNQH6RHZ/hvsRmhaOzAa4v1NYxdCLi9xc4wEgImQyCztD0VmExuGxga1rQ1rBsgNhnt4ma9+fqtl1dBi6foGFjsLMZjMRk467Q6EZSjsOYXLPiD8IHFxdomO1oJJbh4utAAmJhiDWJ5jmuu8uW9mjqO7kg+ae1fgXtLR4l2jPeAYa2FDEBzgyLgMyAtbc9zXEOBa4GBBBBBqCKL666/d191g9pdkaPjjVx8HDxR52tdq5gkRHKCD5d0fF1pEwtkbxv/am/D1ZwgPE3djIOHlJ/gyqI9j7d/CPRntLtFc7AfPVDnF+G42Id3haMTwK5v2r2U/R3uwcdmriMsY90xAc10O8wgfUHYgpsRkReyWjYj2GIJUm6I9pixwcLGXyUhreJjhmBEfygvdG7YcW6r4PbuvAcP4KyWYmCRIPwzHbhvc32zHKCo9GZrbIc3Nb9SswaBiESA/zw/8A7KoytK0Zjh/5nEr+qBMOMlrel4jGOAZiPeRtMZRvtWdpXZr4TLBl+Zh/TWVRpWglm2J4An5wh81Fb98N4mBiMjjYuI5u7rmH+IXr2qcNve0Z78J7Ztcx7hMXbGC0rsJjInXe5gNmg/Vw+6tP+MzXa3Dc5wBOtrvJiISIDWtgY5lEx3H4D7bfpmh4eLiADEGsx8NjnMMI8xA+pbD0fLwXMfwx7UczEOiuMWO1ntiJtIHh1ZNEB4u8V0/qO9khC6B3sipcp2tml1DdzS5+q+XVkUc5b1Tl1ZPlPdpxRy9Ns+ro5+r7ICW+UJ+lCBcvT90c/VbLq6Oc96nBLl6anPqyB8vTfPqyXPnu5J8/VbLq6Oob2aA6hvZrQ/xG7JGqNIbrAnVY+Bi0QMWRaYgVaTCfdFlvnX7ciovYHAtcAQRBwIBDhWR2j/aD550rTGiWo08GYcf5dhn5QVNpOLrbIwsTL+JD5Lu2n/h9oGK7W/LcwnaMPEc0Di2JAHABemhfAPZ+H/7dryDGOK52IHZaryW/JBwbQNEfiu1cFjnul3cNhe4RvAd0fJdD+H/wxxXPw36S5rWEFz8IF35oJBAaXNkJwOsDlCa6xgYDWNDWMaxtGtaGhucAF68/VfLqyCr7A7BwNCYcPABa1ztZznOLi50AJk5ACGXFWnL0/dHL0/dPn6vsgXP1Wy6ujl6b59WRy9N8+rI5+q2XV0Bz57uSOob2aXLlvZp9R3ckB1+3r7Jdfu6+6fX7uHVUdft6+yA6hu5qj+JvhrB07DDcWIe2bMVsA8G0/wBTTVp2woYEXnUd7JLly3c0HDe1fgDTcBw1Wfnt1XEvwf1CGwHDJ1okWiqDGwcTDMMRj8M7CHscwgwjAnZGE8xNfSXP1Xy6soYmG1wg5oc0+EiPMgoPmxmlNMIOBjGHeE4bdoTc9hEY1hLV27IRuvojH7K0d5Bfg4LiNjnYeG6FYAkS2KvxPhHQTt0LAgDHVGG0RN4ATQfPukObsGtGveaOHhVecB7zBjHuNhrPP8NX01ovw5omGSWaNgNJnrDCZEUhEjqKs2sDRJoA3QIRzkg+bexfhLT3u7mi4k64mGGD/J4AW76B+GumvI/Ox8Njahjnvh6QGtH8rrnUd3Ip9HzcOqoNZ+Hvg7B0VweHPe8bC6ABiIHVaPuTtWy9ftzT6/bx6ol1+7JA+o72SXL02z6un1DdzRz9V8urIDn6r5dWRy9P3Ry9Ns+ro5+qnBA/UhL0IQHKW7XilznvUGXV04GO2d6QslKGyVRUm6A5Sq2pzT6B3cil9aGgFin9Ki5yQLo+bgn0PLx6oi3ty4pR/wD15uHzQPo+bgl0Bu5lFvblxTvepvwQHOdTfJLlLdqM+ro+lBUG5TrtnU0IsgOc96nBHKW7XilKGyW7WN04GO2d6QsgOc96gyS5Sq2pz6siUNkrVJun9aGgFkB9aG2RS6I3swgkcqi5yTt8jbigXQ8vFPo+bh1VK/uz4It7cuKA6A3cyn9am+QRf3Z8EvpQWNygOUqNqM+rp8571Dkj61NCLJShs7tqg3QPlLdrxRznvU4IgY7Z3pCyUobJbtY3QHKW7U59WT+tDbIpDjOhoBbq6PpUVJuEB0RvZhPoeXij60NuKV/dnwQPo+bh1VLoeXii3ty4p3+efBAuid7IJ8pUFs0fSgtxR9amhFkBznvUOXVkcpbteKUobJUFQbojOEe9ekEDnvBNRlYoQOUPLasUTj5qGkEIQEoHdqKxRCYv4chmhCCLjt92d4KIH6Sa/oy48oJoQTv7s+CVreHI5poQIbTveK0Mk5QG7QVj1FCEBOPmvSCURCPhtWKEIGYxh4qGkEiQAT4a3j1BCEEQCTA7YSt1BSbCBhs8WZySQglb25cUX92fBNCCNreHI5p1N/FwyQhASgN2grFE4+appBCEClDy2rFRMS6Ee9Q0hWV0IQDQJ2rePUFI7RveG0M0IQF7eLM5J29uXFNCBX92fD5pW9uXFNCAvfxZjJKUBu0FY5poQRdGMI96EScsvkohogCf02rFCEHtqvuEIQg//9k=',
    price: 20,
    category: 'Shoes',
    size: ProductSize.L,
    isAddedToCart: true,
  ),
  ProductItemModel(
    id: '9nbUTDpkmmMlPvGz0Emo',
    name: 'Chocolate Brown Trouser',
    imgUrl: 'https://encrypted-tbn0.gstatic.com/images q=tbn:ANd9GcTDd9vyaLMsXO4wj3D-XoZm8tKVYl-l0d9OnUkTtB1ONmjnaWgLC5REds32tkALXDCG348&usqp=CAU',
    price: 30,
    category: 'Clothes',
  ),
  ProductItemModel(
    id: 'ZCrNPkkjUK6JQy3yB4Ro', 
    name: 'Fila Black Boots', 
    imgUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLf-xfKmGdFhA8C6U81-0Ob962vJtk4R6lKw&usqp=CAU', 
    price: 10, 
    category: 'Shoes',
    size: ProductSize.L,
  ),
  ProductItemModel(
    id: 'TVhNPt73rNNjlE4KW2hh',
    name: 'MARK & KEITH Women Handbag', 
    imgUrl: 'https://m.media-amazon.com/images/I/41iUbL7vzbL.jpg', 
    price: 10, 
    category: 'Bags',
    size: ProductSize.XL,
    isAddedToCart: true,
  ),
  ProductItemModel(
    id: 'GzCeR59znxCBIZWeqCpO', 
    name: 'REAL BLUE PRO', 
    imgUrl: 'data:image/jpeg;base64,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', 
    price: 10, 
    category: 'Electronics',
    size: ProductSize.S,
  ),
  ProductItemModel(
    id: 'ATXMxAbFkz0Ff6kFF5uH', 
    name: 'Classic Hat', 
    imgUrl: 'data:image/jpeg;base64,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', 
    price: 10, 
    category: 'Hats',
    size: ProductSize.S,
  ),
  ProductItemModel(
    id: 'Jfhvp1oDlZVrHdFjVWfN',
    name: 'Apple iPhone 11', 
    imgUrl: 'https://kontorsenteret.no/wp-content/uploads/2019/09/1138900.jpg', 
    price: 10, 
    category: 'Electronics',
    size: ProductSize.XL,
  ),
  ProductItemModel(
    id: 'ZmVljVK4oyX6fRE7wNl6',
    name: 'Sweet Shirt', 
    imgUrl: 'https://img.kwcdn.com/product/Fancyalgo/VirtualModelMatting/eb145502841a3a2eb7d0e624c8670d2a.jpg', 
    price: 15, 
    category: 'Clothes',
    size: ProductSize.S,
  ),
  ProductItemModel(
    id: 'D5nOXTP8AlDQDqwedHi8', 
    name: 'Bags', 
    imgUrl: 'https://cuyana.com/cdn/shop/products/PDP_White_Hero_900x900_FA21_SystemTote13_Caramel_Hero_2977.jpg?v=1687316838', 
    price: 15, 
    category: 'Bags',
    size: ProductSize.M,
    isFavorite: true,
  ),
];