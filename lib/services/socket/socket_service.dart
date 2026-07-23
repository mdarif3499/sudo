import 'package:socket_io_client/socket_io_client.dart' as io;
import '../../config/api/api_end_point.dart';
import '../../utils/log/app_log.dart';
import '../storage/storage_services.dart';

class SocketService {
  SocketService._();

  static io.Socket? _socket;

  static final Map<String, List<void Function(dynamic)>> _handlers = {};

  static bool get isConnected => _socket?.connected ?? false;

  static void connect({String? url, bool forceNew = false}) {
    final token = LocalStorage.token;
    if (token.isEmpty) {
      appLog('⚠️ Socket: Token empty, skipping connection.');
      return;
    }

    final targetUrl = url ?? ApiEndPoint.chatUrl;

    if (_socket != null && _socket!.connected && !forceNew) {
      appLog('🔌 Socket: Already connected to ${_socket?.io.uri}');
      return;
    }

    if (_socket != null && forceNew) {
      appLog('🔌 Socket: Forcefully disconnecting existing instance for new connection...');
      _socket!.dispose();
      _socket = null;
    }

    if (_socket == null) {
      appLog('🔌 Socket: Initializing connection to $targetUrl');
      _socket = io.io(
        targetUrl,
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
        appLog('✅ Socket: Connected to $targetUrl');
        _reRegisterListeners();
      });

      _socket!.onDisconnect((_) => appLog('⚠️ Socket: Disconnected from $targetUrl'));
      _socket!.onConnectError((e) => appLog('❌ Socket: Connect Error $e'));
      _socket!.onError((e) => appLog('❌ Socket: Error $e'));
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
        final currentHandlers = List<void Function(dynamic)>.from(handlers);
        for (var h in currentHandlers) {
          h(data);
        }
      });
    });
  }

  static void on(String event, void Function(dynamic data) handler) {
    if (!_handlers.containsKey(event)) {
      _handlers[event] = [];
    }

    if (!_handlers[event]!.contains(handler)) {
      _handlers[event]!.add(handler);
    }

    if (_socket == null) {
      connect();
    }

    if (_socket != null) {
      _socket!.off(event); 
      _socket!.on(event, (data) {
        appLog('📩 Socket: Received data for [$event]');
        final currentHandlers = List<void Function(dynamic)>.from(_handlers[event]!);
        for (var h in currentHandlers) {
          h(data);
        }
      });
      appLog('👂 Socket: Listen started for [$event]');
    }
  }

  static void emit(String event, dynamic data) {
    if (_socket == null) {
      connect();
    }
    
    _socket?.emit(event, data);
    appLog('📤 Socket: Emitted event [$event] with data: $data');
  }

  static void off(String event, void Function(dynamic data) handler) {
    if (_handlers.containsKey(event)) {
      _handlers[event]!.remove(handler);
      if (_handlers[event]!.isEmpty) {
        _handlers.remove(event);
        _socket?.off(event);
      }
    }
  }

  static void disconnect() {
    _socket?.dispose();
    _socket = null;
    _handlers.clear();
    appLog('🔌 Socket: Manually disconnected and cleared');
  }
}
