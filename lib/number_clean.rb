require 'csv'
puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

def clean_numbers(homephone)
    if homephone.nil? || homephone.length != 10
        homephone = nil
    elsif homephone.length = 11 && homephone[0] == '1'
        homephone = homephone.to_s.chr[1..-1]
    elsif homephone.length != 11 && homephone.length > 10
        homephone = nil
    end
    return homephone
end

contents.each do |row|
    name = row[:first_name]
    homephone = clean_numbers(row[:homephone])
    puts "#{name} #{homephone}"
end