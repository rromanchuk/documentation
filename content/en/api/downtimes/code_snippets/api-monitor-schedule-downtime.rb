require 'dogapi'

api_key = '<YOUR_API_KEY>'
app_key = '<YOUR_APP_KEY>'

dog = Dogapi::Client.new(api_key, app_key)

# Repeat for 3 hours (starting now) on every week day for 4 weeks.
start_ts = Time.now.to_i
end_ts = start_ts + (3 * 60 * 60)
end_reccurrence_ts = start_ts + (4 * 7 * 24 * 60 * 60) # 4 weeks from now

recurrence = {
  'type' => 'weeks',
  'period' => 1,
  'week_days' => %w[Mon Tue Wed Thu Fri],
  'until_date' => end_reccurrence_ts
}

# Schedule downtime
dog.schedule_downtime(
  'env:testing',
  start: start_ts,
  end: end_ts,
  recurrence: recurrence
)
