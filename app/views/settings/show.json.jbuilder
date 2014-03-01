json.extract! @current_user, :timezone, :remind_on, :members
json.reminder_at calculate_reminder_at(@current_user)