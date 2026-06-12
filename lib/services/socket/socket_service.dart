import 'package:socket_io_client/socket_io_client.dart' as io;
import '../../config/api/api_end_point.dart';
import '../../utils/log/app_log.dart';
import '../storage/storage_services.dart';

class SocketService {
  SocketService._();

  static io.Socket? _socket;
  
  static final Map<String, List<void Function(dynamic)>> _handlers = {};

  static bool get isConnected => _socket?.connected ?? false;


  static void connect() {
    final token = LocalStorage.token;
    if (token.isEmpty) {
      appLog('⚠️ Socket: Token empty, skipping connection.');
      return;
    }



    if (_socket != null && _socket!.connected) return;

    if (_socket == null) {
      appLog('🔌 Socket: Initializing new connection to ${ApiEndPoint.socketUrl}');
      _socket = io.io(
        ApiEndPoint.socketUrl,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .setAuth({'token': token})
            .enableAutoConnect()
            .enableReconnection()
            .setReconnectionAttempts(10)
            .setReconnectionDelay(2000)
            .build(),
      );

      _socket!.onConnect((_) {
        appLog('✅ Socket: Connected');
        
        final currentToken = LocalStorage.token;
        if (currentToken.isNotEmpty) {
          _socket!.emit('authenticate', currentToken);
          appLog('🔑 Socket: Authenticated with token');
        }

        _reRegisterListeners();
      });
      _socket!.onDisconnect((_) => appLog('⚠️ Socket: Disconnected'));
      _socket!.onConnectError((e) => appLog('❌ Socket: Connect Error $e'));
    } else {
      appLog('🔌 Socket: Attempting to reconnect existing instance...');
      _socket!.connect();
    }



  }

  static void _reRegisterListeners() {
    if (_socket == null) return;
    _handlers.forEach((event, handlers) {
      _socket!.off(event);
      _socket!.on(event, (data) {
        appLog('📩 Socket: Event triggered [$event]');
        final currentHandlers = List<void Function(dynamic)>.from(_handlers[event]!);
        for (var h in currentHandlers) {
          h(data);
        }
      });
    });
  }

  static void on(String event, void Function(dynamic data) handler) {
    if (!_handlers.containsKey(event)) {

      _handlers[event] = [];
      
      if (_socket == null) connect();
      
      _socket?.on(event, (data) {
        appLog('📩 Socket: Received data for [$event]');
        final currentHandlers = List<void Function(dynamic)>.from(_handlers[event]!);
        for (var h in currentHandlers) {
          h(data);
        }
      });
    }

    if (!_handlers[event]!.contains(handler)) {
      _handlers[event]!.add(handler);
    }
    appLog('👂 Socket: Registered listener for [$event]');
  }

  static void emit(String event, dynamic data) {
    if (_socket == null) connect();
    _socket?.emit(event, data);
  }

  static void disconnect() {
    _socket?.dispose();
    _socket = null;
    _handlers.clear();
    appLog('🔌 Socket: Manually disconnected and cleared');
  }

}
