require 'json'

class PeopleManager
  attr_accessor :people

  def initialize
    @people = []
  end

  def load_people_data
    load_people
  end

  def save_data
    save_people
    puts 'People saved!'
  rescue StandardError => e
    puts "Error saving people data: #{e.message}"
  end

  def save_people
    File.open('people.json', 'w') do |file|
      file.puts @people.map { |person|
        {
          'id' => person.id,
          'age' => person.title,
          'name' => person.author
        }
      }.to_json
    end
  end

  private

  def load_people
    return unless File.exist?('people.json')

    json_str = File.read('people.json')
    @people = JSON.parse(json_str).map do |people_data|
      Person.new(people_data['id'], people_data['age'], people_data['name'])
    end
  end
end
