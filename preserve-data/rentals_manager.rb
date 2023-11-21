require 'json'

class RentalsManager
  attr_accessor :rentals

  def initialize
    @rentals = []
  end

  def load_rentals_data
    load_rentals
  end

  def save_data
    save_rentals
    puts 'rentals saved!'
  rescue StandardError => e
    puts "Error saving rentals data: #{e.message}"
  end

  def save_rentals
    File.open('rentals.json', 'w') do |file|
      file.puts @rentals.map { |person|
        {
          'id' => person.id,
          'age' => person.title,
          'name' => person.author
        }
      }.to_json
    end
  end

  private

  def load_rentals
    return unless File.exist?('rentals.json')

    json_str = File.read('rentals.json')
    @rentals = JSON.parse(json_str).map do |rentals_data|
      Rental.new(rentals_data['id'], rentals_data['age'], rentals_data['name'])
    end
  end
end
