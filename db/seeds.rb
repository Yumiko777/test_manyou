# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#  15.times do |n|
#    name = Faker::Games::Pokemon.name
#    email = Faker::Internet.email
#    password = "password"
#    User.create!(name: "User_name#{n + 1}",
#                 email: "User_email#{n + 1}@task.com" ,
#                 password: password,
#                )
#  end
#
# User.create!(name: "管理者",
#              email: "admin@sample.com" ,
#              password: "password",
#              admin: true
#              )

# 20.times do |n|
#  name = Faker::Games::Pokemon.name
#  detail = Faker::Games::Pokemon.location
#  deadline = Faker::Date.between(from: Date.tomorrow, to: 7.days.since)
#  status = ["0","1","2"]
#  priority = ["0","1","2"]
#  user_id = rand(1..16)
#  Task.create!(name: "User_name#{n + 1}",
#               detail: "User_detail#{n + 1}",
#               deadline: deadline,
#               status: rand(0..2),
#               priority: rand(0..2),
#               user_id: user_id
#               )
# end

# 10.times do |n|
#   Label.create!(name: "Label_name#{n + 1}" )
# end
name = Faker::Games::Pokemon.name
detail = Faker::Games::Pokemon.location
deadline = Faker::Date.between(from: Date.tomorrow, to: 7.days.since)
status = ["0","1","2"]
priority = ["0","1","2"]

email = Faker::Internet.email
password = "password"
n = 0
20.times do |n|

   User.create!(name: "User_name#{n + 1}",
               email: "User_email#{n + 1}@au.com" ,
               password: password
               )

   Task.create!(name: "User_name#{n + 1}",
                detail: "User_detail#{n + 1}",
                deadline: deadline,
                status: rand(0..2),
                priority: rand(0..2),
                user_id: rand(User.first.id..User.last.id)
                )
    Label.create!(name: "Label_name#{n + 1}" )

    Labeling.create!(task_id: Task.last.id,
                     label_id: Label.last.id
                    )
    n += 1
end
