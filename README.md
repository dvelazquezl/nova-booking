# NOVA BOOKING
Mini Booking llamado Nova Booking :). 

Proyecto desarrollado en conjunto con compañeros del Octavo Semestre de la Facultad de Ingeniería de 
la Universidad Nacional de Itapúa - Paraguay. 

La aplicación esta alojada en Heroku, puedes verlo [aquí.](https://novabooking-production.herokuapp.com/)
## Instalación y ejecución
### Requerimientos
* Ruby (2.6.3)
* Rails (5.2.1)
* PostgreSQL (>= 10)
### Configuración
Descarga el proyecto en tu máquina local, configura el archivo `database.yml` con tu usuario y contraseña de 
PostgreSQL y ejecuta los siguientes comandos en tu CLI:
```
gem install bundler
bundle install
npm install
rails db:create
rails db:migrate
```
Luego, ejecuta `bundle exec rails s` y ve a [http://localhost:3000/.](http://localhost:3000/)