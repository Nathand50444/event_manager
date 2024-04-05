require 'csv'
require 'date'

registration_counts_by_day = Hash.new(0)

CSV.foreach(
    'event_attendees.csv',
    headers: true,
    header_converters: :symbol
) do |row| 
    
    reg_date = row[:regdate].to_s.strip     # Extracts the registration date, to string and remove any whitespace.

    begin
        parsed_date = Date.strptime(reg_date, '%m/%d/%y')   # Parse the date with the specified format.
        day_of_week = parsed_date.wday     # Parsing the date string to get the day of the week as an integer.
        registration_counts_by_day[day_of_week] += 1    # Increment the count for the day of the week.
    rescue ArgumentError
        reg_date = nil
    end
    
end

max_reg_count = registration_counts_by_day.values.max   # The max value is attributed to max_reg_count.
peak_days = registration_counts_by_day.select { |day, count| count == max_reg_count }.keys

if peak_days.empty?
    puts "No peak registration days found"
else
    peak_day_names = peak_days.map { |day| Date::DAYNAMES[day] }    # Convert day indices to day names.
    puts "Peak registration day(s): #{peak_day_names.join(', ')} (#{max_reg_count} registrations)"      # The peak days are outputted here.
end