require 'csv'

    # Data cleanup necessary using 'if' + 'elsif' conditionals.
    # If the zipcode contains exactly five digits, then it is okay to continue.
    # If the zipcode contains more than 5 digits, it can be trimmed to the first five digits.
    # If the zipcode contains less than 5 digits, add zeros to the beginning until it is 5 digits.

def clean_zipcode(zipcode)
    zipcode.to_s.rjust(5, '0')[0..4]
end

puts 'Event Manager Initialized!'

contents = CSV.open('event_attendees.csv', 
headers: true,
header_converters: :symbol
)

contents.each do |row|
    name = row[:first_name]
    zipcode = clean_zipcode(row[:zipcode])
    puts "#{name} #{zipcode}"
end

