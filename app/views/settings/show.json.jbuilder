json.extract! @current_user, :timezone, :remind_on
json.reminder_at calculate_reminder_at(@current_user)