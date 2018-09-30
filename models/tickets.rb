require_relative("../db/sqlrunner.rb")


class Ticket

attr_reader :id, :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end






  def save()
    sql = "INSERT INTO tickets (
          customer_id,
          film_id
          )
          VALUES ($1, $2)
          RETURNING id
          ;"
    values = [@customer_id,@film_id]
    result = SqlRunner.run(sql,values)
    @id = result[0]['id'].to_i

  end

  def self.all()
    sql = "SELECT * FROM tickets"

    tickets  = SqlRunner.run(sql)
    result = tickets.map do |tickets|
      Ticket.new(tickets)
    end
  return result
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end


  def update()

  sql = "UPDATE tickets SET(
        customer_id,
        film_id
        ) = ($1, $2)
        WHERE id = $3;"
  values  = [@customer_id, @film_id, @id]
  SqlRunner.run(sql,values)

  end



end
