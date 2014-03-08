class UsersThatShouldGetReminderNowQuery
  def initialize(relation = User.scoped)
    @relation = relation
  end

  def find_each(&block)
  	wday = Date.today.wday
    @relation
    	.where(%Q{#{wday} = ANY(remind_on)
    		 AND (sent_reminder_at IS NULL OR EXTRACT(DOW FROM TIMEZONE(timezone, sent_reminder_at)) != #{wday})
    		 AND EXTRACT(HOUR FROM TIMEZONE(timezone, NOW())) >= reminder_at_h AND EXTRACT(MINUTE FROM TIMEZONE(timezone, NOW())) >= reminder_at_m})
    	.find_each(&block)
  end
end