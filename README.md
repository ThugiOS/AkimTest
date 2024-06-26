<img src="https://img.shields.io/badge/Swift-UIKit-success">


---

### Стэк
- UIKit
- SnapKit
- Alamofire
- Amplitude SDK
- PhotosUI
- SDWebImage

### ТЗ
1. Адаптивня pixel perfect верстка 2-ух paywall экранов.
2. Получение данных из API в коллекцию.
3. Создание, отображение, сохранение Live Photo.
4. Интеграция Amplitude SDK.

---

1) Верстка: Созданы два адаптивных pixel perfect экрана - пейвола, которые будут поочередно отображаться при каждом запуске приложения. Кнопки интерактивны.
   Дополнительно реализована анимированная с градиентом кнопка на UIKit, анимация нажатия.
<p align="center">
      <img src="https://github.com/ThugiOS/AkimTest/blob/main/media/1pay.gif" width="320"> <img src="https://github.com/ThugiOS/AkimTest/blob/main/media/2pay.gif" width="320">
</p>

2) Список данных: Реализован UICollectionView, в котором отображены данные из API. Список обновляться при каждом открытии экрана. Добавлен UIRefreshControl. Фото кэшируется SDWebImage
 <img src="https://github.com/ThugiOS/AkimTest/blob/main/media/api.png" width="480">
 
3) Live Photo: При нажатии на элемент из списка мы переходим на Detail экран. Из полученных image/video создается Live Photo и отображается на экране. запускается анимация при нажатии кнопки Preview или Haptic Touch. Также можно сохранить Live Photo в галерею.
<p align="center">
      <img src="https://github.com/ThugiOS/AkimTest/blob/main/media/livephoto.gif" width="320"> <img src="https://github.com/ThugiOS/AkimTest/blob/main/media/gall.gif" width="320">
</p>

4) Amplitude SDK: Интегрирована аналитика. Отслеживается загрузка Detail экрана, воспроизведение Live Photo, сохранение Live Photo.
 <img src="https://github.com/ThugiOS/AkimTest/blob/main/media/amplitude.png" width="480">



#### Contact with me
[LinkedIn](https://www.linkedin.com/in/artem-swift/) | [Email](mailto:artem.ios.nikitin@gmail.com "artem.ios.nikitin@gmail.com")
