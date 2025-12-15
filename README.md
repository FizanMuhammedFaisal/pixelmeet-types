# @pixelmeet/types

Shared types and constants for PixelMeet backend services.

## Installation

```bash
pnpm add @pixelmeet/types
```

## Usage

```typescript
import { HTTP_STATUS, SUCCESS_MESSAGES } from '@pixelmeet/types'

res.status(HTTP_STATUS.OK).json({
  message: SUCCESS_MESSAGES.SUCCESS,
  data: result
})
```

## Constants

### HTTP_STATUS

| Name | Value |
|------|-------|
| OK | 200 |
| CREATED | 201 |
| NO_CONTENT | 204 |
| BAD_REQUEST | 400 |
| UNAUTHORIZED | 401 |
| FORBIDDEN | 403 |
| NOT_FOUND | 404 |
| CONFLICT | 409 |
| INTERNAL_SERVER_ERROR | 500 |

### SUCCESS_MESSAGES

| Name | Value |
|------|-------|
| SUCCESS | "Operation successful" |
| CREATED | "Resource created successfully" |
| UPDATED | "Resource updated successfully" |
| DELETED | "Resource deleted successfully" |

## Notification Types

```typescript
import type { NotificationMessage, OTPVerificationEmail } from '@pixelmeet/types'

const notification: OTPVerificationEmail = {
  type: 'OTPSend',
  payload: {
    to: 'user@example.com',
    template: 'OTPSend',
    from: 'noreply@pixelmeet.com',
    fromName: 'PixelMeet',
    otp: '123456'
  }
}
```
