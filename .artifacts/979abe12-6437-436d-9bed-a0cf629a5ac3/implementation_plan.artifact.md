# Implementation Plan - Socket Chat Integration

Connect the Chat screen to the backend WebSocket using the `/chat` namespace and `new-group-message` event.

## User Review Required

> [!IMPORTANT]
> The socket URL will be updated to include the `/chat` namespace as shown in your debugger screenshot. The `main.dart` will now initiate the socket connection on app startup.

## Proposed Changes

### Configuration

#### [MODIFY] [api_end_point.dart](file:///C:/Users/mdyou/StudioProjects/sudo/lib/config/api/api_end_point.dart)
- Update `socketUrl` to `http://10.10.26.182:5002/chat` (if it's a namespace).

### Infrastructure

#### [MODIFY] [socket_service.dart](file:///C:/Users/mdyou/StudioProjects/sudo/lib/services/socket/socket_service.dart)
- Ensure it uses the updated `socketUrl`.
- Simplify connection logic if needed.

#### [MODIFY] [main.dart](file:///C:/Users/mdyou/StudioProjects/sudo/lib/main.dart)
- Call `SocketService.connect()` after `LocalStorage.init()`.

### Chat Feature

#### [MODIFY] [chat_controller.dart](file:///C:/Users/mdyou/StudioProjects/sudo/lib/groups/controller/chat_controller.dart)
- Update `_setupSocket()` to:
    - Emit `join` (or the groupId directly as shown in the screenshot) to join the specific group room.
    - Listen for the `new-group-message` event instead of `new-message-$groupId`.
    - Correctly handle the incoming data based on the provided JSON structure.

## Verification Plan

### Manual Verification
1. Open the app.
2. Verify "Socket: Connected" appears in logs.
3. Open a Group Chat.
4. Send a message from another client/debugger.
5. Verify the message appears in real-time on the screen.
6. Verify sending a message from the app also works.
