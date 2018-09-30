require_relative("../db/sqlrunner.rb")
require_relative('tickets.rb')
require_relative('customers.rb')

class Film

attr_reader :id
attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_i
  end

  def customers()
    sql = "SELECT customers.*
          FROM customers
          INNER JOIN tickets
          ON tickets.customer_id = customers.id
          WHERE tickets.film_id = $1"

    values = [@id]
    customers = SqlRunner.run(sql,values)
    customer_objects = customers.map do |f|
      Customer.new(f)
    end
    return customer_objects.to_a
  end

  def customers_name()
  return self.customers.name

  end

  def many_customers?
    return self.customers.count
  end


  def tickets()
    sql  = "SELECT * FROM tickets
            WHERE film_id = $1"

    values = [@id]
    results = SqlRunner.run(sql,values)
    ticket_objects = results.map do |tickets|
      Ticket.new(tickets)
    end
  return ticket_objects
  end





  def save()
    sql = "INSERT INTO films (
          title,
          price
          )
          VALUES ($1, $2)
          RETURNING id
          ;"
    values = [@title,@price]
    result = SqlRunner.run(sql,values)
    @id = result[0]['id'].to_i

  end

  def self.all()
    sql = "SELECT * FROM films"

    films  = SqlRunner.run(sql)
    result = films.map do |films|
      Film.new(films)
    end
  return result
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

#---- update

def update()

sql = "UPDATE films SET(
      title,
      price
      ) = ($1, $2)
      WHERE id = $3;"
values  = [@title, @price, @id]
SqlRunner.run(sql,values)
end



end
