class UsersThatShouldGetTeamUpdateNowQuery
  def initialize(relation = User.all)
    @relation = relation
  end

  def find_each(&block)
    wday = Date.today.wday
    @relation
    	.where(%Q{(sent_team_update_at IS NULL OR EXTRACT(DOW FROM TIMEZONE(timezone, sent_team_update_at)) != #{wday})
    		 AND EXTRACT(HOUR FROM TIMEZONE(timezone, NOW() + interval '8 hours')) >= reminder_at_h
         AND EXTRACT(MINUTE FROM TIMEZONE(timezone, NOW() + interval '8 hours')) >= reminder_at_m})
    	.find_each do |user|
        time_range = (user.sent_team_update_at.nil? ? Time.now.midnight - 1.day : user.sent_team_update_at)..Time.now.midnight
        if user.team.notes.where(:created_at => time_range).count > 0
          block.call(user)
        end
      end
  end
end