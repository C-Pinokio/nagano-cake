# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(email: "admin@example.com", password: "nagano2309")
Genre.create!(
  name: 'ケーキ',
)

Genre.create!(
  name: 'クッキー',
)

Item.create!(
  genre_id: 1,
  name: 'イチゴケーキ',
  introduction: 'とてもおいしいイチゴケーキです',
  without_tax: '1,000',
  is_active: true
)
Item.create!(
  genre_id: 2,
  name: 'バナナケーキ',
  introduction: 'とてもおいしいバナナケーキです',
  without_tax: '7,00',
  is_active: true
)