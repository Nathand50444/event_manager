require 'csv'

registration_counts = Hash.new(0)   # Here we initialize a hash to store the counts for each hour.

CSV.foreach(
    'event_attendees.csv',
    headers: true,
    header_converters: :symbol
) do |row| 
    reg_datetime = DateTime.parse(row[:RegDate])    # For each row of the CSV data, we extract the registration date and time.
    registration_counts[reg_datetime.hour += 1]     # We increment the count for each hour of the registration.
end

max_reg_count = registration_counts.values.max  # Here we inspect the values within registration_counts and find the max. This is attributed to max_reg_count.

peak_hours = registration_counts.select { |hour, count| count == max_reg_count}.keys    
# Finally we inspect the key-value pairs in registration counts and find the value that matchs the max. 
# Once the max is identified, we attribute the key of that value to 'peak_hours'. This is our peak hour for advertising.

puts peak_hours