# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin_user = User.new
admin_user.email = "alexandra.lezcano@fiuni.edu.py"
admin_user.username = "AlexandraAdmin"
admin_user.name = "Alexandra"
admin_user.last_name = "Lezcano"
admin_user.password = "123456"
admin_user.password_confirmation = "123456"
admin_user.skip_confirmation!
admin_user.save!
#Add role
admin_user.add_role "admin"

admin_user = User.new
admin_user.email = "alan.bresani@fiuni.edu.py"
admin_user.username = "AlanAdmin"
admin_user.name = "Alan"
admin_user.last_name = "Bresani"
admin_user.password = "123456"
admin_user.password_confirmation = "123456"
admin_user.skip_confirmation!
admin_user.save!
#Add role
admin_user.add_role "admin"
