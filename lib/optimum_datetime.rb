require 'csv'

registration_counts = Hash.new(0)   # Here we initialize a hash to store the counts for each hour.

def clean_datetime

end

CSV.foreach(
    'event_attendees.csv',
    headers: true,
    header_converters: :symbol
) do |row|          # Iterate through each row of the data.

    reg_time = row[:regdate].to_s.split[1]  # Extract the time part from RegDate.
    
    if  reg_time =~ /^\d{2}:\d{2}$/         # Check if the reg_time matches the desired format.                              
        reg_hour, reg_minute = reg_time.split(':').map(&:to_i)  # For each row we extract the hour and minute.
        registration_counts[reg_hour] += 1             # We increment the count for each hour of the registration.
    end
    
end

max_reg_count = registration_counts.values.max  # Here we inspect the values within registration_counts and find the max. This is attributed to max_reg_count.

peak_hours = registration_counts.select { |hour, count| count == max_reg_count}.keys    
# Finally we inspect the key-value pairs in registration counts and find the value that matchs the max. 
# Once the max is identified, we attribute the key of that value to 'peak_hours'. This is our peak hour for advertising.

if peak_hours.empty?
    puts "No peak registration hours found"
  else
    puts "Peak registration hour(s): #{peak_hours.join(', ')} (#{max_reg_count} registrations)"
  end

  puts registration_counts