import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../features/sensors/presentation/providers/notifications_provider.dart';
import '../features/sensors/presentation/providers/sensors_provider.dart';
import 'router/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: AppRouter.router.routeInformationParser,
      routeInformationProvider: AppRouter.router.routeInformationProvider,
      routerDelegate: AppRouter.router.routerDelegate,
      builder: (context, child) {
        if (child == null) {
          return Center(child: CircularProgressIndicator());
        } else {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<SensorsProvider>(create: (_) => GetIt.I<SensorsProvider>()),
              ChangeNotifierProvider<NotificationsProvider>(create: (_) => GetIt.I<NotificationsProvider>())
            ],
            child: Stack(
              children: [
                child,
                NotificationsOverlay()
              ],
            ),
          );
        }
      }
    );
  }
}

class NotificationsOverlay extends StatelessWidget {
  const NotificationsOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final notifs = context.watch<NotificationsProvider>().notifications;
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Column(
          verticalDirection: VerticalDirection.up,
          mainAxisSize: MainAxisSize.min,
          children: notifs.map((n) {
            final date = n.timestamp.toLocal();
            final formatted = DateFormat('dd.MM.yyyy HH:mm:ss', 'ru').format(date);

            return Dismissible(
              key: ValueKey(n.id),
              direction: DismissDirection.endToStart,
              onDismissed: (_) {
                context.read<NotificationsProvider>().removeNotification(n);
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  title: Text(
                    'Датчик ${n.sensorId} ⇒ Состояние: ${n.state}',
                  ),
                  subtitle: Text(formatted),
                ),
              ),
            );

            // return Card(
            //   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            //   child: ListTile(
            //     title: Text('Датчик ${n.sensorId} => Состояние: ${n.state}, $formatted'),
            //     subtitle: Text('${n.timestamp.toLocal()}'),
            //   ),
            // );
          }).toList(),
        ),
      ),
    );
  }
}

// class NotificationListener extends StatefulWidget {
//   final Widget child;
//   const NotificationListener({super.key, required this.child});

//   @override
//   State<NotificationListener> createState() => _NotificationListenerState();
// }

// class _NotificationListenerState extends State<NotificationListener> {
//   late NotificationsProvider _notifsProv;
//   List<NotificationEntity> _oldNotifs = [];

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _notifsProv = context.read<NotificationsProvider>();
//     _notifsProv.addListener(_onNewNotifs);
//   }

//   void _onNewNotifs() {
//     final newList = _notifsProv.notifications;
//     final fresh = newList.where((n) => !_oldNotifs.contains(n)).toList();

//     for (var i = 0; i < fresh.length; i++) {
//       final n = fresh[i];
//       final index = _oldNotifs.length + i;

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           behavior: SnackBarBehavior.floating,
//           margin: EdgeInsets.fromLTRB(16, 0, 16, 16 + index * 72.0),
//           duration: const Duration(seconds: 20),
//           content: Text(
//             'Sensor ${n.sensorId}: ${n.state} at ${n.timestamp.toLocal()}',
//           ),
//         ),
//       );
//     }

//     _oldNotifs = List.from(newList);
//   }

//   @override
//   void dispose() {
//     _notifsProv.removeListener(_onNewNotifs);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) => widget.child;
// }