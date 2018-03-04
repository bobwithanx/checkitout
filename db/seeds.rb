# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.destroy_all
Item.destroy_all
Group.destroy_all
Member.destroy_all
Loan.destroy_all

Category.create([{
                  name: 'Camera',
                  icon: 'fa fa-camera'
                },
                 { name: 'Tripod',
                   icon: 'iconpicker-icon-preview icon-settings' },
                 { name: 'Laptop',
                   icon: 'fa fa-laptop' },
                 { name: 'Microphone',
                   icon: 'fa fa-microphone' }])
p "Created #{Category.count} categories."

Item.create([{
              brand: 'Apple',
              name: 'MacBook Pro',
              serial_number: 'SN1234',
              inventory_tag: 'MBP-01',
              category_id: 3
            },
             { brand: 'Apple',
               name: 'MacBook Pro',
               serial_number: 'SN1235',
               inventory_tag: 'MBP-02',
               category_id: 3 },
             { brand: 'Apple',
               name: 'MacBook Pro',
               serial_number: 'SN1234',
               inventory_tag: 'MBP-03',
               category_id: 3 }])
p "Created #{Item.count} items."

Group.create([{ name: 'Admin' },
              {
                name: 'Film AM'
              },
              { name: 'Film PM' },
              { name: 'Other' }])
p "Created #{Group.count} groups."

Member.create([{
                first_name: 'James',
                last_name: 'Bond',
                id_number: '007',
                group_id: 4
              },
               { first_name: 'Bob',
                 last_name: 'Marquis',
                 id_number: '1',
                 group_id: 1 },
               { first_name: 'Van',
                 last_name: 'Halen',
                 id_number: '1984',
                 group_id: 4 }])
p "Created #{Member.count} members."
