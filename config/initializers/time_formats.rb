Time::DATE_FORMATS[:year_month_day] = '%Y-%m-%d'
Time::DATE_FORMATS[:short_ordinal] = lambda { |time| time.strftime("%B #{time.day.ordinalize}") }