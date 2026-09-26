import 'package:activity/core/models.dart';

const List<String> kCategories = [
  'ທັງໝົດ',
  'ສຳມະນາ',
  'ທ່ອງທ່ຽວ',
  'ກິດຈະກຳ',
  'ຈອງປີ້',
  'ຄອສອອນລາຍ',
];

const List<EventItem> kEvents = [
  EventItem(
    id: 1,
    title: 'Thriving beyond the storm',
    category: 'ສຳມະນາ',
    date: '28/8/2026',
    time: '8:00 - 12:00',
    image:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUC1WcJ5NovCtPqqyATD7EVJSwh8mBAR-SXJ-JhESEj4f7P2NIkPK9VkxQ&s=10',
    address: 'Bangkok Thailand',
    price: 500000,
    detail:
        'ສຳມະນາພັດທະນາຕົນເອງ ແລະ ທຸລະກິດ ຮຽນຮູ້ວິທີຜ່ານຜ່າວິກິດ ແລະ ເຕີບໂຕຢ່າງຍືນຍົງ ຈາກວິທະຍາກອນມືອາຊີບ.',
  ),
  EventItem(
    id: 2,
    title: 'Explore Laos',
    category: 'ທ່ອງທ່ຽວ',
    date: '31/10/2026',
    time: '15:00 - 23:30',
    image:
        'https://ak-d.tripcdn.com/images/1mi33224x9aaoeyor9D26.jpg?proc=resize%2Fm_z%2Cw_375%2Ch_0%3Bformat%2Ff_webp%2C9C2E',
    address: 'Laos PDR',
    price: 500000,
    detail:
        'ທ່ອງທ່ຽວສຳຫຼວດທຳມະຊາດ ແລະ ວັດທະນະທຳລາວ ພ້ອມອາຫານພື້ນເມືອງ ແລະ ຄູ່ມືນຳທ່ຽວຕະຫຼອດເສັ້ນທາງ.',
  ),
  EventItem(
    id: 3,
    title: 'Biggest Music',
    category: 'ກິດຈະກຳ',
    date: '28/8/2026',
    time: '8:00 - 12:00',
    image:
        'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/music-concert-flyer-design-template-2d59fde071fcf31f0d8a138b3a6e516d_screen.jpg?ts=1737708040',
    address: 'Bangkok Thailand',
    price: 500000,
    detail:
        'ຄອນເສີດດົນຕີທີ່ໃຫຍ່ທີ່ສຸດຂອງປີ ລວມສິລະປິນຊື່ດັງຫຼາຍກວ່າ 20 ວົງ ພ້ອມແສງສີສຽງເຕັມຮູບແບບ.',
  ),
  EventItem(
    id: 4,
    title: 'Run the canyon just outside',
    category: 'ຈອງປີ້',
    date: '28/8/2026',
    time: '8:00 - 12:00',
    image:
        'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/music-concert-flyer-design-template-2d59fde071fcf31f0d8a138b3a6e516d_screen.jpg?ts=1737708040',
    address: 'Bangkok Thailand',
    price: 350000,
    detail:
        'ງານວິ່ງເທຣວຜ່ານຫຸບເຂົາ ລະຍະທາງ 10 ແລະ 21 ກິໂລແມັດ ຮັບເສື້ອ ແລະ ຫຼຽນທີ່ລະນຶກທຸກຄົນ.',
  ),
];
