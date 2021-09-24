# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

applications_text = File.read(Rails.root.join('lib', 'seeds', 'applications.csv'))
applications = CSV.parse(applications_text, :headers => true, :encoding => 'iso-8859-1')
applications.each do |row|
  a = Application.new
  a.client_id = row['clientId'];
  a.annual_income = row['annualIncome']
  a.monthly_debt = row['monthlyDebt']
  a.save
  puts row.to_hash
end


credit_text = File.read(Rails.root.join('lib', 'seeds', 'credit.csv'))
credit = CSV.parse(credit_text, :headers => true, :encoding => 'iso-8859-1')
credit.each do |row|
  c = Credit.new
  c.client_id = row['clientId']
  c.credit_score = row['creditScore']
  c.save
  puts row.to_hash
end

client_text = File.read(Rails.root.join('lib', 'seeds', 'clients.csv'))
clients = CSV.parse(client_text, :headers => true, :encoding => 'iso-8859-1')
clients.each do |row|
  c = Client.new
  c.id = row['id']
  c.first_name = row['first_name']
  c.last_name = row['last_name']
  c.email = row['email']
  c.save
  puts row.to_hash
end

