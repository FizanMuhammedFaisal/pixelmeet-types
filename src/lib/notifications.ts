export interface BaseNotification {
	type: string
	timestamp?: number
}

export interface OTPVerificationEmail extends BaseNotification {
	type: 'OTPSend'
	payload: {
		to: string
		template: 'OTPSend'
		from: string
		fromName: string
		otp: string
	}
}

export interface WelcomeEmail extends BaseNotification {
	type: 'WelcomeMail'
	payload: {
		to: string
		template: 'WelcomeMail'
		from: string
		fromName: string
	}
}

export interface ResetPasswordEmail extends BaseNotification {
	type: 'ResetPassword'
	payload: {
		to: string
		template: 'ResetPassword'
		from: string
		fromName: string
		otp: string
	}
}

export type NotificationMessage = OTPVerificationEmail | WelcomeEmail | ResetPasswordEmail
