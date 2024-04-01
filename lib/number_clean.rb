require 'csv'
puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

def clean_numbers(homephone)    # Convert homephone to string if it's not already
    homephone = homephone.to_s.gsub(/\D/, '')  # non-digit characters are removed prior to cleaning.
    case homephone.length
    when 10
        return homephone  # Good number
    when 11
        return homephone[1..-1] if homephone[0] == '1'  # Trim the leading '1'
    end
    return nil  # Bad number for other cases.
end

contents.each do |row|
    name = row[:first_name]
    homephone = clean_numbers(row[:homephone])
    puts "#{name} #{homephone}"
end