require_relative("../db/sqlrunner.rb")
require_relative('tickets.rb')
require_relative('films.rb')

class Customer


attr_reader :id
attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (
          name,
          funds
          )
          VALUES ($1, $2)
          RETURNING id
          ;"
    values = [@name,@funds]
    result = SqlRunner.run(sql,values)

    @id = result[0]['id'].to_i
  end



def films()
  sql = "SELECT films.* FROM films
      INNER JOIN tickets
      ON tickets.film_id = films.id
      WHERE tickets.customer_id = $1"

  values = [@id]
  films = SqlRunner.run(sql,values)
  film_objects = films.map do |f|
    Film.new(f)
  end

  return film_objects

end

  def tickets()
    sql  = "SELECT * FROM tickets
            WHERE customer_id = $1"

    values = [@id]
    results = SqlRunner.run(sql,values)
    ticket_objects = results.map do |tickets|
      Ticket.new(tickets)
    end
  return ticket_objects
  end

#Extension #1
#----- Buying tickets should decrease the funds of the customer by the price
  def ticket_payment()
    array_tickets = self.films
    tickets = array_tickets.map do |c|
      c.price
    end
    ticket_sum = tickets.sum
    return @funds - ticket_sum

  end

 # Extension #2
# how many tickets a customer bought
  def number_ticket?()
    return self.tickets.count

  end

  def self.all()
    sql = "SELECT * FROM customers"

    customers = SqlRunner.run(sql)
    result = customers.map do |customers|
      Customer.new(customers)
    end
  return result
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

#------ UPDATE

    def update()

    sql = "UPDATE customers SET(
          name,
          funds
          ) = ($1, $2)
          WHERE id = $3;"
    values  = [@name, @funds, @id]
    SqlRunner.run(sql,values)
    end


end
