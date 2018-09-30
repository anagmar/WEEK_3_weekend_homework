require_relative('models/customers.rb')
require_relative('models/films.rb')
require_relative('models/tickets.rb')
require_relative('models/screening.rb')
require('pry')


Customer.delete_all
Film.delete_all
Ticket.delete_all
Screening.delete_all

customer1 = Customer.new({
  'name' => 'Sylvain',
  'funds' => 10
  })

customer2 = Customer.new({
  'name' => 'Ana',
  'funds' => 8
  })

customer3 = Customer.new({
    'name' => 'Ines',
    'funds' => 9
    })


customer1.save
customer2.save
customer3.save

customers = Customer.all

film1 = Film.new({
  'title' => 'Incredibles 2',
  'price'=> 6
  })

film2 = Film.new({
    'title' => 'Ant Man and the Wasp',
    'price'=> 3
    })

film3 = Film.new({
  'title' => 'Solo',
  'price'=> 3
  })

film1.save
film2.save
film3.save

films = Film.all

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id
  })

ticket2 = Ticket.new({
    'customer_id' => customer1.id,
    'film_id' => film2.id
    })

ticket3 = Ticket.new({
    'customer_id' => customer2.id,
    'film_id' => film3.id
    })

ticket4 = Ticket.new({
    'customer_id' => customer3.id,
    'film_id' => film3.id
    })

ticket1.save
ticket2.save
ticket3.save
ticket4.save

tickets = Ticket.all

screening1 = Screening.new ({
  'film_id' => film1.id,
  'schedule' => "12:30",
  'number_tickets' => 4
  })

screening2 = Screening.new ({
    'film_id' => film2.id,
    'schedule' => "15:00",
    'number_tickets' => 3
    })

screening3 = Screening.new ({
      'film_id' => film3.id,
      'schedule' => "4:15",
      'number_tickets' => 1
      })

screening1.save
screening2.save
screening3.save

screenings = Screening.all


binding.pry
nil
