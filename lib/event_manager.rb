require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_zipcode(zipcode)
    zipcode.to_s.rjust(5, '0')[0..4]
end

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

def legislators_by_zipcode(zip)
    civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
    civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

    begin
        legislators = civic_info.representative_info_by_address(
            address: zip,
            levels: 'country',
            roles: ['legislatorUpperBody', 'legislatorLowerBody']
        ).officials
    rescue
        'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
    end
end

def save_thank_you_letter(id,form_letter)
    Dir.mkdir('output') unless Dir.exist?('output')
  
    filename = "output/thanks_#{id}.html"
  
    File.open(filename, 'w') do |file|
      file.puts form_letter
    end
  end

puts 'EventManager initialized.'

contents = CSV.open(
    'event_attendees.csv',
    headers: true,
    header_converters: :symbol
)

template_letter = File.read('form_letter.html')
erb_template = ERB.new template_letter

contents.each do |row|
    id = row[0]
    name = row[:first_name]
  
    zipcode = clean_zipcode(row[:zipcode])

    homephone = clean_numbers(row[:homephone])
  
    legislators = legislators_by_zipcode(zipcode)
  
    form_letter = erb_template.result(binding)

    save_thank_you_letter(id,form_letter)
end