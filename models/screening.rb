
require_relative("../db/sqlrunner.rb")
require_relative('tickets.rb')
require_relative('films.rb')

class Screening

attr_reader :id,:film_id
attr_accessor :name, :schedule, :number_tickets



  def initialize(options)
    @id = options['id'].to_i
    @film_id= options['film_id'].to_i
    @schedule = options['schedule']
    @number_tickets = options['number_tickets'].to_i
  end

  def save()
    sql = "INSERT INTO screenings(
          film_id,
          schedule,
          number_tickets
          ) VALUES (
          $1, $2, $3)
          RETURNING id;"

    values = [@film_id, @schedule, @number_tickets]

    result = SqlRunner.run(sql,values)
    @id = result[0]['id'].to_i

  end

  # def film_name
  #   slq = "SELECT (titl"
  #
  # end



  def self.all()
    sql = "SELECT * FROM screenings"

    hash_screenings = SqlRunner.run(sql)
    object_screenings = hash_screenings.map do |c|
      Screening.new(c)
    end
    return object_screenings
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)

  end

  def update()
    sql = "UPDATE screenings SET(
          film_id,
          schedule,
          number_tickets
          ) = ($1, $2, $3)
          WHERE id = $4; "
    values = [@film_id, @schedule, @number_tickets, @id]
    SqlRunner.run(sql,values)
  end




end
